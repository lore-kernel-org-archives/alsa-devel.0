From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: davinci-evm: Add AM43xx-EPOS-EVM
	audio support
Date: Wed, 5 Mar 2014 09:42:59 +0800
Message-ID: <20140305014259.GR13126@sirena.org.uk>
References: <5315DF41.1090302@metafoo.de>
 <1393947831-26116-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3214154041384514753=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85A7726584B
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 03:47:17 +0100 (CET)
In-Reply-To: <1393947831-26116-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de, detheridge@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3214154041384514753==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aH/0uqREc1VzwMkO"
Content-Disposition: inline


--aH/0uqREc1VzwMkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 05:43:51PM +0200, Jyri Sarha wrote:
> Add machine driver support for AM43xx-ePOS-EVM and update associated
> device tree binding document.

Don't send new patches in replies to the middle of threads, that is just
confusing and hard to follow.  Send a new series.

> +/* Logic for EVMs with an aic31xx */
> +static int evm_aic31xx_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_dapm_context *dapm = &card->dapm;
> +	struct device_node *np = card->dev->of_node;
> +	int ret;
> +
> +	snd_soc_dapm_new_controls(dapm, aic31xx_dapm_widgets,
> +				  ARRAY_SIZE(aic31xx_dapm_widgets));
> +
> +	if (np) {
> +		ret = snd_soc_of_parse_audio_routing(codec->card,
> +						     "ti,audio-routing");
> +		if (ret)
> +			return ret;
> +	}

Why not add the DAPM widget table to...

> +	{
> +		.compatible = "ti,am43xx-epos-evm-audio",
> +		.data = &evm_dai_tlv320aic3111,
> +	},

...the data here?

Or alternatively should support for the widgets binding that was
recently added by added to the kernel - that way the binding becomes
more general and doesnn't need individual boards adding?  Indeed ideally
the simple-card binding (which that was added for) could just be used
for these boards.

--aH/0uqREc1VzwMkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFoEgAAoJELSic+t+oim9cwUP/3opsxmpQ99xUHW3bRZq8raK
rkFORwMdraucliM+Z1F6xW/qe/tfgFN/c9GM1kQjQ4tWwSe5jP/SgTWiQ4XM2QSO
DqxQ4NN+oBSWrTcS4GD88O/czH/+slM+QV26KOBvoDrEUyZwhaI4P0IqovFv9Tem
Wc3syMZFwCaVTWEbdXatHMyUAlMC1mf9UaHsDDqMvB+edeBMpiMqDBtdg47eiNzR
y8yBnXFMTYM6Rh0PNqAnHjFlVziS7+txBMcxfA1FlbtWNOQcz/DTaPq/PGtAS84W
C/m1BdqTTSY4ghdjc2l6U8nEqS+PTmrKGI/9/XVNOPHbuGEARU66lcf8uLUj5u6a
X2cT/Cf6Nz9y2ix/rKKR/qgLAljMyVyWcxnOwFqnmN+wbbHkQaCstx86y4OnpVzo
hh61J2SJNoEwR6NGbHF0UDEzFR02Cl/0wCIPgAQzG66vmqJZSSOn0z+PrISkbqfw
HA7HM+XgCTBahnK/lzjZIJJ02w4cXw3aLa/BIZ/rtt9x9tCzlHCIMWroL+4DAQno
ZCRy047sJAXFmDPbKLwxZU93laRTjKnQKqv4WYF/e+B0H6FjAHNLacLYRMGSG8JN
F7KcQfmxjNY0BeAre9ESgahauZBpTtYF03/IzvOWc0ig5G3BtIKvJm7UwbvdpZqe
nZPH2QPPk3pnTPq8/88E
=z/Xf
-----END PGP SIGNATURE-----

--aH/0uqREc1VzwMkO--

--===============3214154041384514753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3214154041384514753==--
