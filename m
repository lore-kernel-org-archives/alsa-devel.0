From: Gerald Grabner <gerald.grabner@gmx.net>
Subject: Re: quit snd_pcm_readi, retrieve pending frames
Date: Sun, 04 Jun 2006 13:51:21 +0200
Message-ID: <4482C939.3070002@gmx.net>
References: <4465BDCB.7010900@gmx.net>	<s5h3bfbwqiw.wl%tiwai@suse.de>	<s5hpsic3cza.wl%tiwai@suse.de>	<loom.20060519T230916-804@post.gmane.org>	<s5hiro0n8te.wl%tiwai@suse.de>	<446F640A.20802@gmx.net>
	<s5hr72mmjdi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr72mmjdi.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 20 May 2006 20:46:34 +0200,
> Gerald Grabner wrote:
>> Takashi Iwai wrote:
>>> At Fri, 19 May 2006 21:17:45 +0000 (UTC),
>>> Gerald Grabner wrote:
>>>> Takashi Iwai <tiwai <at> suse.de> writes:
>>>>> At Mon, 15 May 2006 12:06:47 +0200,
>>>>> I wrote:
>>>>>> At Sat, 13 May 2006 13:06:51 +0200,
>>>>>> Gerald Grabner wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm experimenting with the ALSA PCM API and was wondering whether
>>>>>>> there is a simple way to exit a record loop by stopping the pcm, but
>>>>>>> without loosing pending frames.
>>>>>>>
>>>>>>> Initially, I was thinking of something like this, where I would call
>>>>>>> snd_pcm_drop(pcm) from some other thread:
>>>>>>>
>>>>>>>    while ( true )
>>>>>>>      {
>>>>>>>        r = snd_pcm_readi (pcm, data, frames);
>>>>>>>        fwrite (data, 2, 2*r, file);
>>>>>>>        if ( r != frames )
>>>>>>>          break;
>>>>>>>      }
>>>>>>>
>>>>>>> However, snd_pcm_drain(pcm) doesn't work here; the loop continues.
>>>>>>> snd_pcm_drop(pcm) breaks the loop, but pending frames are lost, and
>>>>>>> r=-EBADFD.
>>>>>>>
>>>>>>> Is there an easy way to stop snd_pcm_readi in a way that I can
>>>>>>> retrieve the residual frames? Do I need to set any parameters for
>>>>>>> that purpose?
>>>>>> If you're using hw or plughw, it's likely a bug in alsa-driver.
>>>>>> Try the patch below.
>>>>> Actually the patch was also wrong.  snd_pcm_drain() shouldn't wait for
>>>>> the capture streams.  So, the patch becomes pretty simple like below.
>>>>> I'll commit it to HG repo.
>>>>>
>>>>> Takashi
>>>>>
>>>>> diff -r 44d28ed5d3d5 core/pcm_native.c
>>>>> --- a/core/pcm_native.c	Wed May 17 11:26:39 2006 +0200
>>>>> +++ b/core/pcm_native.c	Wed May 17 17:07:17 2006 +0200
>>>>>  <at>  <at>  -1469,8 +1469,6  <at>  <at>  static int snd_pcm_drain(
>>>> struct snd_pcm_
>>>>>  		}
>>>>>  	}
>>>>>  	up_read(&snd_pcm_link_rwsem);
>>>>> -	if (! num_drecs)
>>>>> -		goto _error;
>>>>>
>>>>>  	snd_pcm_stream_lock_irq(substream);
>>>>>  	/* resume pause */
>>>> Hi Takashi,
>>>>
>>>> there seems to be some problem with this patch (the short one). After
>>>> recompiling the kernel (and my application), my application doesn't
>>>> exit and I can't kill it anymore. The pcm device is kind of lost. See
>>>> below for the /var/log/messages entry.
>>> Hmm, according the error message below, I suspect it's something
>>> different since the patch isn't so intrusive.
>>>
>>> Could you test again after reverting the patched part?
>> After recompiling the kernel with the original source, the problem
>> disappeared.
> 
> OK, could you try the patch below?
> 
> 
> thanks,
> 
> Takashi
> 
> 
> ------------------------------------------------------------------------
> 
> diff -r 18da48cda4cc core/pcm_native.c
> --- a/core/pcm_native.c	Mon May 22 12:05:42 2006 +0200
> +++ b/core/pcm_native.c	Mon May 22 12:39:22 2006 +0200
> @@ -1381,7 +1381,8 @@ static int snd_pcm_do_drain_init(struct 
>  		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING) {
>  			int state = snd_pcm_capture_avail(runtime) > 0 ?
>  				SNDRV_PCM_STATE_DRAINING : SNDRV_PCM_STATE_SETUP;
> -			snd_pcm_do_stop(substream, state);
> +			substream->ops->trigger(substream,
> +						SNDRV_PCM_TRIGGER_STOP);
>  			snd_pcm_post_stop(substream, state);
>  		}
>  	}

With this patch, I don't run into the same problem as with the last
one, i.e. there are no error messages.

However, it still doesn't do what I want - which is most probably my
own fault. In my program, there is one thread like this:

     while ( true )
       {
         r = snd_pcm_readi (pcm, data, frames);
         fwrite (data, 2, 2*r, file);
         if ( r != frames )
           break;
       }

My idea was to arrive at the break statement by calling
snd_pcm_drain(pcm) from another thread, but without loosing the
pending frames. If I understood Clemens Ladisch correctly, I will have
to use poll() for that purpose...

Thx,
Gerald
