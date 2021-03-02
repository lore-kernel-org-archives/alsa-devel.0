Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3434BC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 17:09:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2D864EF4
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 17:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2D864EF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FA95182F;
	Tue,  2 Mar 2021 18:08:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FA95182F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614704970;
	bh=wyYBYMUbFk0TK76re8pJ1xjbtqbRGaC9R5U95UpJclo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eCIMeaWTS1+ilnOLtAjokzRECLFPkbPCZsumjxjapnomJ+T9hgKQWR8DwtycxhyTQ
	 xH3ThqkpdqlM3Znb90s7X7k4KARvJCEdbFWO3+SX/Fgowtb12q53YhnrHy590Azj5A
	 cXbPHg9Se3PIh/BLe/bg1yapGgg3qDPJPcZHcVXw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9B55F80423;
	Tue,  2 Mar 2021 18:05:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B43BF804AA; Tue,  2 Mar 2021 18:05:22 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BABC5F802E2
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 18:05:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BABC5F802E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="TLk4pG2U"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 122H1q3J022910; Tue, 2 Mar 2021 11:05:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=tWyZeZVeGuVvYoyoVDyHojNWQ6q8/ZKGC/Al5hpTjZo=;
 b=TLk4pG2UfHXx3xnjnhMrf37kDBXXlEX1vPPAmzXk6NiQ77LhR3BrdmMIbGqFlaissrGP
 GKM6GyIwTw7nJbt5X4yVcYY7b1XTltvcWbRsLoUqbcLJoR9Bwm7pvjNGtksUk4IfX/bM
 TsPSBevR4Ynk6xHoKF48JuXsXiQkVU6KrcGkmX9DuMr15wDoFhkHJ+ULlotjNi8skrsL
 Sd/5FjNTZClZK3EdrEuDRNOdrsaZqpCXiEf1eW/Y6YAFTp7iTQDcLLiS07LgzemKlGtL
 b+CDbccOsQ/Sja69dVxpa6LxtInMx61r4/Vm7R5a1zVoz7APVN5VJtmV8+Li7+kLdIjF ew== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6usg7-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 02 Mar 2021 11:05:03 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 17:05:01 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 17:05:01 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6923811D0;
 Tue,  2 Mar 2021 17:05:01 +0000 (UTC)
From: Lucas Tanure <tanureal@opensource.cirrus.com>
To: James Schulman <james.schulman@cirrus.com>, David Rhodes
 <david.rhodes@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>
Subject: [PATCH 09/15] ASoC: cs42l42: Add Capture Support
Date: Tue, 2 Mar 2021 17:04:48 +0000
Message-ID: <20210302170454.39679-10-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020131
Cc: patches@opensource.cirrus.com,
 Richard Fitzgerald <rf@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 Lucas Tanure <tanureal@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

Add support for capture path on headseat pins

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 39 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l42.h | 12 ++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 6022b6f9c6d27..9a7217cf59f36 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -471,6 +471,18 @@ static const struct snd_soc_dapm_widget cs42l42_dapm_widgets[] = {
 
 	/* Playback Requirements */
 	SND_SOC_DAPM_SUPPLY("ASP DAI0", CS42L42_PWR_CTL1, CS42L42_ASP_DAI_PDN_SHIFT, 1, NULL, 0),
+
+	/* Capture Path */
+	SND_SOC_DAPM_INPUT("HS"),
+	SND_SOC_DAPM_ADC("ADC", NULL, CS42L42_PWR_CTL1, CS42L42_ADC_PDN_SHIFT, 1),
+	SND_SOC_DAPM_AIF_OUT("SDOUT1", NULL, 0, CS42L42_ASP_TX_CH_EN, CS42L42_ASP_TX0_CH1_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("SDOUT2", NULL, 1, CS42L42_ASP_TX_CH_EN, CS42L42_ASP_TX0_CH2_SHIFT, 0),
+
+	/* Capture Requirements */
+	SND_SOC_DAPM_SUPPLY("ASP DAO0", CS42L42_PWR_CTL1, CS42L42_ASP_DAO_PDN_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ASP TX EN", CS42L42_ASP_TX_SZ_EN, CS42L42_ASP_TX_EN_SHIFT, 0, NULL, 0),
+
+	/* Playback/Capture Requirements */
 	SND_SOC_DAPM_SUPPLY("SCLK", CS42L42_ASP_CLK_CFG, CS42L42_ASP_SCLK_EN_SHIFT, 0, NULL, 0),
 };
 
@@ -488,6 +500,21 @@ static const struct snd_soc_dapm_route cs42l42_audio_map[] = {
 	{"SDIN2", NULL, "ASP DAI0"},
 	{"SDIN1", NULL, "SCLK"},
 	{"SDIN2", NULL, "SCLK"},
+
+	/* Capture Path */
+	{"ADC", NULL, "HS"},
+	{ "SDOUT1", NULL, "ADC" },
+	{ "SDOUT2", NULL, "ADC" },
+	{ "Capture", NULL, "SDOUT1" },
+	{ "Capture", NULL, "SDOUT2" },
+
+	/* Capture Requirements */
+	{ "SDOUT1", NULL, "ASP DAO0" },
+	{ "SDOUT2", NULL, "ASP DAO0" },
+	{ "SDOUT1", NULL, "SCLK" },
+	{ "SDOUT2", NULL, "SCLK" },
+	{ "SDOUT1", NULL, "ASP TX EN" },
+	{ "SDOUT2", NULL, "ASP TX EN" },
 };
 
 static int cs42l42_component_probe(struct snd_soc_component *component)
@@ -747,12 +774,24 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+	unsigned int channels = params_channels(params);
 	unsigned int width = (params_width(params) / 8) - 1;
 	unsigned int val = 0;
 
 	cs42l42->srate = params_rate(params);
 
 	switch(substream->stream) {
+	case SNDRV_PCM_STREAM_CAPTURE:
+		if (channels == 2) {
+			val |= CS42L42_ASP_TX_CH2_AP_MASK;
+			val |= width << CS42L42_ASP_TX_CH2_RES_SHIFT;
+		}
+		val |= width << CS42L42_ASP_TX_CH1_RES_SHIFT;
+
+		snd_soc_component_update_bits(component, CS42L42_ASP_TX_CH_AP_RES,
+				CS42L42_ASP_TX_CH1_AP_MASK | CS42L42_ASP_TX_CH2_AP_MASK |
+				CS42L42_ASP_TX_CH2_RES_MASK | CS42L42_ASP_TX_CH1_RES_MASK, val);
+		break;
 	case SNDRV_PCM_STREAM_PLAYBACK:
 		val |= width << CS42L42_ASP_RX_CH_RES_SHIFT;
 		/* channel 1 on low LRCLK */
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 3dcbfebc53b0f..c373259ed46f7 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -683,8 +683,20 @@
 
 /* Page 0x29 Serial Port TX Registers */
 #define CS42L42_ASP_TX_SZ_EN		(CS42L42_PAGE_29 + 0x01)
+#define CS42L42_ASP_TX_EN_SHIFT		0
 #define CS42L42_ASP_TX_CH_EN		(CS42L42_PAGE_29 + 0x02)
+#define CS42L42_ASP_TX0_CH2_SHIFT	1
+#define CS42L42_ASP_TX0_CH1_SHIFT	0
+
 #define CS42L42_ASP_TX_CH_AP_RES	(CS42L42_PAGE_29 + 0x03)
+#define CS42L42_ASP_TX_CH1_AP_SHIFT	7
+#define CS42L42_ASP_TX_CH1_AP_MASK	(1 << CS42L42_ASP_TX_CH1_AP_SHIFT)
+#define CS42L42_ASP_TX_CH2_AP_SHIFT	6
+#define CS42L42_ASP_TX_CH2_AP_MASK	(1 << CS42L42_ASP_TX_CH2_AP_SHIFT)
+#define CS42L42_ASP_TX_CH2_RES_SHIFT	2
+#define CS42L42_ASP_TX_CH2_RES_MASK	(3 << CS42L42_ASP_TX_CH2_RES_SHIFT)
+#define CS42L42_ASP_TX_CH1_RES_SHIFT	0
+#define CS42L42_ASP_TX_CH1_RES_MASK	(3 << CS42L42_ASP_TX_CH1_RES_SHIFT)
 #define CS42L42_ASP_TX_CH1_BIT_MSB	(CS42L42_PAGE_29 + 0x04)
 #define CS42L42_ASP_TX_CH1_BIT_LSB	(CS42L42_PAGE_29 + 0x05)
 #define CS42L42_ASP_TX_HIZ_DLY_CFG	(CS42L42_PAGE_29 + 0x06)
-- 
2.30.1

