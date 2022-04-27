Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427D8C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Apr 2022 15:12:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64C4D1614;
	Wed, 27 Apr 2022 17:11:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64C4D1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651072337;
	bh=WNILvPVHh3K08oLveDYD2KkDKrHGQf084AUIohn3VmI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IEBqdAsjlofxjAaxRLi7J8Qi2A1BARFWb+NG6N6rnoczfvoH3oSlv5neXx/QY5+ep
	 6c0VUmsfg9twSO0WnUsGwXZK/IDfwNwHwAdmsoy1dNbhX9MiBI1YBSH1ajNth9fJlm
	 yGQ4af0hdu/brX1UxdEdCJTO2DbOJQr4t0eNpJ3w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60F08F8057C;
	Wed, 27 Apr 2022 17:08:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 682AFF80557; Wed, 27 Apr 2022 17:07:55 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56F41F80516
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2022 17:07:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56F41F80516
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="HnIRAmBH"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6M8vp014103;
 Wed, 27 Apr 2022 10:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=L+sp1duDGs2feT5hFVgcKLtco7zkrHRPmi250a7EfqE=;
 b=HnIRAmBHDZ/AlJn7IHoezhTxWaUeRdllWgA3yLTc3qs0qYla1nh6RcnsqmoS3ze1DVQf
 9puyxWrwp6R/SsGMD4sK5/KV7ERASCbysS9EmxJ58DgJvhKZyt/SNGZhgeZq04Hek3hH
 9/DghuL64ab5vcEWwtn6kmTfpIiHfPBeCiHL5KSxwyhpie7nTa+CzKcDniGzqdoIicP1
 FCOreJXyoV/XZiBELOUZtmeWbta0vy0gyvVw6BWPnlC2KzIVZ4YeoX/GqJ/MaP7HEixc
 M3znWA4j2oVwyT+bqKmyF1Q4m55H+UiVbnLsGQQf1TmCCy08tXb1p29zxAkL23XjH+Wn og== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xth-9
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 27 Apr 2022 10:07:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via
 Frontend Transport; Wed, 27 Apr 2022 16:07:31 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F3DE3478;
 Wed, 27 Apr 2022 15:07:30 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark
 Brown <broonie@kernel.org>
Subject: [PATCH 20/26] ASoC: cs35l41: Add common cs35l41 enter hibernate
 function
Date: Wed, 27 Apr 2022 16:07:14 +0100
Message-ID: <20220427150720.9194-21-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hBSu2twEVgPIw_hFh-Pn_Iv3czqHmBAX
X-Proofpoint-ORIG-GUID: hBSu2twEVgPIw_hFh-Pn_Iv3czqHmBAX
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Stefan Binding <sbinding@opensource.cirrus.com>
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

From: Stefan Binding <sbinding@opensource.cirrus.com>

Since the CS35L41 HDA driver also support hibernation, it
makes sense to move code from the ASoC driver to enter
hibernation into common code.

Since HDA must support laptops which do not support hibernation
due to lack of external boost GPIO it is necessary to
ensure the function returns an error when an unsupported
boost type is in use.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 include/sound/cs35l41.h        |  2 ++
 sound/soc/codecs/cs35l41-lib.c | 19 +++++++++++++++++++
 sound/soc/codecs/cs35l41.c     | 10 +---------
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 938f5846e4d4..7affe6cfc823 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -886,6 +886,8 @@ void cs35l41_configure_cs_dsp(struct device *dev, struct regmap *reg, struct cs_
 int cs35l41_set_cspl_mbox_cmd(struct device *dev, struct regmap *regmap,
 			      enum cs35l41_cspl_mbox_cmd cmd);
 int cs35l41_write_fs_errata(struct device *dev, struct regmap *regmap);
+int cs35l41_enter_hibernate(struct device *dev, struct regmap *regmap,
+			    enum cs35l41_boost_type b_type);
 int cs35l41_exit_hibernate(struct device *dev, struct regmap *regmap);
 int cs35l41_init_boost(struct device *dev, struct regmap *regmap,
 		       struct cs35l41_hw_cfg *hw_cfg);
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 8a796dbe0718..34899a127d05 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -1320,6 +1320,25 @@ int cs35l41_write_fs_errata(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_GPL(cs35l41_write_fs_errata);
 
+int cs35l41_enter_hibernate(struct device *dev, struct regmap *regmap,
+			    enum cs35l41_boost_type b_type)
+{
+	if (!cs35l41_safe_reset(regmap, b_type)) {
+		dev_dbg(dev, "System does not support Suspend\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "Enter hibernate\n");
+	regmap_write(regmap, CS35L41_WAKESRC_CTL, 0x0088);
+	regmap_write(regmap, CS35L41_WAKESRC_CTL, 0x0188);
+
+	// Don't wait for ACK since bus activity would wake the device
+	regmap_write(regmap, CS35L41_DSP_VIRT1_MBOX_1, CSPL_MBOX_CMD_HIBERNATE);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs35l41_enter_hibernate);
+
 static void cs35l41_wait_for_pwrmgt_sts(struct device *dev, struct regmap *regmap)
 {
 	const int pwrmgt_retries = 10;
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 0400c6e091d5..ca8310a77092 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1333,15 +1333,7 @@ static int __maybe_unused cs35l41_runtime_suspend(struct device *dev)
 	if (!cs35l41->dsp.preloaded || !cs35l41->dsp.cs_dsp.running)
 		return 0;
 
-	dev_dbg(cs35l41->dev, "Enter hibernate\n");
-
-	cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
-	regmap_write(cs35l41->regmap, CS35L41_WAKESRC_CTL, 0x0088);
-	regmap_write(cs35l41->regmap, CS35L41_WAKESRC_CTL, 0x0188);
-
-	// Don't wait for ACK since bus activity would wake the device
-	regmap_write(cs35l41->regmap, CS35L41_DSP_VIRT1_MBOX_1,
-		     CSPL_MBOX_CMD_HIBERNATE);
+	cs35l41_enter_hibernate(dev, cs35l41->regmap, cs35l41->hw_cfg.bst_type);
 
 	regcache_cache_only(cs35l41->regmap, true);
 	regcache_mark_dirty(cs35l41->regmap);
-- 
2.32.0

