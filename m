Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E92C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 19 May 2022 15:58:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B85B917C8;
	Thu, 19 May 2022 17:57:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B85B917C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652975929;
	bh=vqYnD02i9rte39qhDlm7gqSa6ccxOvW21+CaUGEYU1w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mlxNCi5eV3sjVVywfFb6v/DN2Dl3Qbt/sjNyYP2eWI0TXOzkohlmuSXX705lipZ+m
	 YzCOFGvEXA0BlS8BrYp236ZS7JfRp0p27EfHkFzXYCZ+WWXrKGHL1BL7wBKlE0Thfs
	 pjipbbmVJsBcZj4+BtDrvkjxj6r8ppjzlbNBsnEE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7591FF8070B;
	Thu, 19 May 2022 17:44:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D8CFF8063C; Thu, 19 May 2022 17:44:34 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB028F805AB
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2022 17:43:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB028F805AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="WXh+X2sB"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J6k12B002261;
 Thu, 19 May 2022 10:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=TIWyZghTEZ//MO2jvbjUZPrmAJ1ieo/aXBoLcASAC1w=;
 b=WXh+X2sBUTuu1EFWjtVqsdMrMDBdTC0ym9haGIwCO+ZMLVfUx8/SKLsGToIUYs31WTyE
 DOU7DaMZSBWLy5uxyi8D6n5sXfUEwOFor4O6Q71aRqSJkCm8/ug0UOrgsk6LlOnY2eAX
 dahGd5rw7s39Q+k4HiuyUhuFv4znDF2258537Yh87jJafevKisgPqYTMLBx6tF7o95Z1
 JVqe/ENOFIS5ERGxgf5KlqPQoOMo9k9QNUTTDM12CQTGF72WhxtJCBx7myscccLfqIkP
 D90LiewLtzARtk3lRxI0RJS7NrHWhTX5i08HJOVo0VEnkFUlijoXOpoxH6Oohw6pNlsw RA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3g29u37mcf-12
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 19 May 2022 10:43:41 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 16:43:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Thu, 19 May 2022 16:43:21 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7A3D411DA;
 Thu, 19 May 2022 15:43:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 43/56] ASoC: pxa: Rename set_fmt_new back to set_fmt
Date: Thu, 19 May 2022 16:43:05 +0100
Message-ID: <20220519154318.2153729-44-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519154318.2153729-1-ckeepax@opensource.cirrus.com>
References: <20220519154318.2153729-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 36sXbaeY6GpSg0BsX0_utVT-CPuXi-n7
X-Proofpoint-ORIG-GUID: 36sXbaeY6GpSg0BsX0_utVT-CPuXi-n7
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
 sound/soc/pxa/mmp-sspa.c   | 2 +-
 sound/soc/pxa/pxa-ssp.c    | 2 +-
 sound/soc/pxa/pxa2xx-i2s.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index b746e52aaf85f..382e9d8608a3f 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -346,7 +346,7 @@ static const struct snd_soc_dai_ops mmp_sspa_dai_ops = {
 	.hw_params	= mmp_sspa_hw_params,
 	.set_sysclk	= mmp_sspa_set_dai_sysclk,
 	.set_pll	= mmp_sspa_set_dai_pll,
-	.set_fmt_new	= mmp_sspa_set_dai_fmt,
+	.set_fmt	= mmp_sspa_set_dai_fmt,
 };
 
 static struct snd_soc_dai_driver mmp_sspa_dai = {
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 52124be1778eb..0f504a9f4983d 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -824,7 +824,7 @@ static const struct snd_soc_dai_ops pxa_ssp_dai_ops = {
 	.trigger	= pxa_ssp_trigger,
 	.hw_params	= pxa_ssp_hw_params,
 	.set_sysclk	= pxa_ssp_set_dai_sysclk,
-	.set_fmt_new	= pxa_ssp_set_dai_fmt,
+	.set_fmt	= pxa_ssp_set_dai_fmt,
 	.set_tdm_slot	= pxa_ssp_set_dai_tdm_slot,
 	.set_tristate	= pxa_ssp_set_dai_tristate,
 };
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 09a0d033df6a2..7b586b7d46da3 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -335,7 +335,7 @@ static const struct snd_soc_dai_ops pxa_i2s_dai_ops = {
 	.shutdown	= pxa2xx_i2s_shutdown,
 	.trigger	= pxa2xx_i2s_trigger,
 	.hw_params	= pxa2xx_i2s_hw_params,
-	.set_fmt_new	= pxa2xx_i2s_set_dai_fmt,
+	.set_fmt	= pxa2xx_i2s_set_dai_fmt,
 	.set_sysclk	= pxa2xx_i2s_set_dai_sysclk,
 };
 
-- 
2.30.2

