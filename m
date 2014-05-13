From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Fix Baytrail SST DSP
	firmware loading
Date: Tue, 13 May 2014 18:26:04 +0100
Message-ID: <20140513172604.GM12304@sirena.org.uk>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9124420356686852211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7729526547F
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 19:26:15 +0200 (CEST)
In-Reply-To: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9124420356686852211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mEpCxxaDgXcBWxU3"
Content-Disposition: inline


--mEpCxxaDgXcBWxU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 04:47:43PM +0300, Jarkko Nikula wrote:

> -	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	ret = dma_coerce_mask_and_coherent(sst->dma_dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		return ret;

My resolution of the merge of your revised version and topic/intel looks
like this so I *think* it's OK but please check that I did the right
thing.

--mEpCxxaDgXcBWxU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTclWpAAoJELSic+t+oim9Ip0QAJYrYtOb/C2lerHJ6vfvFg18
G0vy83bCoLxF4usBgVb0SRBt0VUKJA5NB/eAbHHCGj2G2xghT8iYAvFpwyziQYCF
oghwBcOOOYPQ1W6JK7Wpgp6lKOzjBSfzzi5Nu7J3TIMPiBdRIUUthqwvo5D6eq07
U5vCwcElJ/l2vPp6efuKSX2AxAi1rVzSKwVyNc3UzrEb5/iAB0/4OHxp40qaFe7O
20RLwa21CU635puqaOMHOTSEShkcj0rgGIUm+VUxVpO15odPBldqv6e0AcJuaoqj
PoNrzUJ7SUlgZ3A3NOXn+h9XfaMzpC3XXiNc/QzspEtMXAHUIbiYW1+OIHKJKljT
VU/dkks7dRPTIlu/f3FF9b8NpdeFVcK2SL4ZAfDgpLjP+7s1TdA005L21Q0TRDY+
zRmj2GaUmJAzHOp2IH5htnxQOgFmfA+OIY7oH5feb6ZwSPwmSUF+scOu0+q8Wx8n
Qo+wQgchWENzuuiYS3Y7YQdu+dbDDQjUDyull1qZth3vaLasBbM9lhrzUazwEcWv
HfzDQIhSIIq8hcx1qKVChUQ073FcIWJVb33C3otJUM6ZNkQQ6l31pywFD/0FagLq
vrEd2x2LuluvCxRlwzGVWzoEeweLawK0WM5DAC06L6ouqcvVPhntA/QFOLDVfJFl
t+grhH8iAv7ASRwb/mUR
=5+eg
-----END PGP SIGNATURE-----

--mEpCxxaDgXcBWxU3--

--===============9124420356686852211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9124420356686852211==--
