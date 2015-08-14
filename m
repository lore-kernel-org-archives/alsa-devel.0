From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ics43432: Add codec driver for
	InvenSense ICS-43432
Date: Fri, 14 Aug 2015 16:55:48 +0100
Message-ID: <20150814155548.GQ10748@sirena.org.uk>
References: <alpine.DEB.2.02.1508131428310.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3354574419721437378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42A9526648D
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:11:24 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508131428310.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3354574419721437378==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e4tCsK4+RPJB2X0k"
Content-Disposition: inline


--e4tCsK4+RPJB2X0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 13, 2015 at 03:55:17PM +0200, Ricard Wanderlof wrote:

> +static int ics43432_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	unsigned int rate = params_rate(params);
> +
> +	if (rate < ICS43432_RATE_MIN || rate > ICS43432_RATE_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}

This isn't adding much, just let the constraint code worry about it.

> +static int ics43432_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:

Similarly here, this isn't adding any discoverability of the
configuration so just omit it.

> +MODULE_DESCRIPTION("ASoC ICS43432 driver");
> +MODULE_AUTHOR("Ricard Wanderlof <ricardw@axis.com>");
> +MODULE_LICENSE("GPL2");

GPLv2.

--e4tCsK4+RPJB2X0k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzg+EAAoJECTWi3JdVIfQzAwH/17PNM0fJs/yspnyoaAT1/pl
pQ6HXYjfy2WsbEtW8G3gt1I8XIxrNl67HFUr4bBOfeDT8Ec9Hwqr8IsW3S7JphkT
LZZXs78olgeC6+qSOIK/qNVu8Ve6w/RHh9+3886Xxl5J10m/YPVD5pOOIkZNvT6m
JqqKWGb56H8J3cl2gt2ELZ6Rw6DQ+103OPx2UQ6pXzdHYDFpRsWC9ARxXszXA6I1
FsKpy1Mt0/tWa7ilnHeE7KsDFdixkY5/qiQMCECQKnVgw6UISE3KxSufIiYPSmV4
iB8pAXcyEIahGAZ8ckk32fCxkk8D6gmSVSvwo3OmR0slyllhsQJwaJJHluxBNjk=
=wFGW
-----END PGP SIGNATURE-----

--e4tCsK4+RPJB2X0k--

--===============3354574419721437378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3354574419721437378==--
