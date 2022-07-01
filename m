Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B32AC43334
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Jul 2022 07:27:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6803E1678;
	Fri,  1 Jul 2022 09:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6803E1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656660434;
	bh=+EYE6GMvdURwdTuawcDBxIhB0j0QgpmWxrJJF1zsUuo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BBtXirjVHeTJFEBjY3LxxqwTDx3LKMONLDgR9ovUgnlg6iHhdPo4wZp1L0mM5KiYC
	 5DDPxAe/qM4DDMCNPgdnjaIvtODtAQSLjhSgjOm+5gJTmEcEKx8IDvEHIulN5gowUQ
	 s/HAnoc75QOx0uaheahjDN1z/cCMqJKnMO3iZXXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED16AF800E8;
	Fri,  1 Jul 2022 09:26:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 044B7F80155; Fri,  1 Jul 2022 09:26:22 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A965F800E8
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2022 09:26:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A965F800E8
Received: from p508fd39e.dip0.t-ipconnect.de ([80.143.211.158]
 helo=phil.localnet) by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1o7B2S-0008DI-2C; Fri, 01 Jul 2022 09:26:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Judy Hsiao <judyhsiao@chromium.org>
Subject: Re: [PATCH v1] FROMGIT: ASoC: rockchip: i2s: Fix error code when fail
 to read I2S_CLR
Date: Fri, 01 Jul 2022 09:26:03 +0200
Message-ID: <11057863.VV5PYv0bhD@phil>
In-Reply-To: <20220701021427.3120549-1-judyhsiao@chromium.org>
References: <20220701021427.3120549-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Brian Norris <briannorris@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Judy Hsiao <judyhsiao@chromium.org>, linux-arm-kernel@lists.infradead.org
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

Hi Judy,

Am Freitag, 1. Juli 2022, 04:14:27 CEST schrieb Judy Hsiao:
> Add the error code '-EBUSY' when fail to read I2S_CLR
> in rockchip_snd_rxctrl() and rockchip_snd_txctrl()
> 
> Fixes: 44f362c2cc6d ("ASoC: rockchip: i2s: switch BCLK to GPIO")
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

those chromium-tags in patch subjects are not meant to go into
upstream submissions, so please drop the FROMGIT.

> ---
>  sound/soc/rockchip/rockchip_i2s.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> index f783994cc16a..fd36c0bacc43 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -171,6 +171,7 @@ static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
>  				retry--;
>  				if (!retry) {
>  					dev_warn(i2s->dev, "fail to clear\n");
> +					ret = -EBUSY;
>  					break;
>  				}
>  			}
> @@ -232,6 +233,7 @@ static int rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
>  				retry--;
>  				if (!retry) {
>  					dev_warn(i2s->dev, "fail to clear\n");
> +					ret = -EBUSY;
>  					break;
>  				}
>  			}
> 




