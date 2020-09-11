Return-Path: <SRS0=2sca=CU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF9CC43461
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:34:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15691221E7
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aF5sun/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15691221E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84A7E1616;
	Fri, 11 Sep 2020 19:33:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84A7E1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599845667;
	bh=BA4hiC90AfHr1vi5inlZCS6bX84YQloUwurzG8W65Rw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aF5sun/hxFqaFomqC6R+3tY2Csb9vr2s1XimK7ZkQ0xZdYbPzIxV2++EbGSaNfLjU
	 slsEM7cLw2dgyo5jIkGj6AtIGxn0Xby/8vQMvxl+Jjoo1fbjoVFIWgp/cJTZNyQM4x
	 ioZTeFo1V+MVPifT7kntbm12K+vcPBoakflTswls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B767F80227;
	Fri, 11 Sep 2020 19:32:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2CB8F802E0; Fri, 11 Sep 2020 19:31:58 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25B93F80100
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 19:31:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25B93F80100
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E70E91BF209;
 Fri, 11 Sep 2020 17:31:43 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 2/3] ASoC: tlv320aic32x4: Fix bdiv clock rate derivation
Date: Fri, 11 Sep 2020 19:31:39 +0200
Message-Id: <20200911173140.29984-3-miquel.raynal@bootlin.com>
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

Current code expects a single channel to be always used. Fix this
situation by forwarding the number of channels used. Then fix the
derivation of the bdiv clock rate.

Fixes: 96c3bb00239d ("ASoC: tlv320aic32x4: Dynamically Determine Clocking")
Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 68165de1c8de..7a1ffbaf48be 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -662,7 +662,7 @@ static int aic32x4_set_processing_blocks(struct snd_soc_component *component,
 }
 
 static int aic32x4_setup_clocks(struct snd_soc_component *component,
-				unsigned int sample_rate)
+				unsigned int sample_rate, unsigned int channels)
 {
 	u8 aosr;
 	u16 dosr;
@@ -750,7 +750,9 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 							dosr);
 
 						clk_set_rate(clocks[5].clk,
-							sample_rate * 32);
+							sample_rate * 32 *
+							channels);
+
 						return 0;
 					}
 				}
@@ -772,7 +774,8 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 	u8 iface1_reg = 0;
 	u8 dacsetup_reg = 0;
 
-	aic32x4_setup_clocks(component, params_rate(params));
+	aic32x4_setup_clocks(component, params_rate(params),
+			     params_channels(params));
 
 	switch (params_width(params)) {
 	case 16:
-- 
2.20.1

