Return-Path: <SRS0=2sca=CU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBFAC43461
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:33:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80666221E7
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KRMh/Nbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80666221E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E665E1674;
	Fri, 11 Sep 2020 19:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E665E1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599845619;
	bh=KDucVu9J9Z2oc5rX1Vb+Kqpqe5eI4z3ohhdwuJt43HE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KRMh/NbvQ2GDZpXuKn8xIByD+989QQN0I8gAM+/MTtMJmiVH+hKbm17zbjX3fhZD8
	 I6eEDrMqocCcKe+A09SOd19uwB8qNs3aPPO+i7A+rvpIxzSmqHStnO2pGfDEtaRZn1
	 m8oug9GaI1vQ0HXvH38z6TFsT8ug3onWcWDcGSIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 725E2F80274;
	Fri, 11 Sep 2020 19:31:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74A83F80240; Fri, 11 Sep 2020 19:31:53 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2290AF8021C
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 19:31:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2290AF8021C
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C9F351BF205;
 Fri, 11 Sep 2020 17:31:42 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/3] ASoC: tlv320aic32x4: Ensure a minimum delay before clock
 stabilization
Date: Fri, 11 Sep 2020 19:31:38 +0200
Message-Id: <20200911173140.29984-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911173140.29984-1-miquel.raynal@bootlin.com>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
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

As indicated in the datasheet, a 10ms delay must be observed after
programming the divisors.

The lack of delay prevents the codec to work properly and the playback
appears extremely slow and totally un-audible on a custom sama5 based
board.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 156c153c12ab..2f78e6820c75 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -230,7 +230,14 @@ static int clk_aic32x4_pll_set_rate(struct clk_hw *hw,
 	if (ret < 0)
 		return -EINVAL;
 
-	return clk_aic32x4_pll_set_muldiv(pll, &settings);
+	ret = clk_aic32x4_pll_set_muldiv(pll, &settings);
+	if (ret)
+		return ret;
+
+	/* 10ms is the delay to wait before the clocks are stable */
+	msleep(10);
+
+	return 0;
 }
 
 static int clk_aic32x4_pll_set_parent(struct clk_hw *hw, u8 index)
-- 
2.20.1

