From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: add a status for runtime
	suspend/resume
Date: Wed, 4 Feb 2015 20:17:31 +0000
Message-ID: <20150204201731.GE21293@sirena.org.uk>
References: <1423057334-26654-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6399054486006075365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00C4A2604D5
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 21:17:39 +0100 (CET)
In-Reply-To: <1423057334-26654-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6399054486006075365==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bpxC8ASQF/HCS2bl"
Content-Disposition: inline


--bpxC8ASQF/HCS2bl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2015 at 09:42:14PM +0800, Jie Yang wrote:

> +	else if (pdata->pm_state == HSW_PM_STATE_RTD3)
> +		goto suspend;
> +

>  	sst_hsw_dsp_runtime_sleep(hsw);
> +
> +suspend:
> +	snd_soc_suspend(pdata->soc_card->dev);
> +	snd_soc_poweroff(pdata->soc_card->dev);
> +
>  	pdata->pm_state = HSW_PM_STATE_D3;

This is a pretty big jump for goto and it's not the usual goto as error
handling idiom either; it seems better to refactor the code so that this
isn't required.  For example have a runtime PM function which is also
called by the system suspend path.

--bpxC8ASQF/HCS2bl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJU0n5bAAoJECTWi3JdVIfQRbAH90Gy7jIwsPXWOghv+CuQJ5Lv
vecT0xm3POij5gECqHWLX4tpH4O27wcexyttBxv0wMgp8GXXmg+3WqcDGpxQtDyC
KTXyrtCsgSbtBHWyAMmRkNMN+CL7CTL1yyB6nbOUqzBcbo6ow4Doqjmf7yCCnGEG
lp5jMi/5dI+4GQzIKuHa+UKsFMNK4p8JcaZhjmB8WieMtqv7wjZk0vR9PKgy/30E
suvg4OE2aui9Xmzop3UsRJKNS/ro0Vbqn94gw+H84WbGfbA2wZJst/XCKV6Zw2dU
ipFySmq8HS6N/Fe0m4Z9GSaI0MvtCA+4AdXBmc/zP+ds3xpYqA21oLcFqVdqwA==
=7gU6
-----END PGP SIGNATURE-----

--bpxC8ASQF/HCS2bl--

--===============6399054486006075365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6399054486006075365==--
