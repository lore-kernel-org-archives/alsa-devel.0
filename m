From: Tim Goetze <tim@quitte.de>
Subject: Re: snd_pcm_close hangs
Date: Sat, 1 Jun 2002 13:22:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0206011255270.661-100000@summer.quitte>
References: <Pine.LNX.4.21.0206010211270.668-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA17615
	for <alsa-devel@alsa-project.org>; Sat, 1 Jun 2002 13:22:16 +0200
In-Reply-To: <Pine.LNX.4.21.0206010211270.668-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

me wrote:

>me wrote:
>
>>me wrote:
>>
>>>Takashi Iwai wrote:
>>>
>>>>At Thu, 30 May 2002 17:14:03 +0200 (CEST),
>>>>Tim Goetze wrote:
>>>>> 
>>>>> hi all,
>>>>> 
>>>>> both emu8k and ice1712 pcm drivers hang forever in ioctl(2) when
>>>>> closing a playback stream if the stream has been linked to the 
>>>>> same card's capture, has been prepared and written data to, but was
>>>>> never started:
>>>>> 
>>>>> Program received signal SIGINT, Interrupt.
>>>>> 0x403b8fa4 in ioctl () from /lib/libc.so.6
>>>>> (gdb) bt
>>>>> #0  0x403b8fa4 in ioctl () from /lib/libc.so.6
>>>>> #1  0x40580abc in __DTOR_END__ () from /usr/lib/libasound.so.2
>>>>> #2  0x4053bde9 in snd_pcm_drain (pcm=0x81c6ae8) at pcm.c:813
>>>>> #3  0x4053b649 in snd_pcm_close (pcm=0x81c6ae8) at pcm.c:552
>>>>> #4  0x40462d79 in AlsaStream::~AlsaStream (this=0x81bf6a8,
>>>>> __in_chrg=0)
>>>>>     at AlsaStream.cc:41
>>>>> #5  0x4049ef01 in AlsaOut::~AlsaOut (this=0x81bf6a8, __in_chrg=3)
>>>>>     at PyType.h:110
>>>>
>>>>it seems stalling at drain ioctl.  can you figure out which stream is?
>>>
>>>playback. 
>>
>>a playback stream not linked to any other stream behaves the same.
>>
>>before calling snd_pcm_close(), i get
>>
>>[~] cat /proc/asound/ice/pcm0p/sub0/status 
>>state: PREPARED
>>trigger_time: 0.000000
>>tstamp      : 1022886544.305384
>>delay       : -1053620964
>>avail       : 0
>>avail_max   : 0
>>
>>this is what happens in snd_pcm_playback_drain() when i call
>>snd_pcm_close() now:
>>
>>the stream is started ok. the stream state is then switched to
>>SNDRV_PCM_STATE_DRAINING and then the interruptible loop waiting for
>>the stream to go to a different state is running forever because
>>stream->state remains 5 = SNDRV_PCM_STATE_DRAINING. 
>
>since state never changes, i checked what happens when the card is
>firing an interrupt. following the code path, i think the only point
>the state can be changed is in snd_pcm_update_hw_ptr_interrupt()
>where 'avail' is checked against 'runtime->stop_threshold'. if this
>value is the same as stop_threshold in 
>
>[~] cat /proc/asound/ice/pcm0p/sub0/sw_params 
>tstamp_mode: NONE
>period_step: 1
>sleep_min: 0
>avail_min: 2048
>xfer_align: 2048
>start_threshold: 4294967295
>stop_threshold: 4294967295
>silence_threshold: 0
>silence_size: 0
>boundary: 1073741824
>
>then it will take quite some time to reach (not forever though).
>
>i modified my code to set stop_threshold to exactly ring buffer size,
>and a playback stream alone closes on the ice within short time. on
>the awe (at 128 frames) snd_pcm_close() hangs for a few seconds and
>then i get: 
>
>pcm.c:656: snd_pcm_hw_free: Assertion `snd_pcm_state(pcm) ==
>SND_PCM_STATE_SETUP || snd_pcm_state(pcm) == SND_PCM_STATE_PREPARED'
>failed.
>
>and
>
>[~] cat /proc/asound/awe64/pcm0p/sub0/status    
>state: DRAINING
>trigger_time: 1022892601.216727
>tstamp      : 1022892616.804303
>delay       : -687208
>avail       : 687464
>avail_max   : 687464
>
>i modified my code to again use capture and playback in a linked setup
>with the new stop_threshold, and now i get the same assertion failure
>on both cards, plus:
>
>Jun  1 02:20:31 localhost kernel: ALSA pcm_native.c:654: snd_pcm_stop
>bogus call from c88e9239?
>Jun  1 02:21:02 localhost last message repeated 10529 times
>
>etc etc, on both cards.
>
>giving up. i hope i've gathered enough clues, and expressed them
>clearly enough, for somebody with more insight to fix this. en tout
>cas, the bug(s) can be easily reproduced and most probably isn't
>limited to the specific cards here.

here's yet another clue: after running the ice (linked cap +
play) with the new stop_threshold, stopping the streams and then
closing them, my alsa_error_handler says:

pcm_hw.c:282 (snd_pcm_hw_drain): SNDRV_PCM_IOCTL_DRAIN failed, err =
Input/output error (AlsaStream.cc:18)

and, again,

Jun  1 12:49:22 localhost kernel: ALSA pcm_native.c:654: snd_pcm_stop
bogus call from c88e9239?
Jun  1 12:49:53 localhost last message repeated 10676 times

can you enlighten me why it is at all necessary to drain a stream
before closing it?

tim


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
