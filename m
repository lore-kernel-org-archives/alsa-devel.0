Return-Path: <SRS0=5I5Q=XH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A896C4CEC6
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:53:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7041206A5
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z2yTitK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7041206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCA17175E;
	Thu, 12 Sep 2019 18:52:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCA17175E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568307201;
	bh=X1ZZ95esnTAggiWLcCEuDymNLqFtgMBSM0LyEvcfDwk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z2yTitK/f8ZEfsV4Mf5goi2sZKSWXkzbblBVu5pezpwfLzT90/Yz74T7Z/9YTuUKZ
	 kIrpZK4PUEPVtIsBw/JXWliQG8ErV7KLk/hNx1H97kxGCvVHaHiTyNDzVQFjQxXzcz
	 60wrYVh7tB70hsZCbRMaEvt6Q6zeBaJYC1sR349g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 700D6F80321;
	Thu, 12 Sep 2019 18:52:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49A43F80368; Thu, 12 Sep 2019 18:52:30 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id CBEFAF802DF
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2019 18:52:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBEFAF802DF
X-UUID: c25dc2ac038140f38a28f2d89c56586c-20190913
X-UUID: c25dc2ac038140f38a28f2d89c56586c-20190913
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yingjoe.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 2067683331; Fri, 13 Sep 2019 00:52:18 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Sep 2019 00:52:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Sep 2019 00:52:16 +0800
Message-ID: <1568307137.22948.5.camel@mtksdaap41>
From: Yingjoe Chen <yingjoe.chen@mediatek.com>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Date: Fri, 13 Sep 2019 00:52:17 +0800
In-Reply-To: <1568282096-13821-2-git-send-email-jiaxin.yu@mediatek.com>
References: <1568282096-13821-1-git-send-email-jiaxin.yu@mediatek.com>
 <1568282096-13821-2-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 tzungbi@google.com, broonie@kernel.org, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: dt-bingdings: mediatek: mt8183:
 add a property "medaitek, toprgu"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 2019-09-12 at 17:54 +0800, Jiaxin Yu wrote:
> This patch adds a property "mediatek,toprgu" in example so that we could
> use reset controller(usually we call it toprgu or watchdog) to reset audio
> domain regs.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
> index 396ba38619f6..45ca182a4ecc 100644
> --- a/Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
> +++ b/Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible = "mediatek,mt68183-audio";
>  - reg: register location and size
>  - interrupts: should contain AFE interrupt
> +- mediatek,toprgu: A phandle to the TOPRGU which for reset controller unit
>  - power-domains: should define the power domain
>  - clocks: Must contain an entry for each entry in clock-names
>  - clock-names: should have these clock names:
> @@ -20,6 +21,7 @@ Example:
>  		compatible = "mediatek,mt8183-audio";
>  		reg = <0 0x11220000 0 0x1000>;
>  		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
> +		mediatek,toprgu = <&watchdog>;

As mentioned in the other patch, since this is reset controller,
you should use Documentation/devicetree/bindings/reset/reset.txt
instead.

Joe.C


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
