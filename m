From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: zx: Add zx296702 SPDIF support
Date: Fri, 22 May 2015 13:09:14 +0100
Message-ID: <20150522120914.GI21391@sirena.org.uk>
References: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
 <1430915885-30656-2-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3974997829955774051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6D11265AFE
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:07:39 +0200 (CEST)
In-Reply-To: <1430915885-30656-2-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, lgirdwood@gmail.com, zte-lt@lists.linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3974997829955774051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2015 at 08:38:04PM +0800, Jun Nie wrote:
> Add driver for zx296702 SPDIF controller

This all seems fine apart from the fact that you're adding a new DT
binding with no binding documentation - all new DT binndings require
binnding documentation.

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXxxpAAoJECTWi3JdVIfQSgoH/0Wrb5R6+4cdJRVOT9KPUNt6
NIhcA4n6xrhQd551EKvowkGQzzL5oe7Q1EBlYih1lJIKCz8e8Ud1fLRp0r8n/nuJ
ONb8VPFtkfxWcDXdCHKFqGYorzMGRxOKc/nEmlz7u0fc9rswaG5UCkOWx0/hlERi
SQ5hoYm5+lYGl6FlNgNvs+cyBzY967ruepGm1IPY7iLBRq4fkbG68ftYr3Xy6kJW
rToQxwSI6jnfSS+H4K0krnLlhagGjRPvHXeVpCWHc3dPb3ppoiV/C1NNTAvduHUs
bCxbQg03uIfyRO3kRndS90CTq7v7SOcfFeSg9sFAb/EIO4ohChY0k7lZG1TNuzg=
=2AG8
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--

--===============3974997829955774051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3974997829955774051==--
