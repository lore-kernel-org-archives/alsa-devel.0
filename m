Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ABBC77B73
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Apr 2023 14:32:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A06A4EB3;
	Thu, 20 Apr 2023 16:31:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A06A4EB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682001124;
	bh=I4cEvv+GEdKfbFZhbGFcR+MrvoiSBuicUviURQnyCxw=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IvtAaG34TD+P0jCXlDdGraPbl1E5vXwgXle/zKYUF2TStpS7WsYqzztDnershF/nx
	 scDk1WgNiXovHMG3RpgYE4pwGqzGGW8ip8tUoo7dnBSAtw44EDmmgo6N3tjn0ZCdq6
	 M/nKw/ldQCVpqNdUsQUSMWB3acy1lkRxpjLYxxco=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B853F80053;
	Thu, 20 Apr 2023 16:30:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20263F80155; Thu, 20 Apr 2023 16:30:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1B3BF800F8
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2023 16:30:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1B3BF800F8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sWfvXyFj
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA1F6152D;
	Thu, 20 Apr 2023 14:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB43C433D2;
	Thu, 20 Apr 2023 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682001034;
	bh=I4cEvv+GEdKfbFZhbGFcR+MrvoiSBuicUviURQnyCxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWfvXyFjP1McpPH6RJDeQFET1qGveIMfqOOQgly3qSPIKcw6HTD8Wtz7LenrL4Mq7
	 lnxGO4Be2FI+4gRhv4q+SrvpuB5U2Wtw1PHPxQJ3LAu8ufHf89D93xUU12kbI2pVNb
	 GeIpiv7ToI2j8GUqURu6JLFLYGLiYdEk3Z7rCul0Z3TdD9TgBk5jX72vnz6s/bF1BX
	 C7D9HoWqeK29fOURGKWHryym+sOHwQJW49pe36XkgS+yYkCXZaNNCAy05k+8EwERqv
	 w8vrZxTL9ANbBRvzn8iryNXnEzk9MBvgdGWJhx3F7FOeRku9SxuLkq3Fkd+WWS6mXD
	 g528GhxhTGSJA==
Date: Thu, 20 Apr 2023 15:30:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Walker Chen <walker.chen@starfivetech.com>
Subject: Re: [PATCH v2 3/4] ASoC: starfive: Add JH7110 TDM driver
Message-ID: <27e57746-d05b-4983-a631-29306851a478@sirena.org.uk>
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
 <20230420024118.22677-4-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NI6GNQYuRDrkmma6"
Content-Disposition: inline
In-Reply-To: <20230420024118.22677-4-walker.chen@starfivetech.com>
X-Cookie: Above all else -- sky.
Message-ID-Hash: WLSRTXBDE46BAQOAWCBD5TEBW6KG2NXK
X-Message-ID-Hash: WLSRTXBDE46BAQOAWCBD5TEBW6KG2NXK
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WLSRTXBDE46BAQOAWCBD5TEBW6KG2NXK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--NI6GNQYuRDrkmma6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 10:41:17AM +0800, Walker Chen wrote:
> Add tdm driver support for the StarFive JH7110 SoC.

This is mostly fine, though the code all feels a bit messy somehow.
A lot of this is just coding style, I've highlighted a bunch of things
below.  There's also a couple of more substantial issues.

> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TDM driver for the StarFive JH7110 SoC
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.

Please make the entire comment a C++ one so things look more
intentional.

> +static int jh7110_tdm_syncdiv(struct jh7110_tdm_dev *tdm)
> +{
> +	u32 sl, sscale, syncdiv;
> +
> +	sl = (tdm->rx.sl >= tdm->tx.sl) ? tdm->rx.sl : tdm->tx.sl;
> +	sscale = (tdm->rx.sscale >= tdm->tx.sscale) ? tdm->rx.sscale : tdm->tx.sscale;

Please write normal conditional statements to improve legibility.

> +static int jh7110_tdm_clk_enable(struct jh7110_tdm_dev *tdm)
> +{

> +       ret = clk_set_parent(tdm->clk_tdm, tdm->clk_tdm_ext);
> +       if (ret) {
> +               dev_err(tdm->dev, "Can't set clock source for clk_tdm: %d\n",
> +ret);
> +               goto dis_tdm_clk;
> +       }

It's a bit weird to enable clocks and then reparent afterwards, that
seems more likely to run into issues with glitches doing something bad
than reparenting with the clock disabled.

This parenting looks like a system specific configuration (what if
the SoC is driving the audio bus?), and might be better done by using
the clock bindings.  It's also strange that the driver is reparenting
every single time it enables the clocks rather than doing that once on
init.

> +static int jh7110_tdm_suspend(struct snd_soc_component *component)
> +{
> +	return pm_runtime_force_suspend(component->dev);
> +}
> +
> +static int jh7110_tdm_resume(struct snd_soc_component *component)
> +{
> +	struct jh7110_tdm_dev *tdm = snd_soc_component_get_drvdata(component);
> +
> +	/* restore context */
> +	jh7110_tdm_writel(tdm, TDM_PCMGBCR, tdm->saved_pcmgbcr);
> +	jh7110_tdm_writel(tdm, TDM_PCMDIV, tdm->saved_pcmdiv);
> +
> +	return pm_runtime_force_resume(component->dev);
> +}

It is weird that we restore context that we don't save on suspend, the
code *works* but it looks off.

> +static int jh7110_tdm_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
> +	int chan_wl, chan_sl, chan_nr;
> +	unsigned int data_width;
> +	unsigned int dma_bus_width;
> +	struct snd_dmaengine_dai_dma_data *dma_data = NULL;
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai_link *dai_link = rtd->dai_link;
> +
> +	dai_link->stop_dma_first = 1;

A driver shouldn't be forcing dai_link settings, and hw_params is
claerly the wrong place to be configuring something like this which
never varies at runtime - it should be done on init().  If the DAI
really needs this you should extend the core so there's a flag in the
dai_driver which gets checked.

> +	switch (chan_nr) {
> +	case ONE_CHANNEL_SUPPORT:
> +	case TWO_CHANNEL_SUPPORT:
> +	case FOUR_CHANNEL_SUPPORT:
> +	case SIX_CHANNEL_SUPPORT:
> +	case EIGHT_CHANNEL_SUPPORT:

I am having a *really* hard time finding these definitions (which aren't
namespaced...) helpful.  Just write the numbers directly.

> +static int jh7110_tdm_trigger(struct snd_pcm_substream *substream,
> +			      int cmd, struct snd_soc_dai *dai)
> +{
> +	struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		/* restore context */
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			jh7110_tdm_writel(tdm, TDM_PCMTXCR, tdm->saved_pcmtxcr);
> +		else
> +			jh7110_tdm_writel(tdm, TDM_PCMRXCR, tdm->saved_pcmrxcr);
> +
> +		jh7110_tdm_start(tdm, substream);

Why is the write to CR not part of start()?

> +static void jh7110_tdm_init_params(struct jh7110_tdm_dev *tdm)
> +{
> +	tdm->clkpolity = TDM_TX_RASING_RX_FALLING;
> +	if (tdm->frame_mode == SHORT_LATER) {
> +		tdm->elm = TDM_ELM_LATE;
> +		tdm->syncm = TDM_SYNCM_SHORT;
> +	} else if (tdm->frame_mode == SHORT_EARLY) {
> +		tdm->elm = TDM_ELM_EARLY;
> +		tdm->syncm = TDM_SYNCM_SHORT;
> +	} else {
> +		tdm->elm = TDM_ELM_EARLY;
> +		tdm->syncm = TDM_SYNCM_LONG;
> +	}

This looks like it should be a switch statement, and the defintiions
namespaced.  I can't see anyhwere where this ever gets configured to
anything other than SHORT_LATER ever being used so might be better to
just delete.

> +	tdm->ms_mode = TDM_AS_SLAVE;

Please use the modern provider/consumer terminology for clocking.

> +	tdm->clk_tdm_ahb = clks[0].clk;
> +	tdm->clk_tdm_apb = clks[1].clk;
> +	tdm->clk_tdm_internal = clks[2].clk;
> +	tdm->clk_tdm = clks[3].clk;
> +	tdm->clk_mclk_inner = clks[4].clk;
> +	tdm->clk_tdm_ext = clks[5].clk;

Given that the driver only ever interacts with the clocks en masse is
there any point in having all the specific named variables, that'd mean
that the enable/disable could just use loops.

> +/*  DMA registers */
> +#define TDM_FIFO			0x170c0000
> +#define TDM_FIFO_DEPTH			32

None of the defines in the header are namespaced and some of them (like
the above) seem generic enough to be likely to result in conflicts.

--NI6GNQYuRDrkmma6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBTHgACgkQJNaLcl1U
h9DqOAgAhThQ/9yrzRRMXGDWY1z3TSWn/xy6/6JIXnBgvSysHQy5F2YXZhipWYBt
IIIelfg5I4OzL/ZNHEWAcCL/9J88ua+xM9dSRZOKUF33zfMb4woVoesNhLCLICXw
M8jy8naVp0QAD5gIbmvm+hB3DCQAIdlog2kCKQN6OJpfJP/6A4MEAHK7/LKIrseK
Jt63A+1xcCUxK7UJhvR7g2zHS4Zn4z8lU1W7+Jxtx9tDpimn616OcPMmjDo6TwVy
sP8l2dDec7rbcL65a/acq3gZI3CHIurh6nHzXOshSCOkB8aHXVCjMmjRwvKSRLV1
WWjH8VLGisYWBAxzBmLkSlEvs2bjew==
=wfqy
-----END PGP SIGNATURE-----

--NI6GNQYuRDrkmma6--
