From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: Re: [Alsa-user] Upgrade problems -addendum
Date: Fri, 24 Jan 2003 17:40:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301241740.13498.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301241512.17848.tais.hansen@osd.dk> <s5h8yxapn5i.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yxapn5i.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 24 January 2003 16:45, Takashi Iwai wrote:
> > Need any specific info about the board? Chip? I saw some talks about =
the
> > ALC650 chip in another thread on this list and alsamixer claims I've =
got
> > such a chip.
> most likely it has nothing to do with ALC650.
> but lspci -v and lspci -n (for the chip) might be helpful for the
> later development.

$ lspci -s 00:11.5 -v
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 A=
udio=20
Controller (rev 40)
        Subsystem: Micro-star International Co Ltd: Unknown device 4720
        Flags: medium devsel, IRQ 9
        I/O ports at e800 [size=3D256]
        Capabilities: [c0] Power Management version 2

$ lspci -s 00:11.5 -n
00:11.5 Class 0401: 1106:3059 (rev 40)


> now comes the patch of the week:
> now you'll have possibility to change the behavior of the driver via a
> module option idx_detect.
> idx_detect=3D0 : the default, won't work for you.

And it didn't.


> idx_detect=3D1 : like test7.  perhaps not perfect.

No sound, so you're right.


> idx_detect=3D2 : use the interrupt pointer only.  the resolution will b=
e
>                in the size of periods.  this should work.

Maybe. But it didn't. Seems to go a little too fast playing. No sound at =
all.


> idx_detect=3D3 : like test7 but don't evaluate the counter.
>                might be be finer than idx_detect=3D2 but might be
>                inaccurate in some cases.

This one killed my system the first time. Nice blinking keyboard leds. :)

Second run it runs speeds through the file. No sound at all.


I've attached log output from all idx'es, though only tested with ogg123.


- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPjFsa4IvLOJqwYc4AQL4Mw//ZCPhB71mnpTZmYxBGa0yym0j2FAfGPSy
4H2gAry+jpe9wDEOddijFaSdx/mYj04ST/4Vl+cNbPaV1kldMdrqWrU3Fx0vfIqE
FRC5SapuNiykdI1kMVIDotiEWU5MEhZG2UB5TwhDkSwwI3lPKfJDUsax79KCfIz/
m/8m7j0j9K0gtmDZhmD8v2TEpiiT1mk927BpqcZVI8lI3F0Ya0ggD3rI+rB+TJXQ
CMgZqO74TDVA2LoWPRGHVK/VPvvVEJmr2/5+TW9Y7E5zCJx1O1PsKGcXsv1P8Pw4
gRtLwJHxFhtgn59o8L2pJI+giy27ZpX8EJ+kj917r3S/XbXE62Hr/zWQBZN5HqMF
4YfWHukX3/+5yOkzfB257VXXYk6giHDiXyxXspw0nFbTZLwKuBNCRPxQZvrO1UQ/
TmFfLW6qvq8bMreO6q7xC7N+AWIpCXf1LkqEPZsjVozSBMKahWBSTIIpBGQalUGS
pBPo3gVDIKXVJT9NCUufBcmYuyImehscO2aICL1ojEsNO7zqWtkmKyGNEt3m/yA1
yhWbHABwsY029UU7SnOQpcaps0xEtF5Nl/XjljTT7dMJwV4Nep26DNW1c+Dmt+si
D1q7oWgmke6tqFXpXG3T/7vrWQMP50vag+Nf1whl3Zz31qkyqHFA1qlvcEyxFXuS
zU5qKaolsfk=3D
=3DlsXG
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
