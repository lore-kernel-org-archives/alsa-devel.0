From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: release GPIO when
	component removing
Date: Wed, 8 May 2019 15:33:18 +0900
Message-ID: <20190508063318.GL14916@sirena.org.uk>
References: <20190507051140.240245-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4587135585916553881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65AD5F80796
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 08:33:26 +0200 (CEST)
In-Reply-To: <20190507051140.240245-1-tzungbi@google.com>
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


--===============4587135585916553881==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VJvbhUb+lmZn6RCr"
Content-Disposition: inline


--VJvbhUb+lmZn6RCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 01:11:40PM +0800, Tzung-Bi Shih wrote:

> +static void max98357a_component_remove(struct snd_soc_component *component)
> +{
> +	struct max98357a_priv *max98357a =
> +			snd_soc_component_get_drvdata(component);
> +
> +	if (max98357a->sdmode)
> +		devm_gpiod_put(component->dev, max98357a->sdmode);
> +}

This is an obvious mess, if you're explicitly freeing devm_ allocated
resources in the common case something is going wrong.  Just move the
initial allocation to the device level probe so devm can do what it's
supposed to.

--VJvbhUb+lmZn6RCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSeC0ACgkQJNaLcl1U
h9CC9Qf+P+HfwZQ2NQJVCylX+n5sXt4SFdkuYNUZF2uNLfS0W2EXZJO5SnN9COdu
e2szxEGXPmOT/GMSLE1w2hgarg6fkaShOTd8gAFIEOdMie87Gc8ifnG2Nqatruky
UMYl+8x0gobWIRqF5mfzvXa63WmX4u/vKI63Bxk7ZXq+9w705khfnMDAARuLdIXF
HnR4HWfqMueejJ+wtirKS6gzR233uNm/YrdEV3NGCxAY9PbAberrYwoGHe/MAn/7
z3J6nLeNlbz41C5puDRzUGMq3rbqnxDcvLGSt+AVZCZWDDw41G0adyA2TosTPNzI
8slThEd1QlczqOFQJEpr5rP+b9mxhw==
=UmSk
-----END PGP SIGNATURE-----

--VJvbhUb+lmZn6RCr--

--===============4587135585916553881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4587135585916553881==--
