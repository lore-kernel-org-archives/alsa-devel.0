From: Tim Goetze <tim@quitte.de>
Subject: Re: via82xx 1.0.0rc1 experience
Date: Thu, 4 Dec 2003 15:04:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312041424210.458@autumn>
References: <Pine.LNX.4.58.0312041139490.458@autumn> <s5hsmk0ai7r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmk0ai7r.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>> <modules.conf>
>> options snd-via82xx index=0 id=ac97 ac97_clock=48000 dxs_support=2
>> </modules.conf>
>>
>> other dxs_support values cause block-size *and* erratic distortion in
>> the output sound. ac97_clock=44100 causes slowed-down playback.
>
>ok, i'll add dxs_support=2 as default for your board.
>(still i'm wondering dxs_support=1 or 4 might work.)

dxs_support=1 produces garbled sound.
dxs_support=4 works ok!

iirc it didn't with the shared interrupt line, want me to try again?
i'm not in the mood for rebooting right now if it needn't be.

tried playing three 16-bit stereo 44.1 kHz streams via OSS-emulation
in parallel, it works. amazing!

>as default, ac97_clock is 48000, so you don't need to specify it.
>a different ac97_clock shouldn't be given unless the chip is really
>driven in that clock.

ok, i was suspecting so.

>> however, to enable analog output (only one present on the board) the
>> mixer controls for 'headphone' not 'master' must be unmuted (volume
>> and playback switch). since they aren't accessible from alsamixer this
>> had me puzzling for a while.
>
>please show /proc/asound/card0/codec97#0/* files.

follows at the end of this mail (module loaded with dxs_support=4).

>thanks for the feedback.

thanks for the quick answer. :)

tim

ps: `cat /proc/asound/card0/codec97#0/*`
0-0/0: VIA Technologies VIA1612A

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : IC Ensemble/KS Waves

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
0:00 = 6d50
0:02 = 8808
0:04 = 0808
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0808
0:1a = 0000
0:1c = 8000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0201
0:2a = 0001
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 8230
0:5c = 0010
0:5e = f7ff
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
0:7a = 0000
0:7c = 5649
0:7e = 4161



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
