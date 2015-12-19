From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/19] ASoC: codec: rt5651: add ACPI and OF
	support
Date: Sat, 19 Dec 2015 11:50:47 +0000
Message-ID: <20151219115047.GI5727@sirena.org.uk>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1450406156-22246-13-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5176591869522833664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF360260597
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:50:52 +0100 (CET)
In-Reply-To: <1450406156-22246-13-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5176591869522833664==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24l/woCQRgYlHbSG"
Content-Disposition: inline


--24l/woCQRgYlHbSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 17, 2015 at 08:35:49PM -0600, Pierre-Louis Bossart wrote:

> +#if defined(CONFIG_OF)
> +static const struct of_device_id rt5651_of_match[] = {
> +	{ .compatible = "realtek,rt5651", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt5651_of_match);
> +#endif

You need a binding document for new DT bindings.

--24l/woCQRgYlHbSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWdUSWAAoJECTWi3JdVIfQKtsH/RsyAUFkynkuqFmfT/2C/yMW
MtVm3K3kVKy2JmMhW/Qqx+JSsLfvzlLMccDHM/O8m0Yvid60KD5u6nthDIHmv5wf
8DGSDF2TBFXvW2HQ3m9NMhwEwJyZ8Hsd9wp87ZLfTDpwMptc7YmJellxs0Si/Jo4
kDGjzyz89sTUgCcigt/7KfkuWl1WSRzHknnktKikW4gCYdKM4utm56BBZMrUsxB/
fFdrGVHhaezmzH4RMJvwAT/tqrceZxWEPkQ/AITOj2oteHRJFa+DExoBmFzj/qex
jBV5HtEvxWr/gcVOKX1qjBmvFVJnt+UIDe4+g0PU07cCK+OfID/a3tZ6gtqDN/w=
=Ak1B
-----END PGP SIGNATURE-----

--24l/woCQRgYlHbSG--

--===============5176591869522833664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5176591869522833664==--
