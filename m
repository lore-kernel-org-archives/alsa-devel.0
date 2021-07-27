Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FEDC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:20:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B403761A8E
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B403761A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20A591ED9;
	Tue, 27 Jul 2021 15:19:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20A591ED9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627392021;
	bh=2r0Fhs8d3a9+YKMSBs+/2VBJgb52qadIj/04nLw/YKU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OxTsj5W7Xw5k3MsxR+67mdOlDVxMI24cGD94f3H8lgb6M3nKT0mGFaftOZt+1bx5c
	 IFh4gQOarnZhdZLuY/0lc87oRJZPRu3RQZZQyJ1XUlYGTo/PXItoysUoKEh1tsB3zf
	 tlgAcNDQd4ijvfDgP/V2aKKSStjFV5sKHtxQ8xMo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8115AF80258;
	Tue, 27 Jul 2021 15:19:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1728DF8026C; Tue, 27 Jul 2021 15:19:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29369F80212
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 15:19:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29369F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LsK89AGv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F05CE61A3A;
 Tue, 27 Jul 2021 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627391954;
 bh=2r0Fhs8d3a9+YKMSBs+/2VBJgb52qadIj/04nLw/YKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LsK89AGv5DRWPEICydw6NqfQEWHNGZO6BfxmiWTjutgQHYrdI7fhVpX8WqQxLrsdR
 FsRxaBBVyWDDy1thHciVVSbMhr9xQoDfsp0DYQJI0ML2oLebdIsuY++X/3LW0sPms0
 g/BxmuePRkU/e6iwRL1/OIosK17f1wk4gferAew05+vfzjQ+8cmqUTTgfO+huU+Ta2
 z9H+2k91wxEihyPgPV5gM0DHhFFfayXgLVJ4sktHsRT29+p9a8eOvVcFFjNyVijRRK
 GESsGNpjWWOhJbn+QSbCyIncJlCvQZW4XdtiUIy+eiQtnVbP6V/zWK8f8N8OoXKrim
 GjPmjHIi6z2RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 04/21] ASoC: tlv320aic31xx: fix reversed
 bclk/wclk master bits
Date: Tue, 27 Jul 2021 09:18:51 -0400
Message-Id: <20210727131908.834086-4-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727131908.834086-1-sashal@kernel.org>
References: <20210727131908.834086-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Kyle Russell <bkylerussell@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
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

From: Kyle Russell <bkylerussell@gmail.com>

[ Upstream commit 9cf76a72af6ab81030dea6481b1d7bdd814fbdaf ]

These are backwards from Table 7-71 of the TLV320AIC3100 spec [1].

This was broken in 12eb4d66ba2e when BCLK_MASTER and WCLK_MASTER
were converted from 0x08 and 0x04 to BIT(2) and BIT(3), respectively.

-#define AIC31XX_BCLK_MASTER		0x08
-#define AIC31XX_WCLK_MASTER		0x04
+#define AIC31XX_BCLK_MASTER		BIT(2)
+#define AIC31XX_WCLK_MASTER		BIT(3)

Probably just a typo since the defines were not listed in bit order.

[1] https://www.ti.com/lit/gpn/tlv320aic3100

Signed-off-by: Kyle Russell <bkylerussell@gmail.com>
Link: https://lore.kernel.org/r/20210622010941.241386-1-bkylerussell@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 81952984613d..2513922a0292 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -151,8 +151,8 @@ struct aic31xx_pdata {
 #define AIC31XX_WORD_LEN_24BITS		0x02
 #define AIC31XX_WORD_LEN_32BITS		0x03
 #define AIC31XX_IFACE1_MASTER_MASK	GENMASK(3, 2)
-#define AIC31XX_BCLK_MASTER		BIT(2)
-#define AIC31XX_WCLK_MASTER		BIT(3)
+#define AIC31XX_BCLK_MASTER		BIT(3)
+#define AIC31XX_WCLK_MASTER		BIT(2)
 
 /* AIC31XX_DATA_OFFSET */
 #define AIC31XX_DATA_OFFSET_MASK	GENMASK(7, 0)
-- 
2.30.2

