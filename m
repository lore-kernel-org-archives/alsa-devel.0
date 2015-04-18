From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tas571x: Add DT binding document
Date: Sat, 18 Apr 2015 12:16:22 +0100
Message-ID: <20150418111622.GD26185@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: lgirdwood@gmail.com, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2015 at 02:42:19PM -0700, Kevin Cernekee wrote:

> +- VDD-supply: regulator phandle for the AVDD/DVDD/HP_VDD supply

This is clearly not correct - if there are three separate physical
supplies there should be three separate regulators requested.  They may
all resolve to one physical regulator on the board you are working with
but that might not be true on other boards.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMj0FAAoJECTWi3JdVIfQzhMH/1+AUT9sreHZGAEe9992j1Mz
TE+foJDduEhYubj8FtbsQbRB9fRFCu+iMtkR8QKRSaPrMp9Iv0Hqd2LtjLDlGb+K
MhmSkEFkTdktHt4f3Qiq4j2FyBBJCXswzhLPTJwsxTgEmhzD8Oyk8Ogn/qhlmKfy
+OPJXqIhQBgRYaSrB6c+GOfYKf8x/D51Uca4sxxx6cBDYDphOErJEVMVt67XJorH
dig8CGizCpG+V1rjeZG0Mr8gKP/3yrBcD7Y1wCx/0T5pLAXidu6EhiWfsFoSUjC0
wYr+rMpcQJBfeqet/Sk2uEVZMG/xHrGtjtRGxnCcdeD4Mrr87z5UY7F91U0SuAE=
=Sn3d
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
