Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC6AC0018C
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 12:56:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F377A23407
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 12:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F377A23407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8710516A9;
	Mon,  7 Dec 2020 13:55:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8710516A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607345780;
	bh=m5XjRWwjU7iYSHfBqXYcMV/ykL5vkCq1eOgZ75If754=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RBD0iqqaNPyoUT3x6463GOYDvdwO77BE7Ak0hN7nadEJyxlC3qgSohBBspSLDkshd
	 lut5A+9RaGI8k3dNXI4rtPtsCmtawEmTk4V/DiNZNIsZ5VxapDPuanhSvNHStXxqZB
	 yo+yOCsAzPKY3oUzqSc5bT79+Ei0iCU73eLl+xJg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D59BFF804C3;
	Mon,  7 Dec 2020 13:54:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5E87F804CA; Mon,  7 Dec 2020 13:54:09 +0100 (CET)
Received: from aposti.net (aposti.net [89.234.176.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DCD8F8021D
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2020 13:54:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DCD8F8021D
From: Paul Cercueil <paul@crapouillou.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 4/5] ASoC: codecs/jz4770: Don't change cap-couple setting in
 HP PMU/PMD
Date: Mon,  7 Dec 2020 12:53:36 +0000
Message-Id: <20201207125338.119397-4-paul@crapouillou.net>
In-Reply-To: <20201207125338.119397-1-paul@crapouillou.net>
References: <20201207125338.119397-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Paul Cercueil <paul@crapouillou.net>, alsa-devel@alsa-project.org,
 od@zcrc.me, linux-kernel@vger.kernel.org
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

There is simply no reason to do that.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4770.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 0da966785aee..909b70e817b4 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -371,9 +371,9 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		/* set cap-less, unmute HP */
+		/* unmute HP */
 		regmap_clear_bits(jz_codec->regmap, JZ4770_CODEC_REG_CR_HP,
-				  REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE);
+				  REG_CR_HP_MUTE);
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
@@ -394,9 +394,9 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		/* set cap-couple, mute HP */
+		/* mute HP */
 		regmap_set_bits(jz_codec->regmap, JZ4770_CODEC_REG_CR_HP,
-				REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE);
+				REG_CR_HP_MUTE);
 
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
-- 
2.29.2

