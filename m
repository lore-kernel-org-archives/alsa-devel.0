From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: snd_pcm_wait()  More details required.
Date: Mon, 22 Mar 2004 17:31:24 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405F22EC.5070104@superbug.demon.co.uk>
References: <405DAB5C.5010106@superbug.demon.co.uk> <Pine.LNX.4.58.0403221055520.1808@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA08456
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 18:27:17 +0100
In-Reply-To: <Pine.LNX.4.58.0403221055520.1808@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
>>
>>So, when is a PCM ready?
>>If a PCM is already in SND_PCM_STATE_RUNNING, when is snd_pcm_wait() 
>>supposed to return ?
> 
> 
> When avail >= avail_min.

1) Does this depend on period size in any way?
For example, if period size is 6000 frames, and I set avail_min to 2000 
frames, will snd_pcm_wait() return when avail=2000 or avail=6000 ?
Another example, if persiod size is 1500, and I set avail_min to 2000, 
will snd_pcm_wait() return when avail=200 or avail=3000 (2*1500)?

2) Is snd_pcm_wait() a call that uses little or no CPU time, much like a 
poll?

3) It appears from the docs that I can set avail_min at any time, even 
in SND_PCM_STATE_RUNNING.
commands to set it would be: -
snd_pcm_sw_params_current(this->audio_fd, swparams);
snd_pcm_sw_params_set_avail_min(this->audio_fd, swparams, 
new_avail_min_size);
snd_pcm_sw_params(this->audio_fd, swparams);

or is there a better way to do it while in SND_PCM_STATE_RUNNING ?

4) If snd_pcm_wait() is waiting, and with another thread we change the 
avail_min value, will the snd_pcm_wait() use the new value, or is the 
new value only used on the next call to snd_pcm_wait()

> 
> 
>>I have discovered a problem with xine when using it. I have done a work 
>>around in xine so that dmix now works in xine. I think that my 
>>assumptions regarding snd_pcm_wait() might have been wrong, so I want to 
>>  get accurate details from yourselves.
>>It also might be a good idea to update the documentation for 
>>snd_pcm_wait() with more details.
> 
> 
> We had a bug in the resample plugin which causes that snd_pcm_wait() 
> function was broken. Try alsa-lib from CVS.

My current tests were not using the resampler. i.e. app using 48k, sound 
card using 48k. I will try some tests that would use the resampler.

> 
> 						Jaroslav
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
