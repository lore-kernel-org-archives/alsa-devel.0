Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80BDC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:53:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE3B20899
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DrcrHXls";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pZff7Yfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE3B20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC6DC18A0;
	Wed, 24 Jun 2020 19:52:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC6DC18A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593021195;
	bh=GMtzhwxtIbEgZYlujaTvY9tiStQHS7FrVdgB+4OPXec=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DrcrHXlslC3Uk6VLKNFXSFrYQdPqerGVdyl2aUjiqj6vJKtRk5+i4bU+KLnfVZhw+
	 4BahI6IcfkuPkhc9g7G+4BqcLsLWDmFZFrTQ8R8rD2eP93tih2JDKdpqOImJxdWulK
	 WmdMetOGIXmtbaPBWhhOmP40d6uN6rZOqyHJvJdo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25576F802E1;
	Wed, 24 Jun 2020 19:50:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1BCFF802E7; Wed, 24 Jun 2020 19:50:14 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79579F802E0
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 19:50:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79579F802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pZff7Yfm"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHo6D3029498;
 Wed, 24 Jun 2020 12:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1593021006;
 bh=M1MPBLSDMN936E020JiJBRBjKYmEXCOU5/4sosJb4SA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pZff7YfmW5idGnjmzn03bLGpLVISV35yDJhQlL0pmpCptF/UMM1G0gtkHJGb0nVFe
 QHnPism+n+RSAjYOMQcpkAf8WcihC72ISl9H9fSWLUaAp11+/VKVLXgKEwLGj09pKV
 sgnMZg0HIkHTwbCjySg55Kr1eaPrJRwKdDEneT4s=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OHo6Pr071498
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jun 2020 12:50:06 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:50:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:50:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHo5QI120458;
 Wed, 24 Jun 2020 12:50:05 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH v6 6/7] ASoC: tas2562: Add voltage sense slot configuration
Date: Wed, 24 Jun 2020 12:49:31 -0500
Message-ID: <20200624174932.9604-7-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624174932.9604-1-dmurphy@ti.com>
References: <20200624174932.9604-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robh@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Dan Murphy <dmurphy@ti.com>, devicetree@vger.kernel.org
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

Add Vsense slot configuration based on the device tree.  Adding this
property enables the slot programming to be moved to the tdm_set_slot
callback.  This in affect sets the slots for the Isense and Vsense and
enabling this these modes are now based on whether these features were
powered on or not.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 65 ++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 2f1d4b697f01..b0b7cef79433 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -224,12 +224,26 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG5,
+					    TAS2562_TDM_CFG5_VSNS_SLOT_MASK,
+					    tas2562->v_sense_slot);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG6,
+					    TAS2562_TDM_CFG6_ISNS_SLOT_MASK,
+					    tas2562->i_sense_slot);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
 static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
 {
 	int ret;
+	int val;
+	int sense_en;
 
 	switch (bitwidth) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -237,21 +251,18 @@ static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
 					      TAS2562_TDM_CFG2,
 					      TAS2562_TDM_CFG2_RXWLEN_MASK,
 					      TAS2562_TDM_CFG2_RXWLEN_16B);
-		tas2562->v_sense_slot = tas2562->i_sense_slot + 2;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		snd_soc_component_update_bits(tas2562->component,
 					      TAS2562_TDM_CFG2,
 					      TAS2562_TDM_CFG2_RXWLEN_MASK,
 					      TAS2562_TDM_CFG2_RXWLEN_24B);
-		tas2562->v_sense_slot = tas2562->i_sense_slot + 4;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		snd_soc_component_update_bits(tas2562->component,
 					      TAS2562_TDM_CFG2,
 					      TAS2562_TDM_CFG2_RXWLEN_MASK,
 					      TAS2562_TDM_CFG2_RXWLEN_32B);
-		tas2562->v_sense_slot = tas2562->i_sense_slot + 4;
 		break;
 
 	default:
@@ -259,17 +270,27 @@ static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
 		return -EINVAL;
 	}
 
-	ret = snd_soc_component_update_bits(tas2562->component,
-		TAS2562_TDM_CFG5,
-		TAS2562_TDM_CFG5_VSNS_EN | TAS2562_TDM_CFG5_VSNS_SLOT_MASK,
-		TAS2562_TDM_CFG5_VSNS_EN | tas2562->v_sense_slot);
+	val = snd_soc_component_read(tas2562->component, TAS2562_PWR_CTRL);
+	if (val < 0)
+		return val;
+
+	if (val & (1 << TAS2562_VSENSE_POWER_EN))
+		sense_en = 0;
+	else
+		sense_en = TAS2562_TDM_CFG5_VSNS_EN;
+
+	ret = snd_soc_component_update_bits(tas2562->component, TAS2562_TDM_CFG5,
+		TAS2562_TDM_CFG5_VSNS_EN, sense_en);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_component_update_bits(tas2562->component,
-		TAS2562_TDM_CFG6,
-		TAS2562_TDM_CFG6_ISNS_EN | TAS2562_TDM_CFG6_ISNS_SLOT_MASK,
-		TAS2562_TDM_CFG6_ISNS_EN | tas2562->i_sense_slot);
+	if (val & (1 << TAS2562_ISENSE_POWER_EN))
+		sense_en = 0;
+	else
+		sense_en = TAS2562_TDM_CFG6_ISNS_EN;
+
+	ret = snd_soc_component_update_bits(tas2562->component, TAS2562_TDM_CFG6,
+		TAS2562_TDM_CFG6_ISNS_EN, sense_en);
 	if (ret < 0)
 		return ret;
 
@@ -645,9 +666,25 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 
 	ret = fwnode_property_read_u32(dev->fwnode, "ti,imon-slot-no",
 			&tas2562->i_sense_slot);
-	if (ret)
-		dev_err(dev, "Looking up %s property failed %d\n",
-			"ti,imon-slot-no", ret);
+	if (ret) {
+		dev_err(dev, "Property %s is missing setting default slot\n",
+			"ti,imon-slot-no");
+		tas2562->i_sense_slot = 0;
+	}
+
+
+	ret = fwnode_property_read_u32(dev->fwnode, "ti,vmon-slot-no",
+			&tas2562->v_sense_slot);
+	if (ret) {
+		dev_info(dev, "Property %s is missing setting default slot\n",
+			"ti,vmon-slot-no");
+		tas2562->v_sense_slot = 2;
+	}
+
+	if (tas2562->v_sense_slot < tas2562->i_sense_slot) {
+		dev_err(dev, "Vsense slot must be greater than Isense slot\n");
+		return -EINVAL;
+	}
 
 	return ret;
 }
-- 
2.26.2

