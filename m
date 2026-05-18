Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BDCD4F52
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2026 11:36:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1217460211;
	Mon, 18 May 2026 13:36:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1217460211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779104204;
	bh=DUt3eBS5gIFT83qNHuIFS6ges/Dm2qldEZJiOcVs2FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=edWSXTOVr8cBlPg5PTTbH+ou7HCEyXT1tIClaLyVy/uo8WH+faLjCAbXX1+EMCTnz
	 rttbk9hFb5cpoYb4q9Fe96xdQibaLQv+t89ARn87c+baPu7DUSxx8Z6eRopNYHOWkU
	 Hofz3hRAm1wKCwSg4MbI0g4pl0QYyFh/F9RukQ30=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11323F805E3; Mon, 18 May 2026 13:36:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB832F805E3;
	Mon, 18 May 2026 13:36:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F41CDF804F3; Mon, 18 May 2026 13:35:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 30F2FF80169
	for <alsa-devel@alsa-project.org>; Mon, 18 May 2026 13:35:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30F2FF80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G/5OXYgS
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B263442CA;
	Mon, 18 May 2026 11:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D82C2BCB7;
	Mon, 18 May 2026 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104152;
	bh=DUt3eBS5gIFT83qNHuIFS6ges/Dm2qldEZJiOcVs2FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/5OXYgSVqrykg9/WYzqoeohCDtUEwtzN356dCwuQsg+Ym++6YF12kbDUvMTWJCIm
	 mcMwV/6yO9VgyfjM6Ci489DFJHmNx963pxbmPiQNL6auLHOcurV6VFmhI69pK+Klrg
	 jtfhOWWs5PkgeeZpPPqmkQf7SfwIc5RycEurj6BK8Su1InPXdLrkq9vZmXiQdPO1hp
	 AOrc+66uvbROu3ACPPljyKJfJkd81sjMRce7p8gunMdC6Z4+MGPUkBaQRlbSHsadEW
	 M0h2/Ez9gct2fTCXdMHoa4xrOxj5q1ASTK+53Dyq8x8qHg50p4SaNzV9q+Pis5rSt1
	 2WNJ1mhS0RCAw==
Date: Mon, 18 May 2026 12:35:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v2 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <ce8d5ba7-22aa-47ac-90ab-026ed1ee3928@sirena.org.uk>
References: <20260518024704.118613-1-YLCHANG2@nuvoton.com>
 <20260518024704.118613-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pawrGPWhU6zsJTzn"
Content-Disposition: inline
In-Reply-To: <20260518024704.118613-3-YLCHANG2@nuvoton.com>
X-Cookie: She sells cshs by the cshore.
Message-ID-Hash: V2PKQVG4BEOXTS33XVDEEIA5G3WCOXR7
X-Message-ID-Hash: V2PKQVG4BEOXTS33XVDEEIA5G3WCOXR7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V2PKQVG4BEOXTS33XVDEEIA5G3WCOXR7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--pawrGPWhU6zsJTzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2026 at 10:47:04AM +0800, Neo Chang wrote:

> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

> ---
>  sound/soc/codecs/nau8360-dsp.c |  704 ++++++++++
>  sound/soc/codecs/nau8360-dsp.h |  117 ++
>  sound/soc/codecs/nau8360.c     | 2334 ++++++++++++++++++++++++++++++++
>  sound/soc/codecs/nau8360.h     |  904 +++++++++++++
>  4 files changed, 4059 insertions(+)

There's no update to the build system, this can't have been tested.

> --- /dev/null
> +++ b/sound/soc/codecs/nau8360-dsp.c
> @@ -0,0 +1,704 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * The NAU83G60 Stereo Class-D Amplifier with DSP and I/V-sense driver.

Please make the entire comment a C++ one so things look more
intentional.

> +static int nau8360_reply_from_dsp(struct snd_soc_component *component,
> +	const struct nau8360_cmd_info *cmd_info, int data_size,
> +	void *data, unsigned short dsp_addr)
> +{
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
> +	struct device *dev = component->dev;
> +	unsigned int payload, *data_buf;
> +	int i, j, ret, frag_len, frag_payload_len, data_count, len_pos, pad_len,
> +		pad_len_exp;

> +	frag_payload_len = frag_len - 1;
> +	if (cmd_info->msg_param)
> +		data_count = data_size;

This is the only place where we initialise data_count.

> +	/* check the reply length same as request */
> +	if (data_count && (cmd_info->cmd_id == NAU8360_DSP_CMD_GET_KCS_RSLTS ||
> +			cmd_info->cmd_id == NAU8360_DSP_CMD_GET_KCS_SETUP)) {
> +		dev_warn(dev, "payload_len %d, expected %d",
> +			data_size - data_count, data_size);
> +	}

but we use it unconditionally here.

> +static bool nau8360_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case NAU8360_R00_SOFTWARE_RST ... NAU8360_R02_I2C_ADDR:
> +	case NAU8360_R06_INT_CLR_STATUS:
> +	case NAU8360_R21_VBAT_READOUT ... NAU8360_R22_TEMP_READOUT:
> +	case NAU8360_R41_CLK_CTL2:
> +	case NAU8360_R46_I2C_DEVICE_ID:

Are the I2C addresss and device ID volatile or do they just not have
defaults?

> +static int nau8360_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
> +	unsigned int rx_mask, int slots, int slot_width)
> +{
> +	struct snd_soc_component *cp = dai->component;
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
> +	unsigned int tx_slot_used = 0, rx_slot_used = 0;
> +	int i, func_slot;
> +
> +	if (!rx_mask)
> +		return -EINVAL;

Specifying no slots should really be accepted as disabling TDM.

> +	if (source == NAU8360_CLK_SRC_MCLK)
> +		value = NAU8360_MCLK_SEL_MCLK;
> +	else if (source == NAU8360_CLK_SRC_PLL)
> +		value = NAU8360_MCLK_SEL_PLL;
> +	else
> +		goto err;

This should be a switch statement rather than a cascade of if
statements.  Thre's a number of other examples of this.

> +	/* defalut disable Sense signal after booting */

Typo of default.

> +	/* Set HW2 default volume */
> +	regmap_write(regmap, NAU8360_R97_HW2_CTL7, 0xbf66);
> +	regmap_write(regmap, NAU8360_R98_HW2_CTL8, 0xbf66);

Most user visible controls like volumes should be left at the hardware
defaults, that avoids encoding some specific use case into the driver.

> +	/* set GPIO3 MUX as Clock output */
> +	regmap_write(regmap, NAU8360_R09_GP_CTRL1, 0x1e9e);

This feels very platform specific and should be configured via DT or
quirks.

--pawrGPWhU6zsJTzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoK+ZIACgkQJNaLcl1U
h9DWlQf7BkoZVBAdZ7BLO/zhVK6vMFDAM0NMdLv6MmieTpo89Qng4dGDTNSSdyUd
td98ug4vWi4lkk7fSdokTxF8aFjBlnL+W9lKNNGZshlR8i6+7vOg1vdOdNZa09M4
LEj6Uw6OulIsuBnGAxqlBFmiyZ8MvRPO9g4CMNWzDZYgqtGHxD9Rlxmbx2ZTu+IB
41V5fCn6c1i5ANdVNXDyjC9wII583mqlfiP23lb9eZiszv36wWuZb12s1LBbBGqn
sVn+Q+YKUHMO6z+K3QMxpV2vIl+9qEMt3vpTZzexCm89QF9MIIvNCNcQ1/Nka/5A
bVI7UQC5IInFBrJiTBIN9GP2l7282g==
=PkKK
-----END PGP SIGNATURE-----

--pawrGPWhU6zsJTzn--
