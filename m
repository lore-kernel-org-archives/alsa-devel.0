From: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Subject: Re: Intel8x0 still broken in 2.6.9-ac16
Date: Fri, 17 Dec 2004 18:38:54 +0100
Message-ID: <ae4c71570412170938139bd546@mail.gmail.com>
References: <ae4c715704121614542739c909@mail.gmail.com>
	 <s5hsm65vsr3.wl@alsa2.suse.de>
Reply-To: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsm65vsr3.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi Takashi ;)

On Fri, 17 Dec 2004 16:39:28 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> > codec_write 0: semaphore is not ready for register 0x2
> > codec_write 0: semaphore is not ready for register 0x2
> > codec_write 0: semaphore is not ready for register 0x2
>=20
> This implies that wrong SDI's are assigned to the codec or GLOB_STA
> register shows something different.
>=20
> Please attach /proc/asound/card0/intel8x0 and

[huma@miller] [~] % cat /proc/asound/card0/intel8x0=20
Intel8x0

Global control        : 0x00000000
Global status         : 0x08700000
SDM                   : 0x00000008
AC'97 codecs ready    : none
AC'97 codecs SDIN     : 0 0 0

> /proc/asound/card0/codec97#0/* files for debugging.

0-0/0: Conexant id 30

Revision         : 0xff
Compat. Class    : 0x1f
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     : -reserved1- -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+0dB]
POP path         : post 3D
Sim. stereo      : on
3D enhancement   : on
Loudness         : on
Mono output      : Mic
Mic select       : Mic2
ADC/DAC loopback : on
Extended ID      : codec=3D3 rev=3D3 AMAP LDAC SDAC CDAC DSA=3D3 VRM SPDIF =
DRA VRA
Extended status  : PRL PRK PRJ PRI SPCV MADC LDAC SDAC CDAC SPDIF=3Dres
VRM SPDIF DRA VRA
PCM front DAC    : 65535Hz
PCM Surr DAC     : 65535Hz
PCM LFE DAC      : 65535Hz
PCM ADC          : 65535Hz
PCM MIC ADC      : 65535Hz
SPDIF Control    : PRO Non-audio Preemph50/15 Category=3D0x7f
Generation=3D1 Rate=3D32kHz DRS Validity

                    Gain     Inverted  Buffer delay  Location
Master Out       : -10.5 dBV    X      31/fs         NC/unused
AUX Out          : -10.5 dBV    X      31/fs         NC/unused
Center/LFE Out   : -10.5 dBV    X      31/fs         NC/unused
SPDIF Out        : -10.5 dBV    X      31/fs         NC/unused
Phone In         : -10.5 dBV    X      31/fs         NC/unused
Mic 1            : -10.5 dBV    X      31/fs         NC/unused
Mic 2            : -10.5 dBV    X      31/fs         NC/unused
Line In          : -10.5 dBV    X      31/fs         NC/unused
CD In            : -10.5 dBV    X      31/fs         NC/unused
Video In         : -10.5 dBV    X      31/fs         NC/unused
Aux In           : -10.5 dBV    X      31/fs         NC/unused
Mono Out         : -10.5 dBV    X      31/fs         NC/unused
Extended modem ID: codec=3D3 CID2 CID1 HSET LIN2 LIN1
Modem status     : GPIO MREF ADC1 DAC1 ADC2 DAC2 HADC HDAC PRA(GPIO)
PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2) PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 65535Hz
Line2 rate       : 65535Hz
Headset rate     : 65535Hz


0:00 =3D ffff
0:02 =3D ffff
0:04 =3D ffff
0:06 =3D ffff
0:08 =3D ffff
0:0a =3D ffff
0:0c =3D ffff
0:0e =3D ffff
0:10 =3D ffff
0:12 =3D ffff
0:14 =3D ffff
0:16 =3D ffff
0:18 =3D ffff
0:1a =3D ffff
0:1c =3D ffff
0:1e =3D ffff
0:20 =3D ffff
0:22 =3D ffff
0:24 =3D ffff
0:26 =3D ffff
0:28 =3D ffff
0:2a =3D ffff
0:2c =3D ffff
0:2e =3D ffff
0:30 =3D ffff
0:32 =3D ffff
0:34 =3D ffff
0:36 =3D ffff
0:38 =3D ffff
0:3a =3D ffff
0:3c =3D ffff
0:3e =3D ffff
0:40 =3D ffff
0:42 =3D ffff
0:44 =3D ffff
0:46 =3D ffff
0:48 =3D ffff
0:4a =3D ffff
0:4c =3D ffff
0:4e =3D ffff
0:50 =3D ffff
0:52 =3D ffff
0:54 =3D ffff
0:56 =3D ffff
0:58 =3D ffff
0:5a =3D ffff
0:5c =3D ffff
0:5e =3D ffff
0:60 =3D ffff
0:62 =3D ffff
0:64 =3D ffff
0:66 =3D ffff
0:68 =3D ffff
0:6a =3D ffff
0:6c =3D ffff
0:6e =3D ffff
0:70 =3D ffff
0:72 =3D ffff
0:74 =3D ffff
0:76 =3D ffff
0:78 =3D ffff
0:7a =3D ffff
0:7c =3D ffff
0:7e =3D ffff


Thanks,


--=20

David G=F3mez


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
