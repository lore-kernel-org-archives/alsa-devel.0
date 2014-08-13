From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 02/12] ASoC: Intel: mrfld: set private data
	for cpu-dai
Date: Wed, 13 Aug 2014 20:45:31 +0100
Message-ID: <20140813194531.GM17528@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4144070310116304059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 559A5265593
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 21:45:49 +0200 (CEST)
In-Reply-To: <1407145563-1303-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4144070310116304059==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W0m5FWf00btK8v85"
Content-Disposition: inline


--W0m5FWf00btK8v85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 03:15:53PM +0530, Subhransu S. Prusty wrote:

> We set the driver private data for media dai so that we can use in media
> operations

This is another one where making the changelog clearer - as far as I can
tell what this is actually doing is moving the existing private data
=66rom being per platform to being per DAI.  That actually seems OK and I
would've applied this but it looks like it depends on patch 1.

This lack of clarity is a frequent issue with both of these DSP
serieses, it's really slowing down review since they're quite big and
hard to read.

> +static int sst_media_dai_probe(struct snd_soc_dai *cpu_dai)
> +{
> +	struct sst_data *sst =3D dev_get_drvdata(cpu_dai->dev);
> +
> +	snd_soc_dai_set_drvdata(cpu_dai, sst);
> +	return 0;
> +}
>  static struct snd_soc_dai_driver sst_platform_dai[] =3D {

Missing blank line here - this is a frequent issue with this code.

--W0m5FWf00btK8v85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT68BYAAoJELSic+t+oim9CwIP/1098wrIQNTzwwYtWcuCZGPl
1HA9buLjEUnFN6GCerGWIYaN2flfw6RjM9vSfics/eBduYcW08Cft7+WYxKa1+0y
XA+UtrNp52+1UyKL51XNNgJnJENL+hYLAH6kj7bvbxJ09cOrpZh8G9GU9xHT1fj6
laguzRQkSocYKMqXVxd00ZNccInqIkIAz+bIPggMeeMed3C2Azv/5AAMJMFG22u0
pJ6XGrRtfwaLRlixkpgFHZQXjydnLp4D+VdrVCCBiPxfWZ0ekMTVVM229yuuc6j2
HEG0Vg0Dw0c2/NCFVfZ3u/zJNOSoHxo84FL9zRifzd1WVV3LAhrSiBhmDrMGbvmk
AVY0ec0C0z2bPTeQ6AtOCcDKJt8IRel6p4sg1+YsCiS0YimnkCPZ2/Bnv7GsfBAw
2GrmizfGr00fGD2CUlKBi2Nlr5J8Z3zQ7wtRioifWKdVeYgsxh4Hcd1WuA5/5bCO
a0ze/bXQHId5nGs9FF9sRtkrXD3BioFxz+oJqMmpBgLhTy/x+3Tw+/niyqUAh/Zc
ntySfovxUMUaChV2ir3BHIrdlsyinnTlfP2yLgG9ThkpFiPBo5W9QD6jKurYv1Ci
4L4Y5yVIJqM+Y7XyI+HgQZO7YkB+Xlwu33ozHXFIZman+udAebdXzBHQ1wPNSJDs
94wtqKd9F5veg77/h4bO
=1wiY
-----END PGP SIGNATURE-----

--W0m5FWf00btK8v85--

--===============4144070310116304059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4144070310116304059==--
