Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D14ECAAD3
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 13:57:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70154169F;
	Fri,  9 Sep 2022 15:57:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70154169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662731875;
	bh=PuqfTsJHhJiTHWBoHD1DxYw2W3NHRs+wD7jWpETSi0c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=toHWo9P3L558q/ct5+ZwNETsBkxyBbeRt43lKtjVhJQG6QER8KDov14+NxMlyKt98
	 YUCEsNUJ4G44V3snBiAE6+WE25ghMHf1J5StVqN5ta0UhW/0V6rF1K0iJKd2OPqnOh
	 6njN98OCWgJOjNX3DDbXAZmU7zmqA9xBZYIBvkEM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B499CF8057D;
	Fri,  9 Sep 2022 15:54:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73597F8057A; Fri,  9 Sep 2022 15:54:57 +0200 (CEST)
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 215D8F80527
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 15:54:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 215D8F80527
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org
 header.b="f19OV5Fy"
From: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
 t=1662731682; bh=F2niW+KZ7cR+aKTNLQ9ayIzd0xynY1DOFy+scVH0nu4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f19OV5FyCizyB27g4LsgdtN2U8izv06YSBjl/ZQxM2ox6/qL12dv0sVE/opDmQzKJ
 ECGWqYgfwQInmlO/dngqMBr13P2VTx9CBUGWfGtaaRZsyemqPrWMbcPPP6g1r/g0JS
 S6SmZRJogie0GpaIa15JBn4kvcsBj8cmOlJ4MMHQ=
To: James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 10/10] ASoC: cs42l42: Implement 'set_bclk_ratio'
Date: Fri,  9 Sep 2022 15:53:34 +0200
Message-Id: <20220909135334.98220-11-povik+lin@cutebit.org>
In-Reply-To: <20220909135334.98220-1-povik+lin@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 - <patches@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>,
 asahi@lists.linux.dev, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Matt Flax <flatmax@flatmax.com>
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

The driver wants to know the bit rate on the serial bus and takes that
to be the value set by 'set_sysclk'. The 'set_bclk_ratio' op is a better
fit for figuring out the clocking parameters of the serial bus, so
implement that and give it precedence over the prior methods.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 17 ++++++++++++++++-
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 3f067cf9131a..36761ba0f2c4 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -898,7 +898,10 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	cs42l42->srate = params_rate(params);
 
-	if (cs42l42->sclk) {
+	if (cs42l42->bclk_ratio) {
+		/* machine driver has set the BCLK/samp-rate ratio */
+		bclk = cs42l42->bclk_ratio * params_rate(params);
+	} else if (cs42l42->sclk) {
 		/* machine driver has set the SCLK */
 		bclk = cs42l42->sclk;
 	} else {
@@ -984,6 +987,17 @@ static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
 	return -EINVAL;
 }
 
+static int cs42l42_set_bclk_ratio(struct snd_soc_dai *dai,
+				unsigned int bclk_ratio)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+
+	cs42l42->bclk_ratio = bclk_ratio;
+
+	return 0;
+}
+
 static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_component *component = dai->component;
@@ -1087,6 +1101,7 @@ static const struct snd_soc_dai_ops cs42l42_ops = {
 	.hw_params	= cs42l42_pcm_hw_params,
 	.set_fmt	= cs42l42_set_dai_fmt,
 	.set_sysclk	= cs42l42_set_sysclk,
+	.set_bclk_ratio	= cs42l42_set_bclk_ratio,
 	.mute_stream	= cs42l42_mute_stream,
 };
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index bc51bb09da5c..a72136664112 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -35,6 +35,7 @@ struct  cs42l42_private {
 	int irq;
 	int pll_config;
 	u32 sclk;
+	u32 bclk_ratio;
 	u32 srate;
 	u8 plug_state;
 	u8 hs_type;
-- 
2.33.0

