From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
Date: Thu, 3 Oct 2013 16:59:54 +0100
Message-ID: <20131003155954.GV27287@sirena.org.uk>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0096717755653477036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 34AEB265560
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 18:00:03 +0200 (CEST)
In-Reply-To: <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: fabio.estevam@freescale.com, s.hauer@pengutronix.de, shawn.guo@linaro.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0096717755653477036==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQqDiQVflaif2hna"
Content-Disposition: inline


--NQqDiQVflaif2hna
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 02:36:10PM +0200, Philippe R=E9tornaz wrote:
> On imx31 with mc13783 codec the FIQ is not necessary and not enabled
> as DMA transfer is available.
> Change the probe() function to fail only if both FIQ and DMA are not
> available.

Is this something that used to work but has been broken or is this
enabling a new feture?  Just wondering if this needs to be sent to Linus
as a fix.

--NQqDiQVflaif2hna
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTZR3AAoJELSic+t+oim9UIsP/29CFxGbP7eZY+uD6nQ2U8e8
mdpjK+tKSqG74Vb5JnNsNHalyE4EfeJgu6V8Ghu+xE+SAeujMh9mkh1vAC/1MDLu
Q3B3fTg3S3cmWRcodXgP2i0EQqOCjxQQbtMbhx/rg8Bjc42+OiQCdujv+xAgZE2l
Rfc3YG1ogimvGLEjshKIWNWPur6ROZV5zPtITUycjgVAXK1qTT7X/dfVWZ93+6lj
Lr9yEJeBMvna8bVb4PGYm1fZKT6Lg7C2fhZIGiMN7WpuQnYw8wIYep8YSHrI5oFx
I/oWeoqVJyQgSbjJKy+aXGFBEjbZyMB13Ixo9c2lIA+t3syaM0jKYmz8CRzrHthr
UWvR9tw8i7IY7n7hfYCtwCETtOtCnDIdteReo2wNnNzvuRGKjAlgY6edEXXjR2fA
38zwpyY7hGw7W1CrKu/Io9ZmBEtvtaZhELsNQxlO93CWQKL39PF6QXUMcxIpzr27
6Z9JFALfrRRxsSd90LZ5eoKSymU+Z6SOWr9HAeiG6Az0+pdMuJoLTcIN4lg87pWy
IFNNl86KAjmavur1FFm2iQPhQnJ8rI2ZCnESp0Kh6JYQInstFuBYvoNUjGZDY+iD
/p9115PJqYfdqUl3J28ATvv2X6u2QsPhM0sIdCawcElMUvlBDSZFObS39vHyIU5h
wVLbPriMPUaVYaMMgbqR
=mQSC
-----END PGP SIGNATURE-----

--NQqDiQVflaif2hna--

--===============0096717755653477036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0096717755653477036==--
