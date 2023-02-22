Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14C3C61DA4
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Feb 2023 09:35:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE22BE86;
	Wed, 22 Feb 2023 10:34:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE22BE86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677058531;
	bh=QE7F/onyjKYUPvtkvg2U39BtyxJXdvTS4fCO6hEXZIY=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DKJe/PoAKALaW5cdsoPdD2aIdBGWAPXu2YkGZkZewhSEa/wly29V4oEuU1ZPqid17
	 isJcLIw7x6TkSUN1eb510LPFBHeWVmZo0yQNxIfhDYlEKenxNyCdlJ8d1LwD1oDi7+
	 iiguit95xZ8sVHGFXnCRVkZuseFZVbaMEolsd0po=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FCC1F80552;
	Wed, 22 Feb 2023 10:33:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D09D1F80544; Wed, 22 Feb 2023 10:33:31 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [46.235.227.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 394BCF8047C
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2023 10:32:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 394BCF8047C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=ZCMC0VDx
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net
 [82.11.51.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: tanureal)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 4019566021D4;
	Wed, 22 Feb 2023 09:32:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1677058372;
	bh=QE7F/onyjKYUPvtkvg2U39BtyxJXdvTS4fCO6hEXZIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCMC0VDx3Ew6xuhCMweNhAmsc58BbMOnCuVVzzAbkZQTCwpXmwDz252qcUqdhBoU+
	 F5HhKzxDifr/DC54YkRscSj+ssQNbe95Lo0c/+nhmYUyrYICt1x6Tb/iNXdml/JcH1
	 /vDJhpeChdlyInLHfUJMnI7szjn8+naNl4RJYq3LsjjS39TarETLvWjJpP6SfYBtuH
	 pvYoa0VjkEpsxHTAjY7KlErvVuRtE2rjRsBoxGln68ADU87/HjZH8w+OGIo4eVojIM
	 1we+KA8XMoQ9V2YomAr2UhQ/88kCrWT7AE2DIZ+z0bJvGohwBVDa3D8dOHWR9xUmdA
	 o5evPmYLDeO7w==
From: Lucas Tanure <lucas.tanure@collabora.com>
To: David Rhodes <david.rhodes@cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v6 2/4] ASoC: cs35l41: Refactor error release code
Date: Wed, 22 Feb 2023 09:32:42 +0000
Message-Id: <20230222093244.938156-3-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222093244.938156-1-lucas.tanure@collabora.com>
References: <20230222093244.938156-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SZT6MLSSK2UDLUMPGLKZX3ZDEXYYV4RK
X-Message-ID-Hash: SZT6MLSSK2UDLUMPGLKZX3ZDEXYYV4RK
X-MailFrom: lucas.tanure@collabora.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SZT6MLSSK2UDLUMPGLKZX3ZDEXYYV4RK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add cs35l41_error_release function to handle error release sequences.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 64 ++++++++++----------------------------
 1 file changed, 16 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index f2b5032daa6a..c006364e5335 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -369,6 +369,16 @@ static void cs35l41_boost_enable(struct cs35l41_private *cs35l41, unsigned int e
 	}
 }
 
+
+static void cs35l41_error_release(struct cs35l41_private *cs35l41, unsigned int irq_err_bit,
+				  unsigned int rel_err_bit)
+{
+	regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1, irq_err_bit);
+	regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
+	regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, rel_err_bit, rel_err_bit);
+	regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, rel_err_bit, 0);
+}
+
 static irqreturn_t cs35l41_irq(int irq, void *data)
 {
 	struct cs35l41_private *cs35l41 = data;
@@ -405,54 +415,26 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 	 */
 	if (status[0] & CS35L41_AMP_SHORT_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "Amp short error\n");
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_AMP_SHORT_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_AMP_SHORT_ERR_RLS,
-				   CS35L41_AMP_SHORT_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_AMP_SHORT_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_AMP_SHORT_ERR, CS35L41_AMP_SHORT_ERR_RLS);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_TEMP_WARN) {
 		dev_crit_ratelimited(cs35l41->dev, "Over temperature warning\n");
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_TEMP_WARN);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_TEMP_WARN_ERR_RLS,
-				   CS35L41_TEMP_WARN_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_TEMP_WARN_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_TEMP_WARN, CS35L41_TEMP_WARN_ERR_RLS);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_TEMP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "Over temperature error\n");
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_TEMP_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_TEMP_ERR_RLS,
-				   CS35L41_TEMP_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_TEMP_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_TEMP_ERR, CS35L41_TEMP_ERR_RLS);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_BST_OVP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "VBST Over Voltage error\n");
 		cs35l41_boost_enable(cs35l41, 0);
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_BST_OVP_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_OVP_ERR_RLS,
-				   CS35L41_BST_OVP_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_OVP_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_BST_OVP_ERR, CS35L41_BST_OVP_ERR_RLS);
 		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
@@ -460,14 +442,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 	if (status[0] & CS35L41_BST_DCM_UVP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "DCM VBST Under Voltage Error\n");
 		cs35l41_boost_enable(cs35l41, 0);
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_BST_DCM_UVP_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_UVP_ERR_RLS,
-				   CS35L41_BST_UVP_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_UVP_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_BST_DCM_UVP_ERR, CS35L41_BST_UVP_ERR_RLS);
 		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
@@ -475,14 +450,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 	if (status[0] & CS35L41_BST_SHORT_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "LBST error: powering off!\n");
 		cs35l41_boost_enable(cs35l41, 0);
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_BST_SHORT_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_SHORT_ERR_RLS,
-				   CS35L41_BST_SHORT_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_SHORT_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_BST_SHORT_ERR, CS35L41_BST_SHORT_ERR_RLS);
 		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
-- 
2.39.2

