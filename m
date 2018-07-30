From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v0 1/3] ASoC: max9867: Take device out of
	shutdown
Date: Mon, 30 Jul 2018 10:23:46 +0100
Message-ID: <20180730092346.GC5789@sirena.org.uk>
References: <20180728154134.GA9665@lenoch>
 <20180728154226.GB9665@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773813968567533348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 447DC26779B
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 11:23:46 +0200 (CEST)
In-Reply-To: <20180728154226.GB9665@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0773813968567533348==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 28, 2018 at 05:42:26PM +0200, Ladislav Michl wrote:
> Move device enable to probe function to make line bypass
> and mic sidetone work. Doing that from prepare callback
> lets only DAC to produce output.
> While here move suspend and resume functions to the more
> common place.

It'd be better to move this to DAPM so that the device is enabled only
when one of the paths in use - do it from set_bias_level().

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte2SEACgkQJNaLcl1U
h9CIzgf+N3tzxVuMbIzSQp1M9LTIvYPKXguBZsop4MTrdW+ilgZTYt8Tyg+10J/s
B3LvEI3gv6nFggHcKEE5MrulW93XtV6STW/vC3EbmTqdt0SC8S8pivnG01+MKu6Q
tiOWPE7nRRxIL1zb2qeHWts4p9t7zO/DjOn0CXAM5G5VX27SeCXgUY6ZTS6sazLM
d71Er9O5K3jfuxD+b2MPNA6txaYEMn7mE3yD/zyC3TyElr0pJ2VhQLyQdUayka7+
aEYFOtRqSzorGCuNiotMmiXRTsngwl5v6crYVxe8uJO5ABM8J6+fGr9hA4Fi5EBV
hZZLISmquKJnrGoFy62yZkaSo6nQNw==
=ViWk
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--

--===============0773813968567533348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0773813968567533348==--
