From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: Intel: Use acpi_dev_present
Date: Mon, 23 Nov 2015 14:48:36 +0000
Message-ID: <20151123144836.GJ1929@sirena.org.uk>
References: <cover.1448282995.git.lukas@wunner.de>
 <b7bd5f48fd254fb743b99d5c3e63f95ea8dfd8a7.1448282995.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4360483921248136309=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B6D6265497
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 15:48:49 +0100 (CET)
In-Reply-To: <b7bd5f48fd254fb743b99d5c3e63f95ea8dfd8a7.1448282995.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org, devel@acpica.org
List-Id: alsa-devel@alsa-project.org


--===============4360483921248136309==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Content-Disposition: inline


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 23, 2015 at 03:34:55PM +0100, Lukas Wunner wrote:
> Use shiny new acpi_dev_present and remove all the boilerplate to search
> for a particular ACPI device. No functional change.

This will collide with some other work done on the Intel code in -next I
expect, probably best to merge this via ASoC (so pulling a shared branch
for the new API) or just wait till 4.5 to do the conversion.

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUydDAAoJECTWi3JdVIfQBaEH/3RPvMmzRdZ0X5gz8n01wCBe
gG1Ri0ZJx61GdWCMCnM73LcsluJCtKz+fM3XHakmfHeWZixBK0eWu9o9/+x2Wfg4
ULaMru3NtBWlGKkvdrya5vfAnO4qWJmxwPoREQcTO+Fkg6GYirnJHWigh7z6fb7/
/gk9UUYHBkNgcXcoNrePhfyDn79+HK9LjvkV0gUcq7hn7YZ9AeNiQWYq7RchVVSb
Z2PYrTEipQ4qz+AYyZ41mK1064H+0V/01CTC6NY0KIrC1hf6Xm6dzdemwfdo6Cdt
VMjyrMksKcVYCJzM/TGmLjAf0Wlr0HVODSVSSiFcjsx8q8gZTRaJ3sDp8tY1uLE=
=Lof4
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--

--===============4360483921248136309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4360483921248136309==--
