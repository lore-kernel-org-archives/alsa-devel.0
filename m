From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] ASoC: core: set_tdm_slot() will return
 -ENOTSUPP if no operation provided
Date: Thu, 23 Jan 2014 19:29:42 +0000
Message-ID: <20140123192942.GF11727@sirena.org.uk>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
 <1390453370-29194-6-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389305055049615893=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDECB2652AD
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 20:29:57 +0100 (CET)
In-Reply-To: <1390453370-29194-6-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============0389305055049615893==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 01:02:47PM +0800, Xiubo Li wrote:
> Make it easier for generic code to work with set_tdm_slot() by distinguishing
> between the operation not being supported and an error as is done.

Applied, thanks.

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4W2jAAoJELSic+t+oim91WEP/i1IReTZuU5q6zvPu8BetSHY
BNOIPkYj2pIXqBZiz3BFmG8GaTOv4ZVI6DnaAHzTBzOJQWz11J+pf9Bdo8f5GW6U
Ew5xDvSKlhZ36ZnQU6K0TeCcBcQyByUzIxcqvq3fG6BnHDUT/D76UngSbv4jaD+n
Hw1ByaaKrWMC7e1V797wnAWunC0pcaKDhhyiTCgYYRKOVLlWOYVsDXx9mO9vS34Q
D7aoAh2XmP82dhL4aTwDUU2WqYj5cEGwtBq2zrC6xHZ6NSWR2DNpcFHwrUROwQyU
C96AdL93q34rpREfqE9HzeW9bsm/+oPdeerTOtaNwUirvGy1Jt6sEnATftptS6DG
g6Aduh37GjbFm2lW/dODzlCysg0Mz256Xu2tCseac/kRrRw7EC212Vybdu6r6QIc
HliZBdV0zIlxAhxypX5oLwTh4bXylJk0OuqoZahVkx2vWEWyBGEDtSr5Qw9htMsL
bKCpLG2foj18XFjKkhKM87O80+IK6Ij07XSwXhMlLzHVVUSJPP7KLHG89FHS2Wcx
znpNS+hJhgiMTTcMtQUBJByqQs+icaIGiRXGsGlzgENET/qM8dSTu2SYQfw8YVyS
VJZ6v8US/VcZQXAfdt0eTyM9wQcVdxmD6sr8b7cXSrodIV1Rz+HOqTAZoGTyoOc3
wUUQ5Xf0raXaY5/UiiTZ
=n7u9
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--

--===============0389305055049615893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0389305055049615893==--
