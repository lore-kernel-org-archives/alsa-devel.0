From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: PCM format restrict dilema
Date: Tue, 16 Sep 2003 19:10:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F675208.8090409@superbug.demon.co.uk>
References: <1063721993.1556.12.camel@localhost> <s5hd6e08z6c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6e08z6c.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 16 Sep 2003 10:19:53 -0400,
> Manuel Jander wrote:
> 
>>Hello,
>>
>>I have the following dilema. The Aureal Vortex DMA engine supports
>>upto 4 hardware pages, but they have to be frame aligned. The current
>>driver also needs them to be of the same size. To archive this, i added
>>the following code in the pcm "open" function.
>>
>>/* Force equal size periods */
>>if ((err = snd_pcm_hw_constraint_integer(runtime,
>>SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
>>return err;
>>/* Force DMA 32 bit alignment */
>>if ((err = snd_pcm_hw_constraint_step(runtime, 0,
>>SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 4)) < 0)
>>return err;
>>
>>Now PCM works correctly, but some apps, like aplay fail to play some
>>formats, because they get their period size requirementes rejected, and
>>they just give up instead of trying other period sizes. Since aplay uses
>>a time based criteria for the period sizes instead of "sane" values, the
>>period sizes are very odd.
> 
> 
> yes, this is a known issue.
> recently i've talked with Jaroslav about this theme, and we agreed
> that it's a design flaw of the current configurator system.
> 
> 
>>The question is, should i blame aplay or try to implement some
>>workaround in the Aureal driver ??
> 
> 
> i fixed aplay recently to allocate the period size first.
> this works better than the former way (buffer -> period).
> please try the cvs version.
> 
> about the influence of this bug: 
> AFAIK, very rare applications use the time-based period/buffer size,
> so this is not critical.  strangely enough, aplay is an exception :)
> 
> (btw, aplay has also options to specify the buffer/period sizes in
> frames, but the time-based values are used as default.)
> 
> 
> Takashi
> 

I help develop an application called xine.
We wish to use the function: -
dir=0;
err = snd_pcm_hw_params_set_buffer_time_near(this->audio_fd, params, 
&buffer_time, &dir);

We then try to set the period size to buffer_size / 8.

I have already found out that not all audio devices like an interger 
amount of periods, so this can fail in some circumstances.

I have two problems: -
1) Once one sets the buffer size, and then tries to set the period size 
near, and fails. One would think that one could then go back a try a 
different buffer size, but I have found this does not work.
2) The different combinations of setting period_size/time and 
buffer_size/time and the dependence between them seems to be very 
difficult to achieve for all sound cards.

I want to try and aim at 8 periods per buffer.
Common sense would tell me that one should be able to set the buffer 
size first, and then try to set the period size to buffer_size/8. But I 
should be able to use the set_period_size_near call so that it selects 
the next closest value, so that I achieve a result as close as possible 
to what I want. This seems to fail with the current setup on some sound 
cards, but works with other sound cards.

Can I assume that this is a bug in alsa, or some deeper issue.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
