Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D09C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:22:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E88161A07
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 13:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E88161A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94FFE1F11;
	Tue, 27 Jul 2021 15:21:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94FFE1F11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627392124;
	bh=2r0Fhs8d3a9+YKMSBs+/2VBJgb52qadIj/04nLw/YKU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IPpmnq9+sC22C+05V45dkW2Q5/e8pYytbKF3ELckKVnXIuhLmdfE0a/iiD6V5nPlC
	 4ly7wS62tzHKR8gORqLCbmNGuV2LcLsYs9GHNXTgM6TFIIMT5KtHJZ2DRm3JrJQUeD
	 jfj+I/lODMFSRAT87f6NmEHAvFcca9SaTs1vPFq8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC795F804E4;
	Tue, 27 Jul 2021 15:19:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2B32F804E3; Tue, 27 Jul 2021 15:19:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CD4FF804E4
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 15:19:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5CD4FF804E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tLY9JfFe"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7747F61AD1;
 Tue, 27 Jul 2021 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627391984;
 bh=2r0Fhs8d3a9+YKMSBs+/2VBJgb52qadIj/04nLw/YKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tLY9JfFeq8UjEXwOkt1nQU4kHNbe4R67OLSsPXJZ1OpZZjbPCZ/cWA66HNkPAj5mX
 kvwoy6pjrwo6qJXMUWCmMeVXSJaCC4dtG1dJzZIjia1HlOacsDfrIHIwBtbw6oC1yl
 YaYX4KXMsuT7mpqOwg2szyMo/dKXucEr1Cg9x0AwYzaw1nb0jx6HQiVNNQk5RcDiE0
 GM3A4jC7szBz7QfI28Ew+Kx2VNM5iXE1f//STBy2R9dy/YWHnlPcx3Nzxbxd+7Jiv2
 D9mpNPna03j+UcDMchBi+DMg3ItjXequ9f3/acdG6/pbEBPsCH5FB9rreQDZqi9psI
 DS74MnCVrMgNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/17] ASoC: tlv320aic31xx: fix reversed
 bclk/wclk master bits
Date: Tue, 27 Jul 2021 09:19:25 -0400
Message-Id: <20210727131938.834920-4-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727131938.834920-1-sashal@kernel.org>
References: <20210727131938.834920-1-sashal@kernel.org>
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

