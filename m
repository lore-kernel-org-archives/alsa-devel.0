From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: max98357a: manage GPIO for
	component rebinding
Date: Fri, 3 May 2019 13:29:03 +0900
Message-ID: <20190503042903.GY14916@sirena.org.uk>
References: <20190430080107.113871-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4944152721041089040=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 635F5F8075A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 06:29:18 +0200 (CEST)
In-Reply-To: <20190430080107.113871-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: alsa-devel@alsa-project.org, dgreid@google.com, tiwai@suse.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org


--===============4944152721041089040==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m8yuz6kcWj4yJ5vq"
Content-Disposition: inline


--m8yuz6kcWj4yJ5vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2019 at 04:01:07PM +0800, Tzung-Bi Shih wrote:

> The patch changes devm to non-devm API, because we don't have equivalent
> API for ASoC components (e.g. compm_).

Don't do this, if you're missing a needed API then add it.

--m8yuz6kcWj4yJ5vq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzLw44ACgkQJNaLcl1U
h9Aluwf+KeFXrcGCCW0XtpzMGsFElg8Yk32enWwFClNcq9QwXfoeB6T/cNNLDCH9
WUT9IUMGyyjkfCBOG/hd9Af7OJqZKjcbBm17lRcoKpyVNyBXUZDjx7W6wPtFHaJu
+xN7UcxiqiY1iHfjcF7t8rquFeOxRQQOOr8ddxRyz3RMxkjTuM+ZkHQJpGr6v5LT
54hT/qzXUne5RhSYWxMkou3k69lwxFedvOvh0aCvsTFLgchzLwv2VV+CwSnaLXly
je5NJuXMC7eb1nz3ztuReqLQNu/xtKZ96vCgvbjxp1+Yu/0G5YtyDVPOmgCrywiA
t73ZsnybCbhFeRSGPg2GL7tnp4FJKg==
=dBZL
-----END PGP SIGNATURE-----

--m8yuz6kcWj4yJ5vq--

--===============4944152721041089040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4944152721041089040==--
