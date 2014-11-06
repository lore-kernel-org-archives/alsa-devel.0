From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/6] ASoC: Intel: Add Merrifield machine
	driver
Date: Thu, 6 Nov 2014 12:51:19 +0000
Message-ID: <20141106125119.GD8509@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7389864586030000348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A0C2265114
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:51:41 +0100 (CET)
In-Reply-To: <1415098520-14113-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7389864586030000348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jPJw4wSVUvI9Tm/b"
Content-Disposition: inline


--jPJw4wSVUvI9Tm/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:25:20PM +0530, Vinod Koul wrote:

> +static int mrfld_wm8958_set_clk(struct snd_soc_dai *codec_dai)
> +{
> +	int ret = 0;
> +	struct snd_soc_card *card = codec_dai->card;
> +
> +	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xf0, 0xf0, 4, 24);
> +	if (ret < 0) {
> +		dev_err(card->dev, "can't set codec pcm format %d\n", ret);
> +		return ret;
> +	}

We already set this on init - why do we need to set it each time here
too?

--jPJw4wSVUvI9Tm/b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW27GAAoJECTWi3JdVIfQGiUH/RzQUvspKj6c36iGsMTRvmvi
E3OaiX61Burqf7FUHF4qphgNYwSqQI856EcuiCfOb+k3U4U4Lsqufbcex/dWg3nY
GLL4wN4c8+jqxC21s7LMAaPcVlZ4hqx1cTgaxWfcdZ8cCYL1DEU6ggHUdqpmX+9G
/uXRrIj0i3ZYzUep5qGhhZHS8bkgrdziO11HJLdr5evwsjGvvOFz6t15edPiiRH/
CK6gEOuBSvYqR7imKXIy/3P62I89SqvP+LU4PNlcrfWLhBBPU+aWbjD5+HwBSFjh
RuoET7nXGnwEQQmSiv31G9fsdNEupjvtOxdzpZMFSTVPHBGD1IdCXpbWauNQ5e8=
=yQio
-----END PGP SIGNATURE-----

--jPJw4wSVUvI9Tm/b--

--===============7389864586030000348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7389864586030000348==--
