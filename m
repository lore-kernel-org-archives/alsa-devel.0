Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C53ACA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:54:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7FA2064B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lY+4HvqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7FA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10633168A;
	Fri, 18 Oct 2019 17:53:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10633168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571414043;
	bh=8K4RkY5oQRihbN/S4qdOWjwItnwmLBaGm5qgIUqwoFE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lY+4HvqF7M0n5+R5vNzLpsa2Q238y2boUApfCzEqM/ZGUtDZClwvM+EsBmP6JQMGu
	 jORdztV4IiI9rnfTqOAxzKOpWWFEjlyej8Jm5hNM/SMFVTWFIPS0BbmlWJb+sPrwMg
	 di23QqO3fALJeSMbgm8bQRilQvtNNwEt1qQOLhww=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BBA4F8036C;
	Fri, 18 Oct 2019 17:48:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA2F4F805FB; Fri, 18 Oct 2019 17:48:39 +0200 (CEST)
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CA83F80323
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 17:48:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CA83F80323
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1iLUUV-0006rz-GA; Fri, 18 Oct 2019 16:48:35 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
 (envelope-from <ben@rainbowdash.codethink.co.uk>)
 id 1iLUUU-0001z6-Mm; Fri, 18 Oct 2019 16:48:34 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Date: Fri, 18 Oct 2019 16:48:31 +0100
Message-Id: <20191018154833.7560-6-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018154833.7560-1-ben.dooks@codethink.co.uk>
References: <20191018154833.7560-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Cc: linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [alsa-devel] [PATCH v5 5/7] ASoC: tegra: set i2s_offset to 0 for tdm
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

Set the offset to 0 for TDM mode, as per the current setup. Note we also
move the data offset programming to the i2s hw_parameters call as per
the suggestion from Jon Hunter.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
 - fix the review comments and move the i2s offset setting
v3:
 - fix data-offset for dsp-a and dsp-b
---
 sound/soc/tegra/tegra30_i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index 3839e3d955a8..e99126600fc4 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -66,7 +66,7 @@ static int tegra30_i2s_set_fmt(struct snd_soc_dai *dai,
 				unsigned int fmt)
 {
 	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	unsigned int mask = 0, val = 0;
+	unsigned int mask = 0, val = 0, data_offset = 1;
 	unsigned int ch_mask, ch_val = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -100,6 +100,7 @@ static int tegra30_i2s_set_fmt(struct snd_soc_dai *dai,
 		ch_val = TEGRA30_I2S_CH_CTRL_EGDE_CTRL_POS_EDGE;
 		val |= TEGRA30_I2S_CTRL_FRAME_FORMAT_FSYNC;
 		val |= TEGRA30_I2S_CTRL_LRCK_R_LOW;
+		data_offset = 0;
 		break;
 	case SND_SOC_DAIFMT_I2S:
 		val |= TEGRA30_I2S_CTRL_FRAME_FORMAT_LRCK;
@@ -120,6 +121,10 @@ static int tegra30_i2s_set_fmt(struct snd_soc_dai *dai,
 	pm_runtime_get_sync(dai->dev);
 	regmap_update_bits(i2s->regmap, TEGRA30_I2S_CTRL, mask, val);
 	regmap_update_bits(i2s->regmap, TEGRA30_I2S_CH_CTRL, ch_mask, ch_val);
+	val = (data_offset << TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_SHIFT) |
+		(data_offset << TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_SHIFT);
+	regmap_write(i2s->regmap, TEGRA30_I2S_OFFSET, val);
+
 	pm_runtime_put(dai->dev);
 
 	return 0;
@@ -203,11 +208,6 @@ static int tegra30_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	i2s->soc_data->set_audio_cif(i2s->regmap, reg, &cif_conf);
-
-	val = (1 << TEGRA30_I2S_OFFSET_RX_DATA_OFFSET_SHIFT) |
-	      (1 << TEGRA30_I2S_OFFSET_TX_DATA_OFFSET_SHIFT);
-	regmap_write(i2s->regmap, TEGRA30_I2S_OFFSET, val);
-
 	return 0;
 }
 
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
