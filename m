From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: intel ICH sample rate
Date: Sat, 27 Dec 2003 16:09:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312272109.hBRL9TVD031711@dhin.linuxaudiosystems.com>
References: <Pine.LNX.4.58.0312272046580.25504@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 27 Dec 2003 20:49:50 +0100."
             <Pine.LNX.4.58.0312272046580.25504@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>yOn Sat, 27 Dec 2003, Paul Davis wrote:
>
>> >i've been getting my laptop with an ICH soundchip up to speed, and i
>> >just noticed for the first time yesterday that ALSA fails to get the
>> >speed to the rate that JACK requests. a quick google reveals that the
>> >OSS drivers only support 1 h/w rate, but there are suggestions that
>> >the ALSA driver works better. however, neither JACK nor alsaplayer can
>> >set the rate on my card to 44.1kHz - its stuck at 48kHz.
>> >
>> >this is alsa 1.0.0rc2 from Planet CCRMA. any clues?
>> 
>> this is using the snd-intel8x0 module. the wiki page has alerted me to
>> the ac97_clock option, but it seems ludicrous to have to rmmod &&
>> modprobe the module just to switch rates ...
>
>The ac97_clock option is for situation when another master clock crystal
>than standard one is used by hardware vendor. You cannot change the real
>rate with this option.
>
>It seems that your AC97 codec does not support VRA (variable rate) so it 
>is capable only 48kHz or we have a bug somewhere.
>
>Can you send me contents of /proc/asound/card0/codec97* files?

i am entirely willing to believe that it can only do 48kHz. its a
laptop (HP Pavilion), well known for having crapola audio interfaces
and relying on s/w to make things work. here's the codec97* file
(below).

meanwhile, i have found that the plughw layer doesn't work with JACK
anymore. it appears that any attempt to set the period size fails. any
ideas about that?

--p

0-0/0: Conexant id 30

Capabilities     : -reserved1- -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 AMAP DSA=0 SPDIF
Extended status  : PRL PRK PRJ PRI SPCV SPDIF=7/8
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
Extended modem ID: codec=0 LIN1
Modem status     : PRA(GPIO)
Line1 rate       : 48000Hz
0:00 = 0152
0:02 = 0404
0:04 = 9f1f
0:06 = 0000
0:08 = 0000
0:0a = 8000
0:0c = 0000
0:0e = 801f
0:10 = 9f1f
0:12 = 0303
0:14 = 0000
0:16 = 0000
0:18 = 0404
0:1a = 0101
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0a04
0:2a = 7c10
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2824
0:3c = 0001
0:3e = 0100
0:40 = bb80
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0030
0:4e = ffff
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0600
0:5e = 8001
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 8004
0:7c = 4358
0:7e = 5430


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
