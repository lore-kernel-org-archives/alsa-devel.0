From: Mark Brown <broonie@kernel.org>
Subject: Re: [V3 2/2] ASoC: max98373: Added Amplifier Driver
Date: Thu, 4 Jan 2018 17:13:45 +0000
Message-ID: <20180104171345.GI10774@sirena.org.uk>
References: <1515004757-22267-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0222517289629146679=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D6A4267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 18:14:05 +0100 (CET)
In-Reply-To: <1515004757-22267-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: bryce.ferguson@rockwellcollins.com, alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, kuninori.morimoto.gx@renesas.com, arnd@arndb.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, m-stecklein@ti.com, romain.perier@collabora.com, dannenberg@ti.com, robert.jarzmik@free.fr, supercraig0719@gmail.com, jbrunet@baylibre.com
List-Id: alsa-devel@alsa-project.org


--===============0222517289629146679==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2018 at 10:39:17AM -0800, Ryan Lee wrote:

This looks mostly good.  There are a few smaller issues but I think at
this point it's most sensible to apply and fix those incrementally so
I'll do that, please follow up with patches fixing the remaining issues.

> --- /dev/null
> +++ b/sound/soc/codecs/max98373.c
> @@ -0,0 +1,971 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2017, Maxim Integrated */

SPDX headers are supposed to be C++ comments, please send a followup
patch fixing this.

> +static int max98373_get_bclk_sel(int bclk)
> +{
> +	int i;
> +	/* match BCLKs per LRCLK */
> +	for (i = 0; i < ARRAY_SIZE(bclk_sel_table); i++) {
> +		if (bclk_sel_table[i] == bclk)
> +			return i + 2;
> +	}
> +	return 0;
> +}
> +static int max98373_set_clock(struct snd_soc_codec *codec,

Missing blank line between the functions.

> +	}
> +	/* set DAI_SR to correct LRCLK frequency */

Another missing blank line.

> +static int max98373_dai_tdm_slot(struct snd_soc_dai *dai,
> +	unsigned int tx_mask, unsigned int rx_mask,
> +	int slots, int slot_width)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct max98373_priv *max98373 = snd_soc_codec_get_drvdata(codec);
> +	int bsel = 0;
> +	unsigned int chan_sz = 0;
> +	unsigned int mask;
> +	int x, slot_found;
> +
> +	max98373->tdm_mode = true;

This should really also support disabling TDM mode - if the parameters
are all 0 just turn TDM off.  Again can be fixed in a followup.

> +SOC_SINGLE_TLV("DHT Gain Min", MAX98373_R20D1_DHT_CFG,
> +	MAX98373_DHT_SPK_GAIN_MIN_SHIFT, 9, 0, max98373_dht_spkgain_min_tlv),
> +SOC_SINGLE_TLV("DHT Rot Pnt", MAX98373_R20D1_DHT_CFG,
> +	MAX98373_DHT_ROT_PNT_SHIFT, 15, 0, max98373_dht_rotation_point_tlv),
> +SOC_SINGLE_TLV("DHT Attack Step", MAX98373_R20D2_DHT_ATTACK_CFG,
> +	MAX98373_DHT_ATTACK_STEP_SHIFT, 4, 0, max98373_dht_step_size_tlv),
> +SOC_SINGLE_TLV("DHT Release Step", MAX98373_R20D3_DHT_RELEASE_CFG,
> +	MAX98373_DHT_RELEASE_STEP_SHIFT, 4, 0, max98373_dht_step_size_tlv),

You should add a Volume on the end of these control names so that
userspace knows how to display them properly; it's a little confusing as
they're not actually gains but it tends to work out better.  Same for
most of the other TLV controls.

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpOYMgACgkQJNaLcl1U
h9CtoQf+Ped45sTIstDYqeYZOEJ9OvXwYbrWtGvJK4GtnP3fvlAD5cwRiKfM9HN8
TzeYn74v3bShwcfha1wfjDfi2QdYLPOHN/0JRi6RZOeYA6ps+v8ihMNoE/FlroUu
Grnugasgmtz+4xumzZHAS20oegxDMX1mIzr+FdMvi6xHK9UJLWYVYx03Lq1jHxKi
ZO8ik2wVPKuReQXqceY7rIi6PRdhJMIX+cfwCzzhIR2TA/xBCPCITv3DjZcirMLE
64H4q/xN5BTbL94iwQAXBNMtwIlpNu0holagxu0xUU63vA6I4bK20USZWJhkfzqe
8XngdcBxAXaOeXgm1HE/4FjwS0qzjQ==
=sQ7T
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--

--===============0222517289629146679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0222517289629146679==--
