From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: nForce2 (intel8x0) playback doesn't accept 44khz
Date: Wed, 14 Jan 2004 15:12:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1rq3ev3q1sf88@mail.broadpark.no>
References: <opr1rj39qxq1sf88@mail.broadpark.no> <s5heku268bi.wl@alsa2.suse.de> <opr1rl7zlqq1sf88@mail.broadpark.no> <s5hd69m63yw.wl@alsa2.suse.de> <opr1rqddayq1sf88@mail.broadpark.no> <s5h8yka6323.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yka6323.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

/proc/asound/card0/codec97#0/ac97#0-0:
0-0/0: Realtek ALC650 rev 2

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
Extended ID      : codec=3D0 rev=3D1 LDAC SDAC CDAC DSA=3D0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3D3/4 VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 22050Hz
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kH=
z
SPDIF In Status  : Not Locked

/proc/asound/card0/codec97#0/ac97#0-0+regs
0:00 =3D 5980
0:02 =3D 0505
0:04 =3D 0000
0:06 =3D 0003
0:08 =3D 0000
0:0a =3D 801e
0:0c =3D 801f
0:0e =3D 801f
0:10 =3D 9f1f
0:12 =3D 9f1f
0:14 =3D 9f1f
0:16 =3D 9f1f
0:18 =3D 0808
0:1a =3D 0000
0:1c =3D 0000
0:1e =3D 0000
0:20 =3D 0000
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 000f
0:28 =3D 05c7
0:2a =3D 05c1
0:2c =3D bb80
0:2e =3D bb80
0:30 =3D bb80
0:32 =3D 5622
0:34 =3D 0000
0:36 =3D 9f80
0:38 =3D 9f9f
0:3a =3D 2824
0:3c =3D 0000
0:3e =3D 0000
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0000
0:4e =3D 0000
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0000
0:5c =3D 0000
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 0000
0:64 =3D 0808
0:66 =3D 0808
0:68 =3D 0000
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0014
0:70 =3D 0211
0:72 =3D 00a0
0:74 =3D 0043
0:76 =3D 0000
0:78 =3D 8003
0:7a =3D 57c3
0:7c =3D 414c
0:7e =3D 4720


On Wed, 14 Jan 2004 15:02:44 +0100, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 14 Jan 2004 14:57:03 +0100,
> Arve Knudsen wrote:
>>
>> On Wed, 14 Jan 2004 14:43:03 +0100, Takashi Iwai <tiwai@suse.de> wrote=
:
>>
>> > At Wed, 14 Jan 2004 13:27:25 +0100,
>> > Arve Knudsen wrote:
>> >>
>> >> I'm sorry i wasn't being more specific, but from browsing the archi=
ve
>> >>=20
>> (http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg10257=
.html)
>> >
>> > no, it was a bug.
>> >
>> >> I got the impression the rate of intel8x0 has been recently fixed a=
t
>> >> 48khz? Anyway, this is an Asus A7N8X Deluxe with nForce2 SoundStorm
>> >> onboard audio. ALSA-lib is v1.0.1, while ALSA-driver is compiled in=
to
>> >> kernel 2.6.1-mm2 (v1.0.1?). The problem is consistent across=20
>> programs it
>> >> seems, specifically my own code and aplay (sets rate to 48000 if I=20
>> open
>> >> hw).
>> >
>> > as mentioned, the support sample rate is dependent on AC97 codec.
>> >
>> > check /proc/asound/card0/codec97#0/* files.
>> > if your codec supports VRA, you'll see it in the extended id line.
>> >
>> >
>> > Takashi
>>
>> The thing is it used to support 44.1 just fine, its only recently=20
>> there's
>> been a problem. Besides isn't it weird that capture will support 44.1
>> while playback doesn't? Anyhow, the extended id line indicates it=20
>> supports
>> VRA:
>> Extended ID      : codec=3D0 rev=3D1 LDAC SDAC CDAC DSA=3D0 SPDIF DRA =
VRA
>
> please show the whole entries (of all files) for debugging...
>
>
> Takashi




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
