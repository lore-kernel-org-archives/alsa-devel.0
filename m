From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: negative timestamps on pcm?!?
Date: Tue, 21 Oct 2003 10:05:26 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F956756.607@pianodisc.com>
References: <3F9423E9.2040409@pianodisc.com> <s5hvfqidh15.wl@alsa2.suse.de>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfqidh15.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> 
> when the state is OPEN, these values are bogus, since snd_pcm_status()
> returns immediately without putting the values.
> 

So, alsa writes bogus data to the proc entries?  Maybe it shouldn't 
write bad data, just leave the spots blank, initilize with 0's or 
something else?

>>-----
>>hw_ptr      : 26942906
>>appl_ptr    : 26942906
> 
> 
> they are real values.
> 
> 
> i can't remember any reason of the restriction above.
> i think it's ok to remove it.
> 

What restriction is that?

>>It seems that our ogg player is set to blocking behavior and each one is 
>>blocked on the call to open the pcm.  The intrieging thing is the 
>>timestamp is negative.  It jumped out that this just looks wrong!
>>
>>Hypothesis 1:  After a really long time playing, the timestamp on the 
>>pcm wraps to negative.  alsa can't handle this and blocks on the output. 
>>  It's no longer running, but is still in an OPEN state so nothing else 
>>can open it.  alsa should either use an unsigned value so large that it 
>>is impossable to overflow (???), use an unsigned and detect overflow and 
>>handle it gracefully, or use a signed value and detect the overflow/wrap 
>>and handle it.
>>Hypothesis 2:  We're barking up the wrong tree and the only thing wrong 
>>is that the proc entry is formmated poorly.  (but even if that is the 
>>case, the problem still happens where after prolonged time alsa stops us).
> 
> 
> at least, the values above make no sense.

Right, the values make no sense, but I think we've explained that away 
now.  So, what is causing alsa to eventually stop playing right?  Yes, 
that's not exactly a fair question... where should we start looking? 
Maybe a mutex, race condition, or an off-by-one error somewhere?

> 
> which version of ALSA driver are you using?
> 

Driver: 0.9.7c
Library: 0.9.7
(retrieved from the website just a few days ago)

Thanks,
- Steve



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
