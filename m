From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: dapm: release lock on error paths
Date: Sun, 15 Apr 2012 10:47:21 +0100
Message-ID: <20120415094721.GA3806@opensource.wolfsonmicro.com>
References: <20120413192543.GC18505@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6264952044304253389=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33A88247F5
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Apr 2012 11:47:25 +0200 (CEST)
In-Reply-To: <20120413192543.GC18505@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6264952044304253389==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 13, 2012 at 10:25:43PM +0300, Dan Carpenter wrote:
> We added locking here but there were a couple error paths where we
> forgot to drop the lock before returning.

Applied, thanks.

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPipkQAAoJEBus8iNuMP3dkrcP/RUNludJq6NZ+TcVi7YLG75R
9AlBDoOE48ZSRSf2AsYqFjr1/o4w3iKwvCiBa/+MLzUeRA/Sx9NAbWennRVGBs3b
2IC4rnAz3g6+ozpTzexPzPxJwlCsqKdefs9A5CWNELmVcWV+tuMkIK9zIDZqVpcK
YsMt4NX10ZTYE3/laM/CRO0Fe0lOX06TtMlfi7Q1Q9JrcBCCyQnN/1Lao3P+ZXfv
bNZvKAuFrGSQgNZO/wiXD8wRsyOaj7FzTKvNtLJwiZUsUglpg4hMQlhkF5zlBKQL
e8AtbQbgPooWDMYG0za8qI0YDnCqtbICfVMXrPVVIBGsGHlasFZi+gM4uiSVEkOT
DLBKxB0HFMC4fNLM5+XtAyc7k/JBae4gn9TNjoxeSjdNuMNlkiDCplov8SQ0ho2V
C+VYkWRyf8b/FtCLOoxGLUe96EBIhIKlyCYKD0ArMJkCmSWep3rKNSJ0lm8fkAIC
tpJ5VsBZibq32xfz/CGcpbY3JM0ECtulPtgiIKD0jRRFXK/XjvVvL+jN7ry5RJZO
vEpE3eqhhWiPTwX69/hHapsvDnOraoNUHDlA51/xQYHfN5CfWP73h9HLqgEZFFDC
wrBx7XnOdv7eTRVcQ5osjJPdyBtAekGdr+0onc3dkwePMHSV6unOnrUdNhCGuF+E
UjPiPJxaM8M+Fe3LzG9K
=TMHC
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============6264952044304253389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6264952044304253389==--
