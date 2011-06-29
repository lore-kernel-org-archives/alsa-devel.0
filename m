From: Ben Hutchings <ben@decadent.org.uk>
Subject: Bug#631963: linux-image-3.0.0-rc4-686-pae: no sound out the rear plugs
Date: Wed, 29 Jun 2011 04:58:53 +0100
Message-ID: <1309319933.3093.1614.camel@localhost>
References: <20110628172442.30723.36601.reportbug@spruce.test.oeko.net>
Reply-To: Ben Hutchings <ben@decadent.org.uk>, 631963@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="=-jkAUS/xEZA05OpkNIHOR"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.631963.B631963.13093199416460@bugs.debian.org>
In-Reply-To: <20110628172442.30723.36601.reportbug@spruce.test.oeko.net>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Takashi Iwai <tiwai@suse.de>, Toni Mueller <support@oeko.net>
Cc: 631963@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-jkAUS/xEZA05OpkNIHOR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-06-28 at 19:24 +0200, Toni Mueller wrote:
> Package: linux-2.6
> Version: 3.0.0~rc4-1~experimental.1
> Severity: normal
> Tags: upstream
>=20
>=20
> Hi,
>=20
> when using this kernel, I hear no sound using the speakers, only using
> the headphones, plugged in at the front.
>=20
> With 2.6.38 (dmesg attached), the speakers get fed, too.
[...]
> 00:14.2 Audio device [0403]: ATI Technologies Inc SBx00 Azalia (Intel HDA=
) [1002:4383]
>         Subsystem: ASUSTeK Computer Inc. Device [1043:841b]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at fe8f0000 (64-bit, non-prefetchable) [size=3D1=
6K]
>         Capabilities: <access denied>
>         Kernel driver in use: HDA Intel
[...]

Takashi, this looks like a regression in control parsing in the realtek
codec.  The kernel logs are at <http://bugs.debian.org/631963> but I
don't think they'll tell you much.

Toni, can you provide the output of 'amixer -c 0 controls' under 2.6.38
and 3.0-rc4?

Ben.

--=20
Ben Hutchings
In a hierarchy, every employee tends to rise to his level of incompetence.

--=-jkAUS/xEZA05OpkNIHOR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATgqi8ue/yOyVhhEJAQpdyxAAprGDsE2R74uXesKkvjHmq4A9u8HzDpaH
JX/jS4KBA0uxzUEIJN2bJJ4Qs9m5hIwDODu771D7A12rcz2R1kEfIQAO2WdIYRHm
cRixzO0fz9bT6MNnLf6KmjnvIN4uKQAhHiP5Dr+1RCIR7a/2bt/4OmVxGz+tg2dR
JZdTdw48pzaZ3nx7TOhi2knZHVGcXZk1DpEXGtTq6IKnhy7RSzomlg0MMEFi3pBA
HVucHrLUNI9FDm0eUqzzMD1qwprHPLLQ2mar0eo0dth9Amc0FkSBrnCNWcgeiGp2
+cLWkwfORjMHu86bwZRex1IucYRODZPbcTsH3E1S0vUXy1OUi68WTGTebXmblLhw
V1Sin0eS/u3inkjJhm04HGAtRFGWJUmr3zT0b2t8Z23dIOUkhmHaPHjLRej0+7J1
lpx/9+wpTiYJwBeK3NQ5ReKVpIT7Xq66E5aFuPUQL8wC62DD8EVBMeWxHCqW6keB
LRGxyMvg3SshelV3ijbhLXT6W2kIF+5JAC5cNP3gaVAroG+f2f9OGsO4rSkY6wG2
xZ0VuSuGh5pMV1W0fQGOrZF2ioi8fsdyiSYE5gOIC7I1/YDqhxvd327jP554oZVv
7R84U7KDGIFCYvG6hWeIXdpiRsciZFSTUZ5Nf1JCtL7Zz1zX9rmqY0u4E8nI7wFX
Xm7gVMPD4yg=
=5eZW
-----END PGP SIGNATURE-----

--=-jkAUS/xEZA05OpkNIHOR--
