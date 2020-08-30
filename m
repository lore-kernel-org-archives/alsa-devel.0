Return-Path: <SRS0=QqOT=CI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38527C433E6
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:43:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E3A2078D
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2020 19:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WfkgUUvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E3A2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31F76187D;
	Sun, 30 Aug 2020 21:42:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31F76187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598816620;
	bh=952xsOPdN19VifTUTxcyzuvuGIQ1qouVshketlkOlw4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WfkgUUvWeVwqBRbzpt24dH56zHpND4hzwpbh4wZ6VkUaStHuW0gJX8tM9DXbyY6ub
	 wJDCrvfwcKOG9Fa3t2zOtvQFi/q23sopX7xIs4g3X7b5B9N0L75z7ufRA8Kfj27XB1
	 9hCQTsOq4DN8HE6UTOqG1MkyxZ8IuYsd/6DEQ14Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4234F80096;
	Sun, 30 Aug 2020 21:42:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28622F8020D; Sun, 30 Aug 2020 21:42:45 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18BEAF80096
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2020 21:42:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18BEAF80096
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123]
 helo=phil.fritz.box)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1kCTDl-0002KX-Lu; Sun, 30 Aug 2020 21:42:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: rockchip-spdif: add description for rk3308
Date: Sun, 30 Aug 2020 21:42:29 +0200
Message-Id: <159881654154.22245.11587351037887788062.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818143727.5882-1-jbx6244@gmail.com>
References: <20200818143727.5882-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, broonie@kernel.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, sugar.zhang@rock-chips.com,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 18 Aug 2020 16:37:26 +0200, Johan Jonker wrote:
> A test with the command below shows that the compatible string
> 
> "rockchip,rk3308-spdif", "rockchip,rk3328-spdif"
> 
> is already in use, but is not added to a document.
> The current fallback string "rockchip,rk3328-spdif" points to a data
> set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
> in the mainline as in the manufacturer kernel.
> (Of the enum only RK_SPDIF_RK3288 is used.)
> So if the properties don't change we might as well use the first SoC
> in line as fallback string and add the description for rk3308 as:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: change spdif fallback compatible on rk3308
      commit: bc1f9bff0629a15e3de1ef106ac03cba930227dd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
