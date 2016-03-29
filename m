From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: bytcr_rt5640, baytrail: trying to get audio working
Date: Mon, 28 Mar 2016 19:04:06 -0500
Message-ID: <56F9C676.6000907@linux.intel.com>
References: <56F82886.6010002@vr-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EB9EE260511
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 02:04:09 +0200 (CEST)
In-Reply-To: <56F82886.6010002@vr-web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Bernhard_=c3=9cbelacker?= <bernhardu@vr-web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/27/16 1:37 PM, Bernhard =DCbelacker wrote:
> Hello,
> (This message was sent to alsa-user a week ago, but created no response t=
here.
> Therefore I hope I am allowed to ask here again.)
>
> I am trying to get audio working on a small Intel Z3736F based device.
> Some more details I have collected in Debian wiki [1].
>
> My tests are done with a current Debian testing.
>
> Firmware is from package firmware-intel-sound:
> sha1sum: 9e7c514b224d674cd3fb1301ce693c42b01f02e0  fw_sst_0f28.bin
> md5sum: 63765966238afad810b6a568d9b59620  fw_sst_0f28.bin
>
> Tests were done on linux v4.5-rc7-244-g03c668a.
> With a change adjusting the IRQ described in [2].
>
> After a fresh boot I tried the commands below (from [3]).
>
> But did not get hearable output, except a "crack" on device open and clos=
e.
>
> Now I am not sure how to proceed.
> Am I using the right firmware?
> Is the amixer sequence ok for this device?
> Can all the options in alsamixer be tested or is there a risk of
> damaging the device?

If you modified the interrupt order then it's a Baytrail-CR device and =

you will need to use the firmware that makes use of SSP0 (SSP2 is not =

connected in this package). I am working to enable SSP0 routing directly =

without the need for a new firmware but I haven't had time to test it.

That said, we've not been successful so far with such Baytrail-CR =

devices. So far the issue seem to be in the SSP0-AIF2 connection; if you =

do a loopback within the DSP things work fine. Without access to the =

schematics and the board information it's not straightforward to solve =

the problem.
Note also that Baytrail-CR devices typically use different microphones =

and speaker settings (differential mics, mono speakers typically) so you =

may need to add some quirks.


>
>
> Kind regards,
> Bernhard
>
>
> [1] https://wiki.debian.org/InstallingDebianOn/PIPO/PIPO%20X8
> [2] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094663=
.html
> [3] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/094080=
.html
> [4] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/094583=
.html
> [5] https://sourceforge.net/p/alsa/mailman/alsa-user/thread/56EC0F8A.4010=
009%40vr-web.de/#msg34946769
>
>
>
> echo -n 'module snd_soc_sst_mfld_platform +p' > /sys/kernel/debug/dynamic=
_debug/control
>
> #DSP routing
> amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
> amixer -c0 sset 'media0_out mix 0 media1_in' on
> amixer -c0 sset 'media1_in Gain 0' 80%
> amixer -c0 sset 'media1_in Gain 0 Ramp Delay' 50
> amixer -c0 sset 'media1_in Gain 0' off
> amixer -c0 sset 'pcm0_in Gain 0' 80%
> amixer -c0 sset 'pcm0_in Gain 0 Ramp Delay' 50
> amixer -c0 sset 'pcm0_in Gain 0' off
> amixer -c0 sset 'codec_out0 Gain 0' 80%
> amixer -c0 sset 'codec_out0 Gain 0 Ramp Delay' 50
> amixer -c0 sset 'codec_out0 Gain 0' off
>
> #Codec routin, if you have different one please modfiy
> amixer -c0 sset "DAC MIXL INF1" on
> amixer -c0 sset "DAC MIXR INF1" on
> amixer -c0 sset "Stereo DAC MIXL DAC L1" on
> amixer -c0 sset "Stereo DAC MIXR DAC R1" on
> amixer -c0 sset "SPK MIXL DAC L1" on
> amixer -c0 sset "SPK MIXR DAC R1" on
> amixer -c0 sset "SPOL MIX SPKVOL L" on
> amixer -c0 sset "SPOR MIX SPKVOL R" on
> amixer -c0 sset "SPOL MIX DAC L1" on
> amixer -c0 sset "SPOR MIX DAC R1" on
> amixer -c0 sset "Speaker L" on
> amixer -c0 sset "Speaker R" on
> amixer -c0 sset "Headphone" off
>      #amixer -c0 sset "Ext Spk" on #does not exist
> amixer -c0 sset "Speaker" on
>
>
>
>
>
> # LANG=3DC speaker-test --nloops=3D1
>
> speaker-test 1.1.0
>
> Playback device is default
> Stream parameters are 48000Hz, S16_LE, 1 channels
> Using 16 octaves of pink noise
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 16 to 204800
> Period size range from 8 to 102400
> Using max buffer size 204800
> Periods =3D 4
> was set period_size =3D 51200
> was set buffer_size =3D 204800
>   0 - Front Left
> Time per period =3D 2.109224
>
>
>
>
>
> # cat /proc/interrupts | grep -E "CPU|sst"
>              CPU0       CPU1       CPU2       CPU3
>     1:          1         35          0          0   IO-APIC   29-fasteoi=
   intel_sst_driver
>
>
>
>
> # LANG=3DC dmesg -T | grep -i -E "bytcr|snd|rt56|alsa|sst|Baytrail|80860F=
28:00|SSP|lpe" --color  [Thu Mar 17 11:49:59 2016] intel_sst_acpi 80860F28:=
00: LPE base: 0x90a00000 size:0x200000
> [Thu Mar 17 11:49:59 2016] intel_sst_acpi 80860F28:00: IRAM base: 0x90ac0=
000
> [Thu Mar 17 11:49:59 2016] intel_sst_acpi 80860F28:00: DRAM base: 0x90b00=
000
> [Thu Mar 17 11:49:59 2016] intel_sst_acpi 80860F28:00: SHIM base: 0x90b40=
000
> [Thu Mar 17 11:49:59 2016] intel_sst_acpi 80860F28:00: Mailbox base: 0x90=
b44000
> [Thu Mar 17 11:49:59 2016] intel_sst_acpi 80860F28:00: DDR base: 0x200000=
00
> [Thu Mar 17 11:49:59 2016] intel_sst_acpi 80860F28:00: Got drv data max s=
tream 25
> [Thu Mar 17 11:49:59 2016] bytcr_rt5640 bytcr_rt5640: snd-soc-dummy-dai <=
-> media-cpu-dai mapping ok
> [Thu Mar 17 11:49:59 2016] bytcr_rt5640 bytcr_rt5640: snd-soc-dummy-dai <=
-> deepbuffer-cpu-dai mapping ok
> [Thu Mar 17 11:49:59 2016] compress asoc: snd-soc-dummy-dai <-> compress-=
cpu-dai mapping ok
> [Thu Mar 17 11:49:59 2016] bytcr_rt5640 bytcr_rt5640: rt5640-aif1 <-> ssp=
2-port mapping ok
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: media1_in=
: Volume 0, -1440
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: media1_in=
: Mute 1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: media1_in=
: Volume 0, 0
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: media1_in=
: Mute 1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: media1_in=
: Ramp Delay50
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: pcm0_in: =
Volume 0, -1440
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: pcm0_in: =
Mute 1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: pcm0_in: =
Volume 0, 0
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: pcm0_in: =
Mute 1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:56 2016] sst-mfld-platform sst-mfld-platform: pcm0_in: =
Ramp Delay50
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: codec_out=
0: Volume 0, -1440
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: codec_out=
0: Mute 1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: codec_out=
0: Volume 0, 0
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: codec_out=
0: Mute 1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: codec_out=
0: Ramp Delay50
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 2 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: rx slot -=
 slot 3 map =3D 0x8
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_0 map =3D 0x1
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out0_1 map =3D 0x2
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_0 map =3D 0x4
> [Thu Mar 17 11:50:57 2016] sst-mfld-platform sst-mfld-platform: tx channe=
l - codec_out1_1 map =3D 0x8
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: enable=3D=
1, usage=3D0
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 01 01 01 00 00 08=
 00 ff ff ff ff 55 00 00 00  ............U...
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter:sst=
_get_ssp_mode, format=3D4000
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter:sst=
_get_frame_sync_polarity, format=3D200
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter: en=
able=3D1 port_name=3Dssp2-port
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: ssp_id: 3
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 01 01 01 00 00 1a=
 00 ff ff ff ff 75 00 12 00  ............u...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: 03 00 03 00 98 00 03=
 ff 03 ff 03 00 01 00 18 00  ................
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000020: 01 01               =
                             ..
> [Thu Mar 17 11:51:08 2016] intel_sst_acpi 80860F28:00: Alloc for str 1 pi=
pe 0x90
> [Thu Mar 17 11:51:08 2016]  Baytrail Audio Port: setting buffer ptr param
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter: wi=
dget=3Dcodec_out0
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 02 01 01 00 00 1e=
 00 ff ff ff ff 82 00 16 00  ................
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: 82 00 12 00 03 00 01=
 02 04 08 10 20 40 80 01 02  ........... @...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000020: 04 08 10 20 40 80   =
                             ... @.
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter: wi=
dget=3Dcodec_out0
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: control n=
ame=3Dcodec_out0 Gain 0 Volume
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 02 01 01 00 00 14=
 00 ff ff ff ff 21 00 0c 00  ............!...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: 01 00 00 02 67 00 60=
 fa 60 fa 32 00              ....g.`.`.2.
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: widget =
=3D codec_out0 mix 0
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: val =3D 0=
x2000
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: reg: 0x20=
00
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: input id:=
 0x8dff, nb_inputs: 1
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 01 01 01 00 00 14=
 00 ff ff ff ff 72 00 0c 00  ............r...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: ff 02 ff ff 03 00 01=
 00 ff 8d ff ff              ............
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: widget =
=3D media0_out mix 0
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: val =3D 0=
x40000
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: reg: 0x40=
000
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: input id:=
 0x90ff, nb_inputs: 1
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 01 01 03 00 00 14=
 00 ff ff ff ff 72 00 0c 00  ............r...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: ff 12 ff ff 03 00 01=
 00 ff 90 ff ff              ............
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: widget=3D=
media0_out
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: task=3D3,=
 location=3D0x12ff
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 01 01 03 00 00 0a=
 00 ff 12 ff ff 77 00 02 00  ............w...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: 01 00               =
                             ..
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter: wi=
dget=3Dmedia0_out
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: widget=3D=
pcm0_in
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: task=3D1,=
 location=3D0x8dff
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 01 01 01 00 00 0a=
 00 ff 8d ff ff 77 00 02 00  ............w...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: 01 00               =
                             ..
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter: wi=
dget=3Dpcm0_in
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: control n=
ame=3Dpcm0_in Gain 0 Volume
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 02 01 01 00 00 14=
 00 ff ff ff ff 21 00 0c 00  ............!...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: 01 00 00 8d 67 00 60=
 fa 60 fa 32 00              ....g.`.`.2.
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: enter, da=
i-name=3Dmedia-cpu-dai dir=3D0
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Stream na=
me=3DHeadset Playback
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: send gain=
s for widget=3Dmedia1_in
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: control n=
ame=3Dmedia1_in Gain 0 Volume
> [Thu Mar 17 11:51:08 2016] sst-mfld-platform sst-mfld-platform: Enter
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000000: 01 02 01 03 00 00 14=
 00 ff ff ff ff 21 00 0c 00  ............!...
> [Thu Mar 17 11:51:08 2016] writing to lpe: 00000010: 01 00 00 90 67 00 60=
 fa 60 fa 32 00              ....g.`.`.2.
> [Thu Mar 17 11:51:08 2016]  Baytrail Audio Port: sst_platform_pcm_trigger=
 called
> [Thu Mar 17 11:51:08 2016]  Baytrail Audio Port: sst: Trigger Start
> [Thu Mar 17 11:51:08 2016]  SSP2-Codec: sst_platform_pcm_trigger called
> [Thu Mar 17 11:51:10 2016]  Baytrail Audio Port: sst_platform_pcm_trigger=
 called
> [Thu Mar 17 11:51:10 2016]  Baytrail Audio Port: sst: in stop
> [Thu Mar 17 11:51:10 2016]  SSP2-Codec: sst_platform_pcm_trigger called
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: enter, da=
i-name=3Dmedia-cpu-dai dir=3D0
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: Stream na=
me=3DHeadset Playback
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: send gain=
s for widget=3Dmedia1_in
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: control n=
ame=3Dmedia1_in Gain 0 Volume
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: Enter
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000000: 01 02 01 03 00 00 14=
 00 ff ff ff ff 21 00 0c 00  ............!...
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000010: 01 00 00 90 67 00 60=
 fa 60 fa 32 00              ....g.`.`.2.
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: Enter: en=
able=3D0 port_name=3Dssp2-port
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: ssp_id: 3
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000000: 01 01 01 01 00 00 1a=
 00 ff ff ff ff 75 00 12 00  ............u...
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000010: 03 00 00 00 98 00 03=
 ff 03 ff 03 00 01 00 18 00  ................
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000020: 01 01               =
                             ..
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: enable=3D=
0, usage=3D1
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000000: 01 01 01 01 00 00 08=
 00 ff ff ff ff 0e 00 00 00  ................
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: enter, da=
i-name=3Dmedia-cpu-dai dir=3D0
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: Stream na=
me=3DHeadset Playback
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: send gain=
s for widget=3Dmedia1_in
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: control n=
ame=3Dmedia1_in Gain 0 Volume
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: Enter
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000000: 01 02 01 03 00 00 14=
 00 ff ff ff ff 21 00 0c 00  ............!...
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000010: 01 00 00 90 67 00 60=
 fa 60 fa 32 00              ....g.`.`.2.
> [Thu Mar 17 11:51:10 2016] intel_sst_acpi 80860F28:00: Free for str 1 pip=
e 0x90
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: widget=3D=
pcm0_in
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: task=3D1,=
 location=3D0x8dff
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000000: 01 01 01 01 00 00 0a=
 00 ff 8d ff ff 77 00 02 00  ............w...
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000010: 00 00               =
                             ..
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: widget=3D=
media0_out
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: task=3D3,=
 location=3D0x12ff
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000000: 01 01 01 03 00 00 0a=
 00 ff 12 ff ff 77 00 02 00  ............w...
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000010: 00 00               =
                             ..
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: widget =
=3D codec_out0 mix 0
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: val =3D 0=
x2000
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: reg: 0x20=
00
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: input id:=
 0x8dff, nb_inputs: 1
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000000: 01 01 01 01 00 00 14=
 00 ff ff ff ff 72 00 0c 00  ............r...
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000010: ff 02 ff ff 00 00 01=
 00 ff 8d ff ff              ............
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: widget =
=3D media0_out mix 0
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: val =3D 0=
x40000
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: reg: 0x40=
000
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: input id:=
 0x90ff, nb_inputs: 1
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000000: 01 01 01 03 00 00 14=
 00 ff ff ff ff 72 00 0c 00  ............r...
> [Thu Mar 17 11:51:10 2016] writing to lpe: 00000010: ff 12 ff ff 00 00 01=
 00 ff 90 ff ff              ............
> [Thu Mar 17 11:51:10 2016] sst-mfld-platform sst-mfld-platform: Enter: wi=
dget=3Dcodec_out0
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
