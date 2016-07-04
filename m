From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 3/4] ASoC: mediatek: add BT implementation
Date: Mon, 4 Jul 2016 16:44:06 +0200
Message-ID: <20160704144406.GH6247@sirena.org.uk>
References: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
 <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ltihE5wS63FR6l1A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com, PC.Liao@mediatek.com, ir.lian@mediatek.com
List-Id: alsa-devel@alsa-project.org


--ltihE5wS63FR6l1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 06:56:27PM +0800, Garlic Tseng wrote:

> +static int mt2701_btmrg_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
> +	struct mt2701_afe_private *afe_priv = afe->platform_priv;
> +
> +	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
> +			   AUDIO_TOP_CON4_PDN_MRGIF, 0);

We really shouldn't be writing the registers or other internal data of
the device.  Instead we should be getting the driver for the relevant
hardware component to do it.  If we just write to registers that makes
the interoperation with the real driver for the device more fragile than
it should be, people might update the main driver without noticing the
external driver.

--ltihE5wS63FR6l1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXenYyAAoJECTWi3JdVIfQfhQH/i32VCtEXJSzzqgf/YAROy99
Gur05jgRgUGNFVWGF/gO2QraA2lgOvfB3NeBP6j5hoUyVmKGVH0MHrTpxkODEoss
xrj3b8x5QqfN43PjQxk/GHfZLb+RYI5QtabSPQyquBNfVhTrm8SGkLfoEIEUGZHM
W9wZK8Mkol0qfainp5TtJuzQIwnlDiDZuDcJSVsUvpr4CcM1FotOatjmf+FPUGYJ
GjvBkXu8R7oMhzVN8v15gQysSooPn2o+5wSkfJHAZO6DdBR7boqcm1hPFqHcVA07
rG5/OTN0lfRJRErAAfnUbI2vYYbaDZ1/Oldn5iOLeD9hcEPIVpxtgnh5ET4zMxY=
=yi46
-----END PGP SIGNATURE-----

--ltihE5wS63FR6l1A--
