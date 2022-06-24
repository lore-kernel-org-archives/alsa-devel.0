Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8005FC43334
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jun 2022 10:49:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 678AD1838;
	Fri, 24 Jun 2022 12:48:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 678AD1838
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656067786;
	bh=N1Z/0RghyFfehixXn+LE7Fsqk3oKYwhb4qWTgZ+cabQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LOJjDICQvizKqgps46CVry4/tSO8sGjitdxV2rMf4K5S/dZdaomx07WJcn8Ivz2Sl
	 0VnO+iPf1FBBV/HDwcQ+JLKKARQXWqD0EgYxpjpdL6XI20u+9PlOGi7ctKHOaVnbPh
	 TgW2fvYRdjkuWFpkCaGBaqu5grY2hUHqw+gmJRcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02875F8053E;
	Fri, 24 Jun 2022 12:48:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81671F8053E; Fri, 24 Jun 2022 12:48:04 +0200 (CEST)
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa1.perex.cz (Postfix) with ESMTP id 75B4BF80139
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2022 12:47:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75B4BF80139
Received: from hq-00021.holoplot.net (unknown [176.126.217.202])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 1DA5C50457A;
 Fri, 24 Jun 2022 10:47:25 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: broonie@kernel.org,
	ryan.lee.analog@gmail.com
Subject: [PATCH 6/8] ASoC: max98396: Fix register access for PCM format
 settings
Date: Fri, 24 Jun 2022 12:47:10 +0200
Message-Id: <20220624104712.1934484-7-daniel@zonque.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624104712.1934484-1-daniel@zonque.org>
References: <20220624104712.1934484-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>
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

max98396_dai_set_fmt() modifes register 2041 and touches bits in the mask
0x3a. Make sure to use the right mask for that operation.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/max98396.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98396.c b/sound/soc/codecs/max98396.c
index faa81b4bb709..0a1d98279a3e 100644
--- a/sound/soc/codecs/max98396.c
+++ b/sound/soc/codecs/max98396.c
@@ -349,12 +349,15 @@ static int max98396_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = codec_dai->component;
 	struct max98396_priv *max98396 = snd_soc_component_get_drvdata(component);
-	unsigned int format = 0;
+	unsigned int format_mask, format = 0;
 	unsigned int bclk_pol = 0;
 	int ret, status;
 	int reg;
 	bool update = false;
 
+	format_mask = MAX98396_PCM_MODE_CFG_FORMAT_MASK |
+		      MAX98396_PCM_MODE_CFG_LRCLKEDGE;
+
 	dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -405,7 +408,7 @@ static int max98396_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		ret = regmap_read(max98396->regmap, MAX98396_R2041_PCM_MODE_CFG, &reg);
 		if (ret < 0)
 			return -EINVAL;
-		if (format != (reg & MAX98396_PCM_BCLKEDGE_BSEL_MASK)) {
+		if (format != (reg & format_mask)) {
 			update = true;
 		} else {
 			ret = regmap_read(max98396->regmap,
@@ -422,8 +425,7 @@ static int max98396_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 
 	regmap_update_bits(max98396->regmap,
 			   MAX98396_R2041_PCM_MODE_CFG,
-			   MAX98396_PCM_BCLKEDGE_BSEL_MASK,
-			   format);
+			   format_mask, format);
 
 	regmap_update_bits(max98396->regmap,
 			   MAX98396_R2042_PCM_CLK_SETUP,
-- 
2.36.1

