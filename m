From: Carsten Koch <Carsten.Koch@icem.com>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
Date: Mon, 01 Sep 2003 19:57:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F538893.1010801@icem.com>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com>	<s5hllt8oaye.wl@alsa2.suse.de>	<3F535A42.6020403@icem.com>	<s5hekz0o7wi.wl@alsa2.suse.de>	<3F536C97.5080008@icem.com> <s5hbru4o444.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbru4o444.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
...
>>Unfortunately, the sound is playing too fast with plughw:0,1 as well.
> 
> 
> please check /proc/asound/card1/pcm0p/sub0/hw_params during playback.

vdr:~ # head /proc/asound/card?/pcm?p/sub?/hw_params
==> /proc/asound/card0/pcm0p/sub0/hw_params <==
closed

==> /proc/asound/card0/pcm1p/sub0/hw_params <==
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 1024
buffer_size: 8192
tick_time: 10000

> if it shows 44100, perhaps spdif configuration doesn't match with the
> request one.  please check the spdif status in
> /proc/asound/card/ac97#0, too.

vdr:~ # head -99 /proc/asound/card?/ac97#0
0-0/0: Realtek ALC650 rev 0

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=7/8 SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x2 Generation=1 Rate=44.1kHz


> you can overwrite the default pcm in ~/.asoundrc with '!' prefix.
> for example,
> 
> 	pcm.!default "hw:0,1"

That syntax did not work. It gives me the error message:
ALSA lib pcm.c:1787:(snd_pcm_open_conf) Invalid type for PCM default definition (id: default, value: hw:0,1)

I changed it to

pcm.!default {
         type hw
         card 0
         device 1
}

Should that have the same effect?
At least I can now omit the -d parameter for alsaplayer and the sound is still
coming out of the SPDIF output (still too fast, though, see above).
I can also control the volume via alsaplayer's slider.
However, the alsamixer volume control has no effect and kde desktop sounds
(i.e. typing ^G) do not work.
As I am not really using the analog output, it would be fine with me to
simply delete/deactive/hide the analog output PCM device, so the SPDIF output
becomes the only PCM device and everything (including the OSS emulation) works
with it.
Is there a way to do that?

Carsten.


P.S.: I am still trying to update to the latest CVS, but I keep getting the error message:
       cvs [update aborted]: end of file from server (consult above messages if any)
       I will keep trying and report any news on the loop-through as soon as I have
       successfully installed the latest CVS version.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
