From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: txx9aclc_ac97: Fix kernel crash on
	probe
Date: Tue, 18 Feb 2014 10:18:40 +0900
Message-ID: <20140218011840.GQ2669@sirena.org.uk>
References: <1392492509-29426-1-git-send-email-shc_work@mail.ru>
 <20140216003810.GP4451@sirena.org.uk>
 <1392519353.709209979@f243.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3408714350267851139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D72492650D4
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 02:31:33 +0100 (CET)
In-Reply-To: <1392519353.709209979@f243.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3408714350267851139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AFQGHouA0VN8Ovbt"
Content-Disposition: inline


--AFQGHouA0VN8Ovbt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2014 at 06:55:53AM +0400, Alexander Shiyan wrote:
> =D0=92=D0=BE=D1=81=D0=BA=D1=80=D0=B5=D1=81=D0=B5=D0=BD=D1=8C=D0=B5, 16 =
=D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2014, 8:38 +08:00 =D0=BE=D1=82 M=
ark Brown <broonie@kernel.org>:
> > On Sat, Feb 15, 2014 at 11:28:29PM +0400, Alexander Shiyan wrote:
> > > This patch fixes a crash caused by commit af5b2d7519

> > I don't know where you got that hash from by the way, that commit isn't
> > present in mainline?

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/so=
und/soc/txx9/txx9aclc-ac97.c?id=3D3bed3344c82623f6a37f3032e307d9af5b2d7519

A shortened commit ID is the *start* of the ID, not the end.  Try
running 'git show af5b2d7519'.

--AFQGHouA0VN8Ovbt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArTtAAoJELSic+t+oim9axUP/2sVHyooQ4bZrvuOULcJ/DKb
WjOnSyZlkxIZQ64XVKLQj6aV4kwCsJ25EvI+Djf4Iv1gxjCzMNU6/mS/LnRohT/7
8miraVLplYYTU7ROsgEXRWjMSZXU2w0g2nZ6PRxz38vxNVXL8NTvc5bdRvMSG0q5
AJ1OAod2p3TnWi5dNr4dR3TTZjFGbbqSbpLYy0uytNhdPx85oagH8qNh0ohDEPEg
55HO9WwjYy1o6dt+iDt0spWS/Sltaw8aT2KyvxWoko1MAikKaBqO7WQJTxKw+7kH
bHEZ5pVfVWoavqZKiO+gdgNqZheBSKBkXBmBvWvCzf9vg0cKjg1V0nRzVQg+NeSP
6onXezQK3wvw3Masb6LOOd1/rt2zbTAcaSv9i/M2e7f9vQYIVtDYxDg/pp7MyrlN
IigVjUSWfwrCCLYqJxvpKsq+y7XTbNXhECWSScWsSRQ6RrpZGel2gxpdWQR3I9+h
HMa0KMimc0/Z/2rNWhBy2Ihx+Qq5V9DwEau1gt86gSy5NbEMY4bMr1CWob1TEi6i
cKQF9kTViMsyNxf/5PXBMG3fn4yWyRlv0LETeX08YvhRzczA1AJ4qE2lg+7JLfms
rkPECIFTkvBALqqYwBUg0IF4el4Zj8XygAt6lno/NQI+bH5IpAc/qn+kaCl5wRdd
VWBZS38TE+QZOBDoJBZG
=JxGu
-----END PGP SIGNATURE-----

--AFQGHouA0VN8Ovbt--

--===============3408714350267851139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3408714350267851139==--
