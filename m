From: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Subject: Re: Intel8x0 still broken in 2.6.9-ac16
Date: Wed, 22 Dec 2004 20:22:24 +0100
Message-ID: <ae4c71570412221122614924e4@mail.gmail.com>
References: <ae4c715704121614542739c909@mail.gmail.com>
	 <s5hsm65vsr3.wl@alsa2.suse.de>
	 <ae4c71570412170938139bd546@mail.gmail.com>
	 <s5hllbsvnu5.wl@alsa2.suse.de>
	 <ae4c71570412201519597d596a@mail.gmail.com>
	 <s5h8y7suf5a.wl@alsa2.suse.de>
	 <ae4c715704122111563be9a075@mail.gmail.com>
	 <s5hy8fqqt8z.wl@alsa2.suse.de>
Reply-To: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8fqqt8z.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi ;),

On Wed, 22 Dec 2004 15:53:32 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> Please show the contents of /proc/asound/card0/codec97#0/* files.
> This time they must appear more meaningfully.

[huma@miller] [~] % cat /proc/asound/card0/codec97\#0/ac97\#0-0
0-0/0: Conexant id 30

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

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
Extended ID      : codec=3D0 rev=3D2 AMAP DSA=3D0 SPDIF
Extended status  : PRL PRK PRJ PRI SPCV SPDIF=3D3/4
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kHz
Extended modem ID: codec=3D0 LIN1
Modem status     : PRA(GPIO)
Line1 rate       : 48000Hz

[huma@miller] [~] % cat /proc/asound/card0/codec97\#0/ac97\#0-0+regs
0:00 =3D 0152
0:02 =3D 0a0a
0:04 =3D 9f1f
0:06 =3D 0000
0:08 =3D 0000
0:0a =3D 8000
0:0c =3D 0000
0:0e =3D 801f
0:10 =3D 9f1f
0:12 =3D 0202
0:14 =3D 0000
0:16 =3D 0000
0:18 =3D 0202
0:1a =3D 0000
0:1c =3D 0000
0:1e =3D 0000
0:20 =3D 0000
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 000f
0:28 =3D 0a04
0:2a =3D 7c00
0:2c =3D bb80
0:2e =3D 0000
0:30 =3D 0000
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 0000
0:38 =3D 0000
0:3a =3D 2824
0:3c =3D 0001
0:3e =3D 0100
0:40 =3D bb80
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0030
0:4e =3D ffff
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0000
0:5c =3D 0600
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 0000
0:64 =3D 0000
0:66 =3D 0012
0:68 =3D 0000
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0000
0:70 =3D 0000
0:72 =3D 0000
0:74 =3D 0000
0:76 =3D 0000
0:78 =3D 0000
0:7a =3D 8004
0:7c =3D 4358
0:7e =3D 5430

> I think we need merge the common codes between intel8x0 and intel8x0m,
> and avoid the unnecessary initializations in each driver.

ok

--=20

David G=F3mez


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
