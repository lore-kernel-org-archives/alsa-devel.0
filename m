Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DEC433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 20:28:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC62C611C9
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 20:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC62C611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 338631607;
	Mon, 12 Apr 2021 22:27:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 338631607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618259298;
	bh=1+4KYDIHljL2KQAWWmokYPPs36J7vyw8CPMGNDtoN5g=;
	h=In-Reply-To:References:Subject:From:To:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YlvI+IAwvAX3DPEphiL5PVe8xrCv9T3zME10Zb7ZXrae9PS1Zd9GbVl+O9JAPCe2O
	 UXYRffrYjyxJ+m2V12KJghWBhk40I6W3ja0xzkFJsv7dFJYZs7sVs02MtqZs3F/v7E
	 ZLU9EjSo4klnVGK/TUYZcbHKedgp/A6XREPDqTqA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9753F8025B;
	Mon, 12 Apr 2021 22:27:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1A94F80269; Mon, 12 Apr 2021 22:27:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B762F800FF
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 22:27:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B762F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tsVI6pDs"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAA80611C9;
 Mon, 12 Apr 2021 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618259238;
 bh=1+4KYDIHljL2KQAWWmokYPPs36J7vyw8CPMGNDtoN5g=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=tsVI6pDsryMf0h9Lje1ZYHwpUCb2/ofclSajhc77s31PaWHr8b7be7KvKdtsWGo1f
 mz3kyInEMHHxe7ShH1ZN0rjnsJdAPX2iRZwsi2SrpOUdJXF6xJ0dN7gSKebxNuewTj
 XR6mWGcMYsbinjGSqTxPXJFDar+3Pp8X5xr6fXtw21BDHZpvzEug0awOEwr/U1egR6
 ZyJyVEjzF31IFkB1cXlKjeKC9FxEcx+bZzlBF41N5raNy27OtfdFFR2MXJ/SJVYPNa
 mehS2uvJtMLlTMKQzXybLyMEKcU4t5bnCPMv4vszOeWFT7l57hemQ/btZ/Rb1gGXXb
 glN4OF2SUBMYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210410111356.467340-4-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-4-jbrunet@baylibre.com>
Subject: Re: [PATCH 3/5] ASoC: rt5682: clock driver must use the clock
 provider API
From: Stephen Boyd <sboyd@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Date: Mon, 12 Apr 2021 13:27:16 -0700
Message-ID: <161825923642.3764895.16526540466177115640@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>
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

Quoting Jerome Brunet (2021-04-10 04:13:54)
> Clock drivers ops should not the clk API but the clock provider (clk_hw)
> instead.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  sound/soc/codecs/rt5682.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
> index 0e2a10ed11da..2eee02ac8d49 100644
> --- a/sound/soc/codecs/rt5682.c
> +++ b/sound/soc/codecs/rt5682.c
> @@ -2634,7 +2634,7 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, =
unsigned long rate,
>                 container_of(hw, struct rt5682_priv,
>                              dai_clks_hw[RT5682_DAI_WCLK_IDX]);
>         struct snd_soc_component *component =3D rt5682->component;
> -       struct clk *parent_clk;
> +       struct clk_hw *parent_hw;
>         const char * const clk_name =3D clk_hw_get_name(hw);
>         int pre_div;
>         unsigned int clk_pll2_out;
> @@ -2649,8 +2649,8 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, =
unsigned long rate,
>          *
>          * It will set the codec anyway by assuming mclk is 48MHz.
>          */
> -       parent_clk =3D clk_get_parent(hw->clk);
> -       if (!parent_clk)
> +       parent_hw =3D clk_hw_get_parent(hw);
> +       if (!parent_hw)
>                 dev_warn(component->dev,
>                         "Parent mclk of wclk not acquired in driver. Plea=
se ensure mclk was provided as %d Hz.\n",
>                         CLK_PLL2_FIN);

Can this code be removed? I don't know why we care to check if the clk
has a parent or not.
