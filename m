Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4866CC61DA4
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Feb 2023 15:21:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80543DF2;
	Thu,  9 Feb 2023 16:20:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80543DF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675956107;
	bh=2g/p79IvwubldBThkzYcMNLfYDNVFSIxGP9Bl4yot2E=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VHbSjHUfv+tmTYTrn+hn2LI3Xlf0PSk+BNVnINEyBZgm9RtzZmBXZj5NkuBJIpicJ
	 B4iam5/mLAKM7/zKbQMf59aK+sMKXTj1TOdXOsvwBOpK6lDa86C/B9pXTeu9m6BtTN
	 OAgOhkB4xqzgTU0en6vONxexgrd6j9ylOIYvtIX0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5643CF800E4;
	Thu,  9 Feb 2023 16:20:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83645F800E4; Thu,  9 Feb 2023 16:20:28 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 07261F80027
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2023 16:20:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07261F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mHeYIICF
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3AA61AD2;
	Thu,  9 Feb 2023 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDF0C433D2;
	Thu,  9 Feb 2023 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675956021;
	bh=2g/p79IvwubldBThkzYcMNLfYDNVFSIxGP9Bl4yot2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHeYIICFuWexoDo+WVFBfDJ82Mpz5FmzWkwbx1I+z1JumRgEzFK+/yFY7sv7cRWlH
	 le1a5o9UMtm1CtvyETk+AK/dFnt1E85ZC1SlsFWYv6XvtgTS0mQ7iXapQRPVIGpcgW
	 smqoGs6FI2mB/KyQ24CQwhPqJdCgn1j6yUGl+Y29JDFZU2uILECSwrv1Fze9W0VeMj
	 QWAxp2pGgc0Ml95+qHbVDP64O+PQvYQZu60bPVC/+O6r5dLCZCiQQsZNi1WVOqBXsU
	 P0PUZBA+sqAgnbA9XWhgVa9LCCkNK8ARBfU7O3VGrZgFTppU9bi+DU7m9nQUpNIY+j
	 yD31xu4ThnE1A==
Date: Thu, 9 Feb 2023 15:20:15 +0000
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com
Subject: Re: [PATCH] ASoC: rt712-sdca: Add RT712 SDCA driver for Jack and Amp
 topology
Message-ID: <Y+UPL4nK7yZ2pWgP@sirena.org.uk>
References: <20230207090946.20659-1-shumingf@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IXN99ClnvCK3IB0G"
Content-Disposition: inline
In-Reply-To: <20230207090946.20659-1-shumingf@realtek.com>
X-Cookie: Anger is momentary madness.
Message-ID-Hash: XOGFEANDNYBEMJBP6JU7S5WBVBAY2BXX
X-Message-ID-Hash: XOGFEANDNYBEMJBP6JU7S5WBVBAY2BXX
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 flove@realtek.com, oder_chiou@realtek.com, jack.yu@realtek.com,
 derek.fang@realtek.com, pierre-louis.bossart@intel.com, bard.liao@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XOGFEANDNYBEMJBP6JU7S5WBVBAY2BXX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--IXN99ClnvCK3IB0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2023 at 05:09:46PM +0800, shumingf@realtek.com wrote:

> +static int rt712_sdca_mux_put(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_dapm_kcontrol_component(kcontrol);
> +	struct snd_soc_dapm_context *dapm =
> +		snd_soc_dapm_kcontrol_dapm(kcontrol);
> +	struct rt712_sdca_priv *rt712 = snd_soc_component_get_drvdata(component);
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	unsigned int *item = ucontrol->value.enumerated.item;
> +	unsigned int mask_sft;

> +
> +	snd_soc_dapm_mux_update_power(dapm, kcontrol,
> +		item[0], e, NULL);
> +
> +	return 1;
> +}

This unconditionally returns 1 if the value written is in bounds which
means that an event will always be signalled.  Please use mixer-test to
check for this and other issues.

> +	/* set sampling frequency */
> +	if (dai->id == RT712_AIF1) {
> +		regmap_write(rt712->regmap,
> +			SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_CS01, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0),
> +			sampling_rate);
> +		regmap_write(rt712->regmap,
> +			SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_CS11, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0),
> +			sampling_rate);
> +	}
> +
> +	if (dai->id == RT712_AIF2)
> +		regmap_write(rt712->regmap,
> +			SDW_SDCA_CTL(FUNC_NUM_AMP, RT712_SDCA_ENT_CS31, RT712_SDCA_CTL_SAMPLE_FREQ_INDEX, 0),
> +			sampling_rate);

This would be better written as a switch statement, there were some
other checks for variants that looked to have similar issues.  It makes
it clearer that only one option can be selected and allows you to have a
default check that makes sure that any new variant with another AIF gets
handled.

--IXN99ClnvCK3IB0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPlDy8ACgkQJNaLcl1U
h9BfJAf/Rhj/OYwqiE8Yupwa+75HWQZbeAo3AN51DFf+79dTNF3emDvhpfPxkgG7
G95mCYsMR9P7+DrpCzGgzGs0M3bL98t837iIOde8OebYZACYqe0lh0OKW5e9mpRi
9U6GOpCyI1855Z3ywYqw19OeDjGc4stb8GcNfoem7kUw/6mnF62bMU3UhS7fF6e6
TZObT14/OkORhcUzmxFkTEbL2HUSR+0KVjTAI9sTyoLWiMJUbcKOuuzclAcO1J8O
cVEfw5UWHxj5AIB5ftIXCR19lgHAL7NvW+mUv+ed+GbzpS38CeyfFQi+Q3QAiEGB
G/A6+dwmoZsl66VpgLHoErzpCl0rAg==
=ZX1H
-----END PGP SIGNATURE-----

--IXN99ClnvCK3IB0G--
