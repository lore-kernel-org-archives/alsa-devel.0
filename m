Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99992C38147
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Jan 2023 16:07:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCE4D78E5;
	Wed, 18 Jan 2023 17:07:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCE4D78E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674058070;
	bh=pWjjyVkaxZc0zmQFgwPXxZUpqGqEGNw9h+2EcR2SeWg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=uW5uMg1WA/9lTcYWwz8MBxq8G8FXyQq3wvV8dmI9tVn3diffPuAsz269Ot5jGZKKX
	 U8SnFYxQBS5Bqq/dOpf5q8cXSGob4wBvO3q1ZlgRW7MhS703/41WuNivWzIBV7EhyB
	 juugfrGMjiUK7x8iZFhyB3nsIdwQQi7dsna1DIZM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E33BF80570;
	Wed, 18 Jan 2023 17:05:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3BFEF8056F; Wed, 18 Jan 2023 17:05:19 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 437CFF8024D
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2023 17:05:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 437CFF8024D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=CfLnuovq
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30IEDgr9022836; Wed, 18 Jan 2023 10:05:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VkEQ/+6tCb28lQhqZZB7/1qdgbcRJIIlgjD9dLONQZg=;
 b=CfLnuovqxnPb5kq1igrKUZGiD5POleBH4VAYwmCW7HQWBFwDwFgWbFP7dykE4IkCaDZF
 +CBEPbLpzCtZwZCDKJLfSByVZSBXk0nZwgugkp1Qy86Ja21Rm+DtsG+7rt0JQA9tKF5v
 lmmx9Bk023eYIZymYn2rTjw648hPCYXzDRo1wdr4Kt85XDaj8io5w2bkMZzHMoyJ7kAh
 JqHUmflnqwTmOTI/h4VcGUH3bslfJv5wAi+cn2ezi0jr+O8Wt4kd2y+Apyf6AYyC8r0b
 sDQ1LeS6sKobQ0n2zDNYPWwQs42XJuH+XZFtrDhUMQFO4Kpr32aOlXJuBiqyT2UhdQe5 cw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n3spx6vk9-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jan 2023 10:05:06 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 18 Jan
 2023 10:04:57 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Wed, 18 Jan 2023 10:04:57 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 934D811CC;
 Wed, 18 Jan 2023 16:04:57 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 5/8] ASoC: cs42l42: Export some functions for Soundwire
Date: Wed, 18 Jan 2023 16:04:49 +0000
Message-ID: <20230118160452.2385494-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: e0TwxmiCoLTa6zUv4AqYAIA2xNmwJPWj
X-Proofpoint-ORIG-GUID: e0TwxmiCoLTa6zUv4AqYAIA2xNmwJPWj
X-Proofpoint-Spam-Reason: safe
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 Stefan Binding <sbinding@opensource.cirrus.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Export functions that will be needed by a Soundwire module.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 14 +++++++++-----
 sound/soc/codecs/cs42l42.h |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index d81c6eb1c1e59..cefefd7061689 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -653,8 +653,8 @@ static const struct cs42l42_pll_params pll_ratio_table[] = {
 	{ 24576000, 1, 0x03, 0x40, 0x000000, 0x03, 0x10, 12288000, 128, 1}
 };
 
-static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk,
-			      unsigned int sample_rate)
+int cs42l42_pll_config(struct snd_soc_component *component, unsigned int clk,
+		       unsigned int sample_rate)
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int i;
@@ -740,8 +740,9 @@ static int cs42l42_pll_config(struct snd_soc_component *component, unsigned int
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_pll_config, SND_SOC_CS42L42_CORE);
 
-static void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate)
+void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate)
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	unsigned int fs;
@@ -773,6 +774,7 @@ static void cs42l42_src_config(struct snd_soc_component *component, unsigned int
 				      CS42L42_CLK_OASRC_SEL_MASK,
 				      fs << CS42L42_CLK_OASRC_SEL_SHIFT);
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_src_config, SND_SOC_CS42L42_CORE);
 
 static int cs42l42_asp_config(struct snd_soc_component *component,
 			      unsigned int sclk, unsigned int sample_rate)
@@ -1013,7 +1015,7 @@ static int cs42l42_set_bclk_ratio(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
@@ -1106,6 +1108,7 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_mute_stream, SND_SOC_CS42L42_CORE);
 
 #define CS42L42_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 			 SNDRV_PCM_FMTBIT_S24_LE |\
@@ -1648,7 +1651,7 @@ static const struct cs42l42_irq_params irq_params_table[] = {
 		CS42L42_TSRS_PLUG_VAL_MASK}
 };
 
-static irqreturn_t cs42l42_irq_thread(int irq, void *data)
+irqreturn_t cs42l42_irq_thread(int irq, void *data)
 {
 	struct cs42l42_private *cs42l42 = (struct cs42l42_private *)data;
 	unsigned int stickies[12];
@@ -1765,6 +1768,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_irq_thread, SND_SOC_CS42L42_CORE);
 
 static void cs42l42_set_interrupt_masks(struct cs42l42_private *cs42l42)
 {
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 17aab06adc8e6..ef8219f489100 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -61,6 +61,11 @@ extern struct snd_soc_dai_driver cs42l42_dai;
 bool cs42l42_readable_register(struct device *dev, unsigned int reg);
 bool cs42l42_volatile_register(struct device *dev, unsigned int reg);
 
+int cs42l42_pll_config(struct snd_soc_component *component,
+		       unsigned int clk, unsigned int sample_rate);
+void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate);
+int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream);
+irqreturn_t cs42l42_irq_thread(int irq, void *data);
 int cs42l42_suspend(struct device *dev);
 int cs42l42_resume(struct device *dev);
 void cs42l42_resume_restore(struct device *dev);
-- 
2.34.1

