From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: davinci-mcasp: Allow complete
 shutdown of McASP when not in use
Date: Thu, 5 Mar 2015 16:41:33 +0000
Message-ID: <20150305164133.GQ21293@sirena.org.uk>
References: <1425567321-29572-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6519637257162306303=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E38D2604FA
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 17:41:44 +0100 (CET)
In-Reply-To: <1425567321-29572-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6519637257162306303==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a4U+NozxGg14X9RV"
Content-Disposition: inline


--a4U+NozxGg14X9RV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2015 at 04:55:21PM +0200, Peter Ujfalusi wrote:
> Rearrange the pm_runtime_get/put_sync calls so the IP will be turned off
> when it is not in use.

Applied, thanks.

--a4U+NozxGg14X9RV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+Ic8AAoJECTWi3JdVIfQ/rsH/iEjeVXvLgFsY8u85eQPnyx2
JPCNK/qsogkCJya4Vyzg0n67E8LJ+5TkYG+fvyXoCCuDBtfRr6vOFzJeEr5Cr7K6
aLz4zXJ7f6ihTArJ38qev0Z2/gZS9LeAdyMv0PQOT5VtVA362b58CKdB+oTc/vrW
Gu1S4AqCuvCyguVZ647JA2POyaPDmq50AkbkiJZOGW7gP3B5opAA9jwPkfhxHWn/
XxK9fl2bYRpBDmeTWtEZ49dr0xvU2+jPaCLRDWZzRV08vDREAkI84eKid4j0be1i
+bFZHq0dmJDMY4wLRZcCJkjHEn2FdcbFJ6TYPE8LootcWcPFdabkhKf0coqGoLc=
=g+PM
-----END PGP SIGNATURE-----

--a4U+NozxGg14X9RV--

--===============6519637257162306303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6519637257162306303==--
