Return-Path: <SRS0=v5f2=PE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D8C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Oct 2021 15:48:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506FB60F70
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Oct 2021 15:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 506FB60F70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 907BB17D3;
	Sat, 16 Oct 2021 17:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 907BB17D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634399320;
	bh=t5sBfqjR8deuFnVBtDAlcOyaBeGvLcWiWvg7jWPJ3iE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s1tn5UAHQvni2x1n+tj3Z1i36nko1DWMygXEuRffOUsLGQcspOtMKwtoOYhbVuWn8
	 T5fs2scTigcS4YprkfWAXCqjFQ2niQEO83/bk67Cn0vfTtMhS0K6zZTtHZ7rgAxBRI
	 Kvrv/g2KbhQUiYPjX6+R/6XnnHxGG0T13W78C/h8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F2CDF801F7;
	Sat, 16 Oct 2021 17:47:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F236F80212; Sat, 16 Oct 2021 17:47:49 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 149D3F80167
 for <alsa-devel@alsa-project.org>; Sat, 16 Oct 2021 17:47:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 149D3F80167
Received: from p508fce7c.dip0.t-ipconnect.de ([80.143.206.124]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1mbluM-0007VR-HD; Sat, 16 Oct 2021 17:47:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: rockchip: i2s-tdm: Drop rockchip,
 cru property
Date: Sat, 16 Oct 2021 17:47:37 +0200
Message-ID: <2915547.VsDhchvPPW@phil>
In-Reply-To: <20211016105354.116513-3-frattaroli.nicolas@gmail.com>
References: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
 <20211016105354.116513-3-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
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

Am Samstag, 16. Oktober 2021, 12:53:51 CEST schrieb Nicolas Frattaroli:
> This property was only needed for a driver hack, which we can
> remove. Since the bindings were not in any kernel release yet, we
> are able to just drop the property instead of silently accepting
> and ignoring it.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for doing that change :-)
Heiko


> ---
>  .../bindings/sound/rockchip,i2s-tdm.yaml         | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> index ce3e18b50230..6a7c004bef17 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> +++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> @@ -82,12 +82,6 @@ properties:
>          - tx-m
>          - rx-m
>  
> -  rockchip,cru:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description:
> -      The phandle of the cru.
> -      Required if neither trcm-sync-tx-only nor trcm-sync-rx-only are specified.
> -
>    rockchip,grf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -144,15 +138,6 @@ required:
>    - rockchip,grf
>    - "#sound-dai-cells"
>  
> -allOf:
> -  - if:
> -      properties:
> -        rockchip,trcm-sync-tx-only: false
> -        rockchip,trcm-sync-rx-only: false
> -    then:
> -      required:
> -        - rockchip,cru
> -
>  additionalProperties: false
>  
>  examples:
> @@ -177,7 +162,6 @@ examples:
>              resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
>              reset-names = "tx-m", "rx-m";
>              rockchip,trcm-sync-tx-only;
> -            rockchip,cru = <&cru>;
>              rockchip,grf = <&grf>;
>              #sound-dai-cells = <0>;
>              pinctrl-names = "default";
> 




