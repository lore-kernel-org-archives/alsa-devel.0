From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: The different STATES of ALSA
Date: Sun, 31 Jul 2005 15:17:44 +0100
Message-ID: <42ECDD88.5010805@superbug.co.uk>
References: <20050731133552.GA13386@brailcom.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 873A0158
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 16:17:45 +0200 (MEST)
In-Reply-To: <20050731133552.GA13386@brailcom.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hynek Hanke <hanke@brailcom.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hynek Hanke wrote:
> Hi everyone,
> 
> I'm having very much troubles programming an ALSA interface because the
> documentation is pretty poor. I'm very much confused about the different states
> in alsa-lib.
> 
> (After I was told alsa-lib is not thread-safe and there is some bug in the kernel
> implementation of the underlaying calls of snd_pcm_writei(), I'm now running the
> non-blocking/polling approach).
alsa-lib is perfectly thread-safe.
The non-blocking/polling or "callback" approach is by far the most 
efficient and best way to talk to a sound card.

Generally you should use:
open
set hw_params
set sw_params
fill some of the sound buffer then do snd_pcm_start() or set sw_params 
to autostart for you.
Then use poll(), check state(xrun recover) and then writei() for sound 
output.

> 
> My questions:
> 
> 1) In which states am I allowed to call
> 	a) snd_pcm_hw_params_any
Only after snd_pcm_open() and snd_pcm_hw_params_alloca(&params);
> 	b) snd_pcm_hw_params
Only after you have done all the snd_pcm_hw_params_xxx() to set 
different HW params.
This must happen before any snd_pcm_sw_params and before the stream is 
prepared or started.
> 	c) snd_pcm_prepare
After an xrun(for xrun recovery) or after hw and sw params have been set up.

> 	d) snd_pcm_drop and _drain
At any time while the stream is in RUNNING state.
It returns depending on block/non-block state.

> 
> 2) Which states do they bring me to, if they don't return an error?
a) SND_PCM_STATE_OPEN
b) SND_PCM_STATE_SETUP
c) SND_PCM_STATE_PREPARED
d) SND_PCM_STATE_DRAINING

The way to reach SND_PCM_RUNNING depends on the sw_params and calls to 
snd_pcm_writei() and snd_pcm_start().

> 
> 3) How is it possible that snd_pcm_drain returns with a success value *and*
>    the snd_pcm_state() still reports SND_PCM_STATE_DRAINING ? Is this a bug?
This depends on block/non-block status.
snd_pcm_nonblock()

> 
> 4) How is it possible, that the whole time a sound is played snd_pcm_writei()
>    never returns the value -EPIPE and still, when checking the state before
>    playing the next sound, I find the device in the SND_PCM_STATE_XRUN
>    (snd_pcm_drain() gets called in the meantime).
This depends on sw_params and block/non-block status.
You can configure the device to automatically exit XRUN state whenever a 
snd_pcm_writei() is called, although this is probably only wanted for 
extremely simple apps. Most apps will want a separate XRUN recovery feature.

> 
> The problems (3) and (4) seem to arrise only under some circumstances, possibly
> when more sounds are played in a quick succession.
> 
> Thank you for help,
> Hynek Hanke
> 

sound card programming is rather complicated. the alsa api allows for 
about 6 different programming models which is why it might seem complicated.
Now, the universally best method for programming the sound card and 
sending samples to it is the callback method. This method is quite 
complicated to achieve and requires a very good knowledge of how sound 
cards work. Luckily, a 3rd party application hides all this complexity 
from the programmer. You might want to look into it. It is called jackd.

James


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
