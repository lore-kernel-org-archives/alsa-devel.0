From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: additional problem
Date: Wed, 13 Jul 2011 10:25:31 -0400
Message-ID: <4E1DAADB.202@digital-pipe.com>
References: <4E0B2F67.3070304@digital-pipe.com>	<4E0C68ED.1070506@digital-pipe.com>	<s5hiprmijtw.wl%tiwai@suse.de>	<4E1B07FD.9030702@digital-pipe.com>	<s5h1uxwkhcx.wl%tiwai@suse.de>	<4E1B1127.4080800@digital-pipe.com>	<s5htyasj1gi.wl%tiwai@suse.de>	<4E1B12FF.4080307@digital-pipe.com>	<s5hr55wj17k.wl%tiwai@suse.de>	<4E1B15EE.8080304@digital-pipe.com>	<s5hoc10izl3.wl%tiwai@suse.de>	<4E1C469B.4050400@digital-pipe.com>	<s5hd3hfiqvc.wl%tiwai@suse.de>	<4E1C4C8A.50703@digital-pipe.com>	<4E1D9A4F.503@digital-pipe.com>
	<s5h39ianuh1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D5C724489
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 16:27:46 +0200 (CEST)
Received: by gyc15 with SMTP id 15so2557288gyc.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2011 07:27:45 -0700 (PDT)
In-Reply-To: <s5h39ianuh1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/13/2011 10:08 AM, Takashi Iwai wrote:
> At Wed, 13 Jul 2011 09:14:55 -0400,
> David Henderson wrote:
>>> Thanks again for the help Takashi.  Ok, I've created the
>>> /etc/asound.conf file with the appropriate group and now I'm trying to
>>> run the aplay binary and I'm not getting any error messages, but I'm
>>> also not hearing any sounds from the speakers.
>>>
>>> # aplay freq10-30000-10s.wav
>>> Playing WAVE 'freq10-30000-10s.wav' : Signed 16 bit Little Endian,
>>> Rate 44100 Hz, Mono
>>>
>>> # speaker-test -w ./freq10-30000-10s.wav
>>>
>>> speaker-test 1.0.23
>>>
>>> Playback device is default
>>> Stream parameters are 48000Hz, S16_LE, 1 channels
>>> Using 16 octaves of pink noise
>>> Rate set to 48000Hz (requested 48000Hz)
>>> Buffer size range from 2048 to 8192
>>> Period size range from 1024 to 1024
>>> Using max buffer size 8192
>>> Periods = 4
>>> was set period_size = 1024
>>> was set buffer_size = 8192
>>>   0 - Front Left
>>> Time per period = 2.835792
>>>   0 - Front Left
>>> Time per period = 2.986653
>>>   0 - Front Left
>>> Time per period = 2.986654
>>>   0 - Front Left
>>> ...snip...
>>>
>>> I've made sure nothing is muted with the audio hardware by using
>>> alsamixer and changed the permissions on the files within the /etc/snd
>>> directory.  Any other thoughts?
>>>
>>> Dave
>> bump for help
> You didn't give any useful information about the hardware itself, so
> no one can answer.  Did it ever sound correctly with any other distro
> at all?
>
> Please don't mix up the custom-build problem and the driver problem.
> The problem with silent output is more likely a driver issue (or a
> configuration issue).
>
>
> Takashi

The hardware is an integrated HDA Intel audio sound card.  The 
/proc/asound/pcm file has this listed:

00-00: STAC92xx Analog : STAC92xx Analog : playback 1 : capture 2
00-01: STAC92xx Digital : STAC92xx Digital : playback 1
00-03: INTEL HDMI 0 : INTEL HDMI 0 : playback 1

Yes, this audio works just fine within Kubuntu.  Here is the output from 
the 'lsmod' binary:

# lsmod
Module                  Size  Used by    Not tainted
snd_hda_codec_intelhdmi    11040  1
snd_hda_codec_idt      30668  1
snd_hda_intel          14480  0
snd_hda_codec          33296  3 
snd_hda_codec_intelhdmi,snd_hda_codec_idt,snd_hda_intel
snd_pcm                37628  2 snd_hda_intel,snd_hda_codec
snd_page_alloc          4016  2 snd_hda_intel,snd_pcm
snd_timer              10564  1 snd_pcm
snd                    26200  6 
snd_hda_codec_intelhdmi,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
soundcore               2640  1 snd
e1000e                 82016  0
video                  12712  0
output                   724  1 video
backlight               1632  1 video
hid_logitech            2872  0
serio_raw               2380  0

Seems to be getting the drivers loaded correctly, I just have no idea 
why it's not playing.  Also, if I'm missing information to help with a 
question, please don't just ignore it, but ask me for whatever 
information you need to help resolve the problem.  Sometimes I forget to 
include certain information or don't know what to post so any of the 
people here can help fix the issue. :)  You guys have waaaaaay more 
knowledge about this than I do after all. :)

Thanks,
Dave
