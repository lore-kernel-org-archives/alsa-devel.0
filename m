From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: intel8x0 has stopped working.
Date: Mon, 02 Feb 2004 19:42:37 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401EA82D.3060702@superbug.demon.co.uk>
References: <401E8BAE.6010802@superbug.demon.co.uk> <s5hn081uztv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA23102
	for <alsa-devel@alsa-project.org>; Mon, 2 Feb 2004 20:36:40 +0100
In-Reply-To: <s5hn081uztv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 02 Feb 2004 17:41:02 +0000,
> James Courtier-Dutton wrote:
> 
>>In alsa 0.9.8, the snd-intel8x0 worked find with my MB. An ICH5 with ALC650.
>>With alsa 1.0.2, I get: -
>>device: front -> no-sound output
>>device: surround40: -> Only sound on rear left, and rear right.
>>device: surround51: -> Only sound on rear left, and rear right, center, lfe
>>
>>So, in all cases there is never sound on the front speakers.
>>
>>The same problem has happened to a person with an ICH2, which only has 
>>front speakers, so they get no sound at all.
>>
>>I am investigating, and I suspect that the mixer has just lost the 
>>mixer/mute for the front speakers.
> 
> 
> hmm, it looks like a generic problem of intel8x0 with ALC65x.
> in the recent version, the detection and implementation of PCM streams
> have been changed, and i guess it's broken for these codecs.
> 
> 
> 
>>Is there a tool where I can adjust ac97 registers directly through a 
>>IOCTL or something, for test purposes?
> 
> 
> 	% cat /proc/asound/card0/codec97#0/ac97#0-0+regs
> 
> we'll need to trace the behavior in snd_ac97_pcm_*() functions...
> 
> 
> Takashi
> 
> 
Ok, the front channel is now working, but I don't know why.
One thing that is definitely broken is sample rate conversion.
E.g. Open card at rate 44100, device="hw:0", fails saying rate 44100 not 
supported.
Open card at rate 48000, device="hw:0" works.
Now, open card at rate 44100, device "plughw:0" succeeds, but then the 
snd_pcm_writei() calls just hangs at poll()

#0  0x401a5ab8 in *__GI___poll (fds=0x402049a8, nfds=1, timeout=-1) at 
../sysdeps/unix/sysv/linux/poll.c:82
#1  0x4006abd4 in snd_pcm_wait (pcm=0x8054630, timeout=-4) at pcm.c:2044
#2  0x400706f8 in snd_pcm_write_areas (pcm=0x8054630, areas=0xbfffe9d4, 
offset=0, size=71, func=0x4007a480 <snd_pcm_plugin_write_areas>)
     at pcm.c:6041
#3  0x4007a88d in snd_pcm_plugin_writei (pcm=0x8054630, 
buffer=0xfffffffc, size=4294967292) at pcm_plugin.c:436
#4  0x40068dd7 in snd_pcm_writei (pcm=0x7fffffff, buffer=0x8054810, 
size=1) at pcm_local.h:368
#5  0x080495e0 in write_loop (handle=0x80544b8, channel=0, periods=3105, 
samples=0x8054810) at speaker-test.c:289
#6  0x08049b73 in main (argc=4, argv=0xbfffee54) at speaker-test.c:445


Once thing I have noticed, is that with the alc650, we used to have VRA 
(alsa 0.9.8), but the 1.0.2 intel8x0 driver ignores the VRA and fixes 
itself at 48000.
So, before I never needed the sample rate converters, but as it now 
fixes the rate at 48000, I need the sample rate converters, and they 
don't actually work.





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
