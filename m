Return-Path: <SRS0=2FB+=BH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F7AC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:11:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F19A2065C
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K5MZr/pb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bek0hKiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F19A2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93D7716FE;
	Tue, 28 Jul 2020 18:10:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93D7716FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595952691;
	bh=pX5rEIW5v3ocxjJYKZewQw3hZgOP/PbERMQCN1X+avM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K5MZr/pbyOMhemDO9k4ek8VAV3B3JCtHZLo3rFm2tplhp08UZPzeB+ZiGIenGP19u
	 tOclw5dXF1DMnr99IEoqUp626m4Jsamp3CUfYYRMpz+bT8zyZcnE3pEcVuZz/1kjIo
	 NEHi3eUdxhlfdaatqlO2urrf6qnSncMDdTfwEzKg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28A60F80256;
	Tue, 28 Jul 2020 18:08:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54A0FF802D2; Tue, 28 Jul 2020 18:08:57 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62277F8021E
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2020 18:08:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62277F8021E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bek0hKiw"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06SG8i4R002212;
 Tue, 28 Jul 2020 11:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1595952524;
 bh=9tm697YUlZck3EcdIDbHBexEjd7OXPA86pwnJv0PSHI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bek0hKiwPysCGrZNtYs6mOaZUUU+SWdPUoFZgBSsES9IbKoJ0fhey4DoN2qTG5HBK
 suwczytIrg+34TrJdlgd266RBorRlLdapvs21Bqr1ktGsysHJPWvJKcEcFk5RKxYl5
 P6LNKynsDrV7EQcNLGToNu701zxsKQTduwXRl07A=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SG8iW3067723;
 Tue, 28 Jul 2020 11:08:44 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Jul 2020 11:08:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Jul 2020 11:08:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SG8iwO002367;
 Tue, 28 Jul 2020 11:08:44 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH 2/2] ASoC: tlv320adcx140: Add GPO configuration and drive
 output config
Date: Tue, 28 Jul 2020 11:08:33 -0500
Message-ID: <20200728160833.24130-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728160833.24130-1-dmurphy@ti.com>
References: <20200728160833.24130-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Dan Murphy <dmurphy@ti.com>
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

Add General Purpose Output (GPO) configuration and driver output
configuration.  The GPOs can be configured as a GPO, IRQ, SDOUT or a
PDMCLK output.  In addition the output drive can be configured with
various configurations.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 50 +++++++++++++++++++++++++++++++-
 sound/soc/codecs/tlv320adcx140.h | 14 ++++++---
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index d900af967f8c..d554f091734c 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -37,6 +37,13 @@ struct adcx140_priv {
 	unsigned int slot_width;
 };
 
+static const char * const gpo_config_names[] = {
+	"ti,gpo-config-1",
+	"ti,gpo-config-2",
+	"ti,gpo-config-3",
+	"ti,gpo-config-4",
+};
+
 static const struct reg_default adcx140_reg_defaults[] = {
 	{ ADCX140_PAGE_SELECT, 0x00 },
 	{ ADCX140_SW_RESET, 0x00 },
@@ -60,10 +67,10 @@ static const struct reg_default adcx140_reg_defaults[] = {
 	{ ADCX140_PDMCLK_CFG, 0x40 },
 	{ ADCX140_PDM_CFG, 0x00 },
 	{ ADCX140_GPIO_CFG0, 0x22 },
+	{ ADCX140_GPO_CFG0, 0x00 },
 	{ ADCX140_GPO_CFG1, 0x00 },
 	{ ADCX140_GPO_CFG2, 0x00 },
 	{ ADCX140_GPO_CFG3, 0x00 },
-	{ ADCX140_GPO_CFG4, 0x00 },
 	{ ADCX140_GPO_VAL, 0x00 },
 	{ ADCX140_GPIO_MON, 0x00 },
 	{ ADCX140_GPI_CFG0, 0x00 },
@@ -756,6 +763,43 @@ static const struct snd_soc_dai_ops adcx140_dai_ops = {
 	.set_tdm_slot	= adcx140_set_dai_tdm_slot,
 };
 
+static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
+{
+	u32 gpo_outputs[ADCX140_NUM_GPOS];
+	u32 gpo_output_val = 0;
+	int ret;
+	int i;
+
+	for (i = 0; i < ADCX140_NUM_GPOS; i++) {
+		ret = device_property_read_u32_array(adcx140->dev,
+						     gpo_config_names[i],
+						     gpo_outputs,
+						     ADCX140_NUM_GPO_CFGS);
+		if (ret)
+			continue;
+
+		if (gpo_outputs[0] > ADCX140_GPO_CFG_MAX) {
+			dev_err(adcx140->dev, "GPO%d config out of range\n", i + 1);
+			return -EINVAL;
+		}
+
+		if (gpo_outputs[1] > ADCX140_GPO_DRV_MAX) {
+			dev_err(adcx140->dev, "GPO%d drive out of range\n", i + 1);
+			return -EINVAL;
+		}
+
+		gpo_output_val = gpo_outputs[0] << ADCX140_GPO_SHIFT |
+				 gpo_outputs[1];
+		ret = regmap_write(adcx140->regmap, ADCX140_GPO_CFG1 + i,
+				   gpo_output_val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+
+}
+
 static int adcx140_codec_probe(struct snd_soc_component *component)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
@@ -837,6 +881,10 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	ret = adcx140_configure_gpo(adcx140);
+	if (ret)
+		goto out;
+
 	ret = adcx140_reset(adcx140);
 	if (ret)
 		goto out;
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 39206bf1af12..a8da4a72cd7a 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -36,10 +36,10 @@
 #define ADCX140_PDMCLK_CFG	0x1f
 #define ADCX140_PDM_CFG		0x20
 #define ADCX140_GPIO_CFG0	0x21
-#define ADCX140_GPO_CFG1	0x22
-#define ADCX140_GPO_CFG2	0x23
-#define ADCX140_GPO_CFG3	0x24
-#define ADCX140_GPO_CFG4	0x25
+#define ADCX140_GPO_CFG0	0x22
+#define ADCX140_GPO_CFG1	0x23
+#define ADCX140_GPO_CFG2	0x24
+#define ADCX140_GPO_CFG3	0x25
 #define ADCX140_GPO_VAL		0x29
 #define ADCX140_GPIO_MON	0x2a
 #define ADCX140_GPI_CFG0	0x2b
@@ -139,4 +139,10 @@
 #define ADCX140_GPI3_INDEX		2
 #define ADCX140_GPI4_INDEX		3
 
+#define ADCX140_NUM_GPOS		4
+#define ADCX140_NUM_GPO_CFGS		2
+#define ADCX140_GPO_SHIFT		4
+#define ADCX140_GPO_CFG_MAX		4
+#define ADCX140_GPO_DRV_MAX		5
+
 #endif /* _TLV320ADCX140_ */
-- 
2.28.0

