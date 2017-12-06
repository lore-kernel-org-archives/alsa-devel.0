From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 30/45] sound: soc: hisilicon: remove
	duplicate includes
Date: Wed, 6 Dec 2017 17:48:06 +0000
Message-ID: <20171206174806.dq4aokctc6nlnw2o@sirena.org.uk>
References: <1512581940-6407-1-git-send-email-pravin.shedge4linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5178763874446284251=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E5FFD267A12
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:48:07 +0100 (CET)
In-Reply-To: <1512581940-6407-1-git-send-email-pravin.shedge4linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, john.stultz@linaro.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============5178763874446284251==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lj45d7crl7fcn6q3"
Content-Disposition: inline


--lj45d7crl7fcn6q3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 11:09:00PM +0530, Pravin Shedge wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--lj45d7crl7fcn6q3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooLVUACgkQJNaLcl1U
h9AzbAf/ZDwCkJ8O3Di3yogjZ2LDwdB2ATASDd1Bf3zUnK6NmbsqZ9j6rxMVHI4d
0EfE/E2lFNjLdl8efNVB+G5ibAZDplTt6UGZu2P7DIw77IC8tdqFzGWziHVKGl3a
L2OZbp5JQU81pOEJF77CcMPQko9RXxzAk8Xv/rGfqxQCg0FXEfH3kuEEKBpE0Tb/
GjLPgws4NhKY0PrQXjFjunZYBJJsG0vUEOev+Owmc6/HNv23QSb+emkR/Eqf/78N
+vv6wjqhX5t52hjS18eHxt7DnJUEv0uM/ennoQ3EHIjUgAIUaeeEd0M9WZ5U5GS+
0L5zv2+NJaMsybb1wPZqNnYHeE5x1Q==
=cLBI
-----END PGP SIGNATURE-----

--lj45d7crl7fcn6q3--

--===============5178763874446284251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5178763874446284251==--
