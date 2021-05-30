Return-Path: <SRS0=W/rr=KZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0BCC47091
	for <alsa-devel@archiver.kernel.org>; Sun, 30 May 2021 20:36:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC94610A8
	for <alsa-devel@archiver.kernel.org>; Sun, 30 May 2021 20:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC94610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 740A54E;
	Sun, 30 May 2021 22:35:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 740A54E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622406964;
	bh=SgJJ+lOG4ryBeSujeUFDNg/V0cop9NoG/qr5CK7kHVY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UvfICL30F6w6LpXELyns+WDJ14UAP9rMNZtpD8+/UbjPBFiIw/nkNY49R+lysuOjC
	 EOVmi+HL0dxs1SpPS3x8/ZcIsm4OAJDL7kyvXum/9V1h0VKJwpi3yI1yZbJKk3NlcK
	 expdD+5cAd9D3k+5YNH+wufkqN/sRIggXGPnyQYA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7A32F801DB;
	Sun, 30 May 2021 22:35:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 814AFF80254; Sun, 30 May 2021 22:35:12 +0200 (CEST)
Received: from lilium.sigma-star.at (lilium.sigma-star.at [109.75.188.150])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 323B0F80161
 for <alsa-devel@alsa-project.org>; Sun, 30 May 2021 22:35:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 323B0F80161
Received: from localhost (localhost [127.0.0.1])
 by lilium.sigma-star.at (Postfix) with ESMTP id B3CFA1817A0CB;
 Sun, 30 May 2021 22:35:01 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
 by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 55jQULQnARog; Sun, 30 May 2021 22:35:01 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
 by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lB1rIV5dxa9A; Sun, 30 May 2021 22:35:01 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values
Date: Sun, 30 May 2021 22:34:46 +0200
Message-Id: <20210530203446.19022-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: robh@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 tiwai@suse.com, broonie@kernel.org, dmurphy@ti.com, grandmaster@al2klimov.de,
 Richard Weinberger <richard@nod.at>
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

TAS2562_TDM_CFG0_SAMPRATE_MASK starts at bit 1, not 0.
So all values need to be left shifted by 1.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 sound/soc/codecs/tas2562.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2562.h b/sound/soc/codecs/tas2562.h
index 81866aeb3fbf..55b2a1f52ca3 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/sound/soc/codecs/tas2562.h
@@ -57,13 +57,13 @@
 #define TAS2562_TDM_CFG0_RAMPRATE_MASK		BIT(5)
 #define TAS2562_TDM_CFG0_RAMPRATE_44_1		BIT(5)
 #define TAS2562_TDM_CFG0_SAMPRATE_MASK		GENMASK(3, 1)
-#define TAS2562_TDM_CFG0_SAMPRATE_7305_8KHZ	0x0
-#define TAS2562_TDM_CFG0_SAMPRATE_14_7_16KHZ	0x1
-#define TAS2562_TDM_CFG0_SAMPRATE_22_05_24KHZ	0x2
-#define TAS2562_TDM_CFG0_SAMPRATE_29_4_32KHZ	0x3
-#define TAS2562_TDM_CFG0_SAMPRATE_44_1_48KHZ	0x4
-#define TAS2562_TDM_CFG0_SAMPRATE_88_2_96KHZ	0x5
-#define TAS2562_TDM_CFG0_SAMPRATE_176_4_192KHZ	0x6
+#define TAS2562_TDM_CFG0_SAMPRATE_7305_8KHZ	(0x0 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_14_7_16KHZ	(0x1 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_22_05_24KHZ	(0x2 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_29_4_32KHZ	(0x3 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_44_1_48KHZ	(0x4 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_88_2_96KHZ	(0x5 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_176_4_192KHZ	(0x6 << 1)
=20
 #define TAS2562_TDM_CFG2_RIGHT_JUSTIFY	BIT(6)
=20
--=20
2.26.2

