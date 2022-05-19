Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C3CC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 19 May 2022 15:55:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DCEC16FD;
	Thu, 19 May 2022 17:54:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DCEC16FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652975712;
	bh=53smalEnmfrhzNb/ZPQWANWNkkhK4oV/1zCHbCdGm/4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AAelY3dOdXVe49LkToINpsVx9XSwC5rHxWPRS5R53DjeeuKNEHz7dDiYaYBuHvByj
	 1t1IekSur6+6ArOgr7vLSH2VKJ3dvP0nkYuLQNwXrelRpeep78PIuU5pUtMuorOvuw
	 vJIO//YngwtJdwmOozbmyG2RErTm2MskHF5A6zm8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CE4EF8063D;
	Thu, 19 May 2022 17:44:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79F00F80607; Thu, 19 May 2022 17:44:17 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DDE7F80559
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2022 17:43:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DDE7F80559
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="cyJuIevZ"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J66mWB012194;
 Thu, 19 May 2022 10:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=EnjkLm/Bn2VaDl7QgUDory6TrhO4/WqhOMeFwNAeCO4=;
 b=cyJuIevZ/xe38Y0/J6Dwp1pQuTiwyudCM5dRbE4OUe9/8AizKFZVJdW11BshkUnwRyCq
 cRveNlhoi+Q/0rqjTZfCmyQ3y4fD7/sVTQ3iYVb+rpnbnRv1CBiB6eZakcEKkr95QkeD
 UUzNYraJIq+2Iv2DEthG6Y+ec6Ezq1j3aPicaH1BFKb6C1/jJk2RtRgZypHNkH1lnyUs
 QeRvIe/bezI35ybAwNvoCJsj0zJOyXdx3Uk4Nwmyc7SoQC4PRunzXKGkUTv7yGscZ217
 +9spamDAwsIGeoBGTRrjH2qiW2/a2JaUIEt6fp3mo/kQfJ8wWhJCwGQqM7bH0hpYe3X2 PA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3g28upf5dn-14
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 19 May 2022 10:43:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 16:43:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Thu, 19 May 2022 16:43:21 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A043411DB;
 Thu, 19 May 2022 15:43:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 46/56] ASoC: samsung: Rename set_fmt_new back to set_fmt
Date: Thu, 19 May 2022 16:43:08 +0100
Message-ID: <20220519154318.2153729-47-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519154318.2153729-1-ckeepax@opensource.cirrus.com>
References: <20220519154318.2153729-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5YiEn5E8rqseqepgXRm0tkSg5eIuX_4g
X-Proofpoint-ORIG-GUID: 5YiEn5E8rqseqepgXRm0tkSg5eIuX_4g
X-Proofpoint-Spam-Reason: safe
Cc: cezary.rojewski@intel.com, heiko@sntech.de,
 kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
 nicolas.ferre@microchip.com, srinivas.kandagatla@linaro.org,
 peter.ujfalusi@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
 jbrunet@baylibre.com, pierre-louis.bossart@linux.intel.com, krzk@kernel.org,
 linux-rockchip@lists.infradead.org, linux-imx@nxp.com,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-xtensa@linux-xtensa.org, nsaenz@kernel.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
 patches@opensource.cirrus.com, lgirdwood@gmail.com, daniel@zonque.org,
 kernel@pengutronix.de, shawnguo@kernel.org, jarkko.nikula@bitmer.com
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

Now the core has been migrated across to the new direct clock
specification we can move the drivers back to the normal set_fmt
callback.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/samsung/i2s.c         | 2 +-
 sound/soc/samsung/pcm.c         | 2 +-
 sound/soc/samsung/s3c-i2s-v2.c  | 2 +-
 sound/soc/samsung/s3c24xx-i2s.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 9ed275ebd744e..fdd9561c6a9f3 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1107,7 +1107,7 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 static const struct snd_soc_dai_ops samsung_i2s_dai_ops = {
 	.trigger = i2s_trigger,
 	.hw_params = i2s_hw_params,
-	.set_fmt_new = i2s_set_fmt,
+	.set_fmt = i2s_set_fmt,
 	.set_clkdiv = i2s_set_clkdiv,
 	.set_sysclk = i2s_set_sysclk,
 	.startup = i2s_startup,
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 818172d8832d2..c2eb3534bfccb 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -437,7 +437,7 @@ static const struct snd_soc_dai_ops s3c_pcm_dai_ops = {
 	.set_clkdiv	= s3c_pcm_set_clkdiv,
 	.trigger	= s3c_pcm_trigger,
 	.hw_params	= s3c_pcm_hw_params,
-	.set_fmt_new	= s3c_pcm_set_fmt,
+	.set_fmt	= s3c_pcm_set_fmt,
 };
 
 static int s3c_pcm_dai_probe(struct snd_soc_dai *dai)
diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 9c8a0697849d7..1bec72246ed0c 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -666,7 +666,7 @@ int s3c_i2sv2_register_component(struct device *dev, int id,
 	ops->trigger = s3c2412_i2s_trigger;
 	if (!ops->hw_params)
 		ops->hw_params = s3c_i2sv2_hw_params;
-	ops->set_fmt_new = s3c2412_i2s_set_fmt;
+	ops->set_fmt = s3c2412_i2s_set_fmt;
 	ops->set_clkdiv = s3c2412_i2s_set_clkdiv;
 	ops->set_sysclk = s3c_i2sv2_set_sysclk;
 
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 6226b3b585e54..4082ad7cbcc11 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -394,7 +394,7 @@ static int s3c24xx_i2s_resume(struct snd_soc_component *component)
 static const struct snd_soc_dai_ops s3c24xx_i2s_dai_ops = {
 	.trigger	= s3c24xx_i2s_trigger,
 	.hw_params	= s3c24xx_i2s_hw_params,
-	.set_fmt_new	= s3c24xx_i2s_set_fmt,
+	.set_fmt	= s3c24xx_i2s_set_fmt,
 	.set_clkdiv	= s3c24xx_i2s_set_clkdiv,
 	.set_sysclk	= s3c24xx_i2s_set_sysclk,
 };
-- 
2.30.2

