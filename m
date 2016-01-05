From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: fsl_asrc: sound is wrong after
 suspend/resume
Date: Tue, 5 Jan 2016 13:18:57 +0000
Message-ID: <20160105131857.GD16023@sirena.org.uk>
References: <fd32d943839609d46ca4523e316706f563bf21f0.1450928100.git.zidan.wang@freescale.com>
 <5b07db93fb5a848216a9035c827d99185250d89d.1450928293.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5766757921136075588=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8CDF260710
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 14:19:08 +0100 (CET)
In-Reply-To: <5b07db93fb5a848216a9035c827d99185250d89d.1450928293.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5766757921136075588==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LAK3FBfgZ514qYSN"
Content-Disposition: inline


--LAK3FBfgZ514qYSN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 24, 2015 at 11:42:11AM +0800, Zidan Wang wrote:
> The register ASRCFG is volatile, but some bits need to be recovered
> after suspend/resume.

Please don't send new patches in reply to old ones, it makes it hard to
see what's going on.

--LAK3FBfgZ514qYSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi8LAAAoJECTWi3JdVIfQF2MH/0eG1puxKz/8u6i4HP7roDrP
3S0OL7jUnqbHCPTzCfgAglD6OukSPnPoOD7EIujYo6F2/xwl9kgypjOj2e0QYrt2
io4NV0MtVNYMwX4wJwQD/DbNEnkTMsq54fGBJplLQ+pleW+nLMoV6UkPpiuSeFgV
7T/7zC4Z012EGfKvXUmBQjzwEoybS09thgzByAomWa1gRGbD/f0gbsLxXtRPpUD8
rOjtsbnTeTjkdkekSORrBNZ6c44+g4rlTq72O6S3A9Ct1aa0B0ufzQMOcKIzoI2O
ERAe8SXOaA8h9PZ6uQeCQkgUGJQesuH/8gbUJO2ScLQfqfBT0P2XJTzjD/8aeOY=
=LMgK
-----END PGP SIGNATURE-----

--LAK3FBfgZ514qYSN--

--===============5766757921136075588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5766757921136075588==--
