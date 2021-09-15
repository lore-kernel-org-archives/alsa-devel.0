Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161FEC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 07:20:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AF461164
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 07:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69AF461164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEA29182D;
	Wed, 15 Sep 2021 09:19:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEA29182D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631690403;
	bh=D56ACFGPJ3NodzVzKjVigmv5e8psK3YqoQcq20XDZOE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cMR5u44FxSD+K3ouW9TUpF+JEBt1Z6LXHvaURhP6+OhGU+lLkfWWScRn4jZaDUPq2
	 R/DnLiV2C/2MGj4t3oS/z1g2BVo80vKm7jUTSfcFuwb3/IMn+NzrBE8fQ12evX8DAI
	 WAXCYfwMisKPaRBPwpj2/wg4ESEIlNLuX7Djh/u8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BA7FF804E2;
	Wed, 15 Sep 2021 09:18:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 049B4F804E3; Wed, 15 Sep 2021 09:18:26 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D3C1F80132
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 09:18:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D3C1F80132
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="285934974"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; d="scan'208";a="285934974"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 00:18:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; d="scan'208";a="544656295"
Received: from msavu-mobl1.ti.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.216.36])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 00:18:13 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 3/3] ASoC: SOF: Intel: hda: Relocate inline definitions from
 hda.h to hda.c for sdw
Date: Wed, 15 Sep 2021 10:18:05 +0300
Message-Id: <20210915071805.5704-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915071805.5704-1-peter.ujfalusi@linux.intel.com>
References: <20210915071805.5704-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

Move the only locally needed inline functions to hda.c when
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE is not enabled to make the header file
less cluttered with information no needed to be there.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 33 ++++++++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda.h | 30 ------------------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index f60e2c57d3d0..c11e4c14d875 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -294,7 +294,38 @@ void hda_sdw_process_wakeen(struct snd_sof_dev *sdev)
 	sdw_intel_process_wakeen_event(hdev->sdw);
 }
 
-#endif
+#else /* IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE) */
+static inline int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline int hda_sdw_probe(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
+{
+	return false;
+}
+
+static inline irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
+{
+	return IRQ_HANDLED;
+}
+
+static inline bool hda_sdw_check_wakeen_irq(struct snd_sof_dev *sdev)
+{
+	return false;
+}
+
+#endif /* IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE) */
 
 /*
  * Debug
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 4a2d1376c717..087fa06d5210 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -684,45 +684,15 @@ bool hda_common_check_sdw_irq(struct snd_sof_dev *sdev);
 
 #else
 
-static inline int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
-{
-	return 0;
-}
-
-static inline int hda_sdw_probe(struct snd_sof_dev *sdev)
-{
-	return 0;
-}
-
 static inline int hda_sdw_startup(struct snd_sof_dev *sdev)
 {
 	return 0;
 }
 
-static inline int hda_sdw_exit(struct snd_sof_dev *sdev)
-{
-	return 0;
-}
-
 static inline void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
 {
 }
 
-static inline bool hda_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
-{
-	return false;
-}
-
-static inline irqreturn_t hda_dsp_sdw_thread(int irq, void *context)
-{
-	return IRQ_HANDLED;
-}
-
-static inline bool hda_sdw_check_wakeen_irq(struct snd_sof_dev *sdev)
-{
-	return false;
-}
-
 static inline void hda_sdw_process_wakeen(struct snd_sof_dev *sdev)
 {
 }
-- 
2.33.0

