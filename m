Return-Path: <SRS0=u2Q7=AV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F32C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:47:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A662077D
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DAc8C7rq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="VPv8Xnmd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aHTPbn6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A662077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 854231663;
	Fri, 10 Jul 2020 07:46:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 854231663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594360046;
	bh=UfC6ctZpj7zsG5WWyVKGgwU9v2SxdeK5BrpsH1IjzZw=;
	h=From:Subject:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DAc8C7rqSnqZ1ziZQeakKGYZrkX+4DbdkLA86TefZc5tDX9ND2LZbxhbGfIwRVAD2
	 0Ngcgg8eh6Mn8n0Q7+qRso1ZU9xzFXNG6AsqFnFOlm32FwhITEpbZh3aXWBZFjzSBB
	 XhfMAiWRDO5nLt03+JjHDSNIak6lPuAIxXmZhu/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A986BF802A0;
	Fri, 10 Jul 2020 07:45:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D81E6F8015D; Fri, 10 Jul 2020 07:44:54 +0200 (CEST)
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com
 [64.147.123.18])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 174CBF8015A
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2020 07:44:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 174CBF8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="VPv8Xnmd"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="aHTPbn6R"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id AC3C8D3C;
 Fri, 10 Jul 2020 01:44:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Fri, 10 Jul 2020 01:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:subject:to:cc:references:message-id:date:mime-version
 :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=O
 ol9ctihqUSx+gzTjaCciQOFeooJU+2+HpXzalaTxyo=; b=VPv8XnmdWwAWD+Xjh
 dEwdlMcCCBclQtt1RE78+yGPuYhjIhAi7UlvJPCRy47rcuZTE9k3EdpklAZwMwTF
 iprOI0xNYphsShFdTh/KbRkewzlsK6RAbtan59V61GjKOqjei9JvE29fB59D8ed2
 bK1Sys5PZwced9Trpx29RrgZoaXVspdgLB/T+0yfeA8qtO3h56cSEs5mwurotGCM
 QHnf9a9KE2YB3ZIMCQBTciQNpb1NA4E6Q95jNUD6XBs3XXSAZDTkCL5wZIcBTvCR
 vIl2iFDifI0q+Hgzym0XFAjgfA2RxHtSCqStfZKeMrWs5GnmsLWYkqRj5B1e2dt/
 ezlAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=Ool9ctihqUSx+gzTjaCciQOFeooJU+2+HpXzalaTx
 yo=; b=aHTPbn6RpXTQL/52pgbmUu8KPqRV0w/WDbIkx0O3c1D/u5dhBkkAEYdj1
 Np09CzD7WSNFK/WNRJ0EmDVQDqywn9d19Z/hsKEq9MtAfLDKS5JnCchnmbdTEfuI
 a5wlrX5s2GCSu96KpLQC1MBAfW9R7T4czKAOM5svrvFZGBLjhgBdNe8LsdeAXtBA
 /D/5CSRCxBPwra7vGo/w/rLl7wOGu0EpgCqUmMJfU/LFhaia3c3zMnBQHQte702X
 umf65WOTOJjT/4ni8kogRC8MKMBh2H/6ONhafvjZz/w2WIbCeCbRJi5IjGg17iAn
 ydyHBcWOvr1YAmJL15G7pHcSC3UDw==
X-ME-Sender: <xms:TwAIX_tgRzaHhH76ETRqAjl9NwEeoE5VJ4dExqebVJ_JuvvyEE4xbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddtgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffuvfhfkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepvedvffegtdeiheefledtkeeljeevtddvfeeuheeuiefhvdejgfek
 fedugeejjedtnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
 nhgurdhorhhg
X-ME-Proxy: <xmx:TwAIXwfp35ZJQTBtHo6aaRkJrT4O0EwrYB2kUFNhOocx5spGyb-V7w>
 <xmx:TwAIXyzahkRru437STUF4Zx2qDurX6g3Akvd_Ex5N0RWQajPD_30vQ>
 <xmx:TwAIX-PY4eJdJNiaixEGhs1bgHjNPhhT1iyg_cXwVu2HCxtJyE7Sew>
 <xmx:TwAIX-Uu1Xx4rTtk3EaJ3ig74ladgEwPEaLJpd9bv6lkAGtHCGAoqod3c3g>
Received: from [192.168.50.169]
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9CF213280060;
 Fri, 10 Jul 2020 01:44:46 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
Subject: Re: [linux-sunxi] [PATCH 04/16] ASoC: sun4i-i2s: Set sign extend
 sample
To: peron.clem@gmail.com, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-5-peron.clem@gmail.com>
Message-ID: <2910ec3c-25f1-d617-54a8-db6d21acb742@sholland.org>
Date: Fri, 10 Jul 2020 00:44:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200704113902.336911-5-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 7/4/20 6:38 AM, Clément Péron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> On the newer SoCs such as the H3 and A64 this is set by default
> to transfer a 0 after each sample in each slot. However the A10
> and A20 SoCs that this driver was developed on had a default
> setting where it padded the audio gain with zeros.
> 
> This isn't a problem while we have only support for 16bit audio
> but with larger sample resolution rates in the pipeline then SEXT
> bits should be cleared so that they also pad at the LSB. Without
> this the audio gets distorted.
> 
> Set sign extend sample for all the sunxi generations even if they
> are not affected. This will keep coherency and avoid relying on
> default.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 8bae97efea30..f78167e152ce 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -48,6 +48,9 @@
>  #define SUN4I_I2S_FMT0_FMT_I2S				(0 << 0)
>  
>  #define SUN4I_I2S_FMT1_REG		0x08
> +#define SUN4I_I2S_FMT1_REG_SEXT_MASK		BIT(8)
> +#define SUN4I_I2S_FMT1_REG_SEXT(sext)			((sext) << 8)
> +
>  #define SUN4I_I2S_FIFO_TX_REG		0x0c
>  #define SUN4I_I2S_FIFO_RX_REG		0x10
>  
> @@ -105,6 +108,9 @@
>  #define SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED		(1 << 7)
>  #define SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL		(0 << 7)
>  
> +#define SUN8I_I2S_FMT1_REG_SEXT_MASK		GENMASK(5, 4)
> +#define SUN8I_I2S_FMT1_REG_SEXT(sext)			((sext) << 4)
> +
>  #define SUN8I_I2S_INT_STA_REG		0x0c
>  #define SUN8I_I2S_FIFO_TX_REG		0x20
>  
> @@ -663,6 +669,12 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
>  	}
>  	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
>  			   SUN4I_I2S_CTRL_MODE_MASK, val);
> +
> +	/* Set sign extension to pad out LSB with 0 */
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
> +			   SUN4I_I2S_FMT1_REG_SEXT_MASK,
> +			   SUN4I_I2S_FMT1_REG_SEXT(0));
> +

This is just a note; I'm not suggesting a change here:

This does nothing, because SUN4I_I2S_FMT1_REG only affects PCM mode, which is
not implemented in the driver for the sun4i generation of hardware. PCM mode
requires setting bit 4 of SUN4I_I2S_CTRL_REG, and then configuring
SUN4I_I2S_FMT1_REG instead of SUN4I_I2S_FMT0_REG.

Regards,
Samuel
