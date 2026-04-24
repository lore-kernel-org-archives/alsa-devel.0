Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E281FED3EF
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:57:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB679601F9;
	Fri, 24 Apr 2026 17:57:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB679601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777046261;
	bh=4jOeEhJHSxvScUoA4/Jq/m4Wd4dXC6sMjhiOXdg/wxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ErJ/f+ucjvXx18taMh8M/hffAqHBLzcJeqRYq81nBd+bIjRAjfPG2E8aS6j2eowpf
	 a0KkBkiqZo8rl9PgeTdUVmr4/SW6Q76HVDPPE5C3gav4I9cpp2UjEKZl6OVpUg2SJO
	 o+UrYX2CKi2BZnHA0slYA6oTO15FroPehZUn1LBo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBA49F805E6; Fri, 24 Apr 2026 17:57:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A0FAF805E4;
	Fri, 24 Apr 2026 17:57:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 095A4F80510; Fri, 24 Apr 2026 17:56:56 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DD9EBF800AE
	for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2026 17:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD9EBF800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=t1bb+Nwv
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B40B60125;
	Fri, 24 Apr 2026 15:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAC1C19425;
	Fri, 24 Apr 2026 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046211;
	bh=4jOeEhJHSxvScUoA4/Jq/m4Wd4dXC6sMjhiOXdg/wxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1bb+NwvxAxODvOTkYyJiEuVp7CSB3exkuf3wAn/SzLrRcYGNO/7v8ANwnREWsxf0
	 OLY7ALi/UVz8dng3hKITRr4wboSzI7AS3dy9ATi17qHgpYLUDpglnKoNNDe0/Y8Xjs
	 827IDUoaIbKMJHb1TlM5nJ9c1m8TKSf80AyHqPrJSHe+VkjwWyP+GdTisLDceGj4i4
	 BAVfldmHx1uDuXMynxsQGAxUM9uKIE4rxLxnXdakaTt3Bq/Nz7GBv7yw+PujJ+1aX/
	 b+SbazxYB4No71B8zXChvRgvDrlGIMdUg/B9oUstlxffSZKNlspRDsBjvcmhdgBPWq
	 g/Eox6Je73cIQ==
Date: Fri, 24 Apr 2026 16:56:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <a76fe4d7-5726-41a9-b569-e676ad94f353@sirena.org.uk>
References: <20260424033953.280520-1-YLCHANG2@nuvoton.com>
 <20260424033953.280520-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A7/8Ezd/UpblK7y8"
Content-Disposition: inline
In-Reply-To: <20260424033953.280520-3-YLCHANG2@nuvoton.com>
X-Cookie: I can't drive 55.
Message-ID-Hash: B3RHL3DIUG4RHBML7NTOGPR7O5TZBHH5
X-Message-ID-Hash: B3RHL3DIUG4RHBML7NTOGPR7O5TZBHH5
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B3RHL3DIUG4RHBML7NTOGPR7O5TZBHH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--A7/8Ezd/UpblK7y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2026 at 11:39:53AM +0800, Neo Chang wrote:

> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

> +static int nau8360_peq_coeff_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);
> +	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
> +	int i, ret, reg = nau8360_peq_regaddr(kcontrol->id.name);
> +	__be16 *data;

> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_TEST,
> +		NAU8360_HW1_MEM_TEST);
> +	for (i = 0; i < params->max / sizeof(u16); i++)
> +		snd_soc_component_write(cp, reg + i, be16_to_cpu(*(data + i)));
> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_TEST, 0);
> +
> +	kfree(data);
> +
> +	return 0;

This should return 1 if the value was changed to generate notifications.

> +/**
> + * nau8360_set_tdm_slot - configure DAI TDM.
> + * @tx_mask: 4-bits value representing each active TX slots. Range: 0 (skip), 1~8. Ex.
> + *	bit 0-3 for left AEC output channel selection
> + *	bit 4-7 for right AEC output channel selection
> + *	bit 8-11 for left Isense output channel selection
> + *	bit 12-15 for right Isense output channel selection
> + *	bit 16-19 for left Vsense output channel selection
> + *	bit 20-23 for right Vsense output channel selection
> + *	bit 24-27 for Junction Temperature (Tj) data output channel selection
> + *	bit 28-31 for VBAT measured data output channel selection
> + * @rx_mask: Bitmask representing active RX slots. Ex.
> + *	bit 0-7 for left DAC channel source selection
> + *	bit 8-15 for right DAC channel source selection
> + *	bit 16-23 for left ANC channel source selection
> + *	bit 24-31 for right ANC channel source selection
> + *
> + * Configures a DAI for TDM operation. Only support 8 slots TDM.
> + */
> +static int nau8360_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
> +	unsigned int rx_mask, int slots, int slot_width)

That's not the way the API is supposed to work, the mask should be which
slots are active as a bitmask.  It looks like what you want here is a
series of muxes which control the routing to some AIF widgets
representing the TDM slots.

> +static const struct regmap_config nau8360_regmap_config = {
> +	.reg_bits = NAU8360_REG_ADDR_LEN,
> +	.val_bits = NAU8360_REG_DATA_LEN,
> +
> +	.max_register = NAU8360_REG_MAX,
> +	.readable_reg = nau8360_readable_reg,
> +	.writeable_reg = nau8360_writeable_reg,
> +	.volatile_reg = nau8360_volatile_reg,
> +	.reg_read = nau8360_reg_read,
> +	.reg_write = nau8360_reg_write,
> +
> +	.cache_type = REGCACHE_RBTREE,

Use REGCACHE_MAPLE unless you've got a particular reason to use
something else, it's a more modern data structure than _RBTREE and makes
choices more suited to current hardware.

> +	/* DAC gain setting 0dB by changing current cell current. */
> +	regmap_update_bits(regmap, NAU8360_R6E_DAC_CFG0, NAU8360_DAC_CUR_MASK,
> +		NAU8360_DAC_CUR_0DB);

Things like gains should normally be user visible and left at the chip
defaults, that way we're not making use case specific decisions.

> +static void nau8360_read_device_properties(struct nau8360 *nau8360)
> +{

> +	nau8360->pbtl_enable = device_property_read_bool(dev, "nuvoton,pbtl-enable");

This is missing from the binding documentation.

> +static int nau8360_i2c_probe(struct i2c_client *i2c)
> +{

> +	return snd_soc_register_component(dev, &soc_comp_dev_nau8360, &nau8360_dai, 1);
> +}

Nothing unregisters this, you should use devm_snd_soc_register_component()

--A7/8Ezd/UpblK7y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnrkr0ACgkQJNaLcl1U
h9CjSQf/cZ04HFQR88XQ9gJA41BhpWc7kggrPzkfx9oEbEOrcokpEMkcGfTz1llx
kMCEO8SyxewbTrx2TH0SnWdUQ4zQSOSfSG+vqwbZO5L2IK1s/hsCOPrRJCKC0ks7
MYB7Q4Qt7isiJ6lpt6HaLusGMH+hCDDjrFxTz1FEn+bUgTqQetb2lds4sLB0h9mN
tfjlBi0K+5953PAG6qGKRMpl1KnngkqN1VhKyQaaZw8eDFMiyM3lC7Xl4lAHMfvd
z5EfPxIJzJqXyI9VJaNiDmxVeFwVuS7V0wN5o5Zxq5h5fCOMdK5DqVGHgY24bXNn
Zb+hYQ2KYnotab4bK4swar5W390z6w==
=rmd2
-----END PGP SIGNATURE-----

--A7/8Ezd/UpblK7y8--
