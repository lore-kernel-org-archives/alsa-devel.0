Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C8DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 15:22:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 643782004;
	Mon, 20 Jun 2022 17:21:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 643782004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655738548;
	bh=ew02CUNSFy2iK+5g5fmmOjcJdupwYmqd2bUH0iUKHK0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IAw1e8ndr+oqPvjhi5wZu5mNp2/j83U8LO+kCIzJVsxWw0cZHwV+E2ukDdWxEzfyS
	 l0wHwQSP1LTeO8n8Ih0UWg199h7GY+dy8hgdeTRSe+j8OmcJYClr3RUnZ9RqcmkKAK
	 bznxnFEhnmpaMFzsva9c824Ajh5vRibqHhk4jNzs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 366DFF8071F;
	Mon, 20 Jun 2022 17:07:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6B63F8052E; Thu, 16 Jun 2022 16:35:33 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B2E7F80310
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2022 16:34:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B2E7F80310
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="i4UojuP3"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G4igBf030693;
 Thu, 16 Jun 2022 09:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=2oOH0ajpjX51SxIUnf5QoeLn4u7Pp4JTnUSfyoYuy5c=;
 b=i4UojuP3+fYWIylNZy5aAraWVB3cBLs21E+SNjyYBFMxDcpGSJPsnZ7DMwWuA6E/zC6P
 vNXWdhFRWZ+EW2DKHAScxNf5h1eM2fupu5OypzIKPNEqNrbrzjDiXvhtAMV7slqQxZtF
 G3Xsymw3uSBrVXVd7cMjUpArEkPK+z1RlViGoV8jkPGKvgoVjsbN6mrCIsRb1ujkDmlM
 l53FV9rFgfktH/+1OBgsnJRzNDiQmNoOt22yqADKYmp1h9oEtGrmWqDmCVdcQkl6bC/K
 iCQoH/2NjieI/OtpdqcnrhSnQwgMYUzsomz3jXBBEU/Hk1eQXXJhSjovQPpNcYD5znCu ew== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gmrf35vuw-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 16 Jun 2022 09:34:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 15:34:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 16 Jun 2022 15:34:33 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E09AF11D4;
 Thu, 16 Jun 2022 14:34:33 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 50/96] ASoC: da*: Remove now redundant non_legacy_dai_naming
 flag
Date: Thu, 16 Jun 2022 15:33:43 +0100
Message-ID: <20220616143429.1324494-51-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220616143429.1324494-1-ckeepax@opensource.cirrus.com>
References: <20220616143429.1324494-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: t-omMM0I0UdP1B9pdRzYB2L5YI1LsVJs
X-Proofpoint-ORIG-GUID: t-omMM0I0UdP1B9pdRzYB2L5YI1LsVJs
X-Proofpoint-Spam-Reason: safe
X-Mailman-Approved-At: Mon, 20 Jun 2022 17:06:45 +0200
Cc: cezary.rojewski@intel.com, heiko@sntech.de,
 kuninori.morimoto.gx@renesas.com, airlied@linux.ie,
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 nicolas.ferre@microchip.com, srinivas.kandagatla@linaro.org,
 peter.ujfalusi@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
 jbrunet@baylibre.com, pierre-louis.bossart@linux.intel.com, krzk@kernel.org,
 linux-rockchip@lists.infradead.org, linux-imx@nxp.com,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-xtensa@linux-xtensa.org, nsaenz@kernel.org, kernel@pengutronix.de,
 mripard@kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-omap@vger.kernel.org, patches@opensource.cirrus.com, lgirdwood@gmail.com,
 vkoul@kernel.org, jarkko.nikula@bitmer.com, daniel@ffwll.ch,
 shawnguo@kernel.org, daniel@zonque.org
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

The ASoC core has now been changed to default to the non-legacy DAI
naming, as such drivers using the new scheme no longer need to specify
the non_legacy_dai_naming flag.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/da7210.c | 1 -
 sound/soc/codecs/da7213.c | 1 -
 sound/soc/codecs/da7218.c | 1 -
 sound/soc/codecs/da7219.c | 1 -
 sound/soc/codecs/da732x.c | 1 -
 sound/soc/codecs/da9055.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 76a21976ccddb..f838466bfebf8 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1173,7 +1173,6 @@ static const struct snd_soc_component_driver soc_component_dev_da7210 = {
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-	.non_legacy_dai_naming	= 1,
 };
 
 #if IS_ENABLED(CONFIG_I2C)
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 2e645dc60eda4..544ccbcfc8844 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1922,7 +1922,6 @@ static const struct snd_soc_component_driver soc_component_dev_da7213 = {
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config da7213_regmap_config = {
diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index a5d7c350a3ded..91372909d184b 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -3040,7 +3040,6 @@ static const struct snd_soc_component_driver soc_component_dev_da7218 = {
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-	.non_legacy_dai_naming	= 1,
 };
 
 
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c18f76f370fc4..50ecf30e6136a 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2647,7 +2647,6 @@ static const struct snd_soc_component_driver soc_component_dev_da7219 = {
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-	.non_legacy_dai_naming	= 1,
 };
 
 
diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 3f1cfee10df3f..2c5b0b74201c7 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1503,7 +1503,6 @@ static const struct snd_soc_component_driver soc_component_dev_da732x = {
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-	.non_legacy_dai_naming	= 1,
 };
 
 static int da732x_i2c_probe(struct i2c_client *i2c)
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 9d8c8adc5d768..28043b4530df8 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1460,7 +1460,6 @@ static const struct snd_soc_component_driver soc_component_dev_da9055 = {
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config da9055_regmap_config = {
-- 
2.30.2

