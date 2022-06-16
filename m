Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A035C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 15:15:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75B1F1F14;
	Mon, 20 Jun 2022 17:14:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75B1F1F14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655738099;
	bh=sTm+m26qEakrHzeP5dm9xP4QOW7cfnJegHfs1n0/Ad8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bS0JsedgeQyzUmBQCni3UFTZ8XY97Qu/SOM7IgOe/8OaTm5cYbKZE+XNMGzmocbYX
	 IOLDGuloHhZEHBI+1w0PMQFqIwI0bj7gCcYY+GirA0l7t2XO2CRRCuym876uXUO4aX
	 4lWqKqj53iFa+9T7Pmba1761vZLB0rYjN/K+iF3s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F41ABF805F0;
	Mon, 20 Jun 2022 17:07:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77B39F805B6; Thu, 16 Jun 2022 16:35:05 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95CCCF8012A
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2022 16:34:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95CCCF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="RgyF5h2e"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G4igBY030693;
 Thu, 16 Jun 2022 09:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=TTe/CecmY+9QKzBX8S0Rj3j8y6EEdzCLr8WaNNo1SnQ=;
 b=RgyF5h2eFRZM42X6fMFvAyttKXtjJb2H9ozhzIiNhDCo8DL0sAiwzqsnlR6A1eYKNpuI
 scG8wQEXMJP4wQXbSbIT3EAa7aZQy7Rg/tuLSlYfesHHYHrbsoW3qBUXgKO1NeGCSt0g
 CR/NMZDKe4CwFofW2LNr0ztPHKBLSZRQCgkyZPU2OQX2L3mWqO79335pt52ToPbQ/Uih
 bym7mx7iZGog/gV9g5kdXOKJ9cLmBERAB0yTfcPa62oalaoNdPzfdwdtmpZvnouKhSHA
 PUfjnc4MVzIkfFkgf3E+XwDnmdHLjhVpXkA1bEi2qdfda08uGp85bgWSmoI+jhTLL3R1 8w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gmrf35vuw-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 16 Jun 2022 09:34:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 15:34:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 16 Jun 2022 15:34:31 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9035511D4;
 Thu, 16 Jun 2022 14:34:31 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 21/96] ASoC: xtensa: Migrate to new style legacy DAI naming
 flag
Date: Thu, 16 Jun 2022 15:33:14 +0100
Message-ID: <20220616143429.1324494-22-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220616143429.1324494-1-ckeepax@opensource.cirrus.com>
References: <20220616143429.1324494-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pxgrj3G-D6ROuv0MQ5qqWso92JtM0v-m
X-Proofpoint-ORIG-GUID: pxgrj3G-D6ROuv0MQ5qqWso92JtM0v-m
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

Change the legacy DAI naming flag from opting in to the new scheme
(non_legacy_dai_naming), to opting out of it (legacy_dai_naming).
This driver appears to be on the CPU side of the DAI link and
currently uses the legacy naming, so add the new flag.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/xtensa/xtfpga-i2s.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 8bd1215460327..a8f156540b500 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -475,13 +475,14 @@ static int xtfpga_pcm_new(struct snd_soc_component *component,
 }
 
 static const struct snd_soc_component_driver xtfpga_i2s_component = {
-	.name		= DRV_NAME,
-	.open		= xtfpga_pcm_open,
-	.close		= xtfpga_pcm_close,
-	.hw_params	= xtfpga_pcm_hw_params,
-	.trigger	= xtfpga_pcm_trigger,
-	.pointer	= xtfpga_pcm_pointer,
-	.pcm_construct	= xtfpga_pcm_new,
+	.name			= DRV_NAME,
+	.open			= xtfpga_pcm_open,
+	.close			= xtfpga_pcm_close,
+	.hw_params		= xtfpga_pcm_hw_params,
+	.trigger		= xtfpga_pcm_trigger,
+	.pointer		= xtfpga_pcm_pointer,
+	.pcm_construct		= xtfpga_pcm_new,
+	.legacy_dai_naming	= 1,
 };
 
 static const struct snd_soc_dai_ops xtfpga_i2s_dai_ops = {
-- 
2.30.2

