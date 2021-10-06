Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1122BC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:10:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8315761100
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 11:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8315761100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27D011688;
	Wed,  6 Oct 2021 13:09:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27D011688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633518646;
	bh=CXnFeXCCTTe/vji+Q6ks/9bvtdJKN85oUOkCTMYEZ18=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qH6MXVJeiGKw2YRvtObUIMpNJ4dAj5+4rWo5gXahFY55JFXH1jjkTvmb7GXfLXdIT
	 j98KCdluBqLLXa4psTZlguMX3ku2Sx9qLuZ/2C1HQcvDZromVfgVBkdYBQ/WXmkhWe
	 B8Sezr4EPt8968zfoy9uVRH8Dqg9+dD2K/AtJd/E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FABEF80525;
	Wed,  6 Oct 2021 13:07:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA287F80526; Wed,  6 Oct 2021 13:07:17 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2D9EF80516
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 13:07:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2D9EF80516
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="223366464"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="223366464"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:07:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; d="scan'208";a="439081122"
Received: from byurovit-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.39.239])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 04:07:05 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 11/19] ASoC: SOF: debug: Print out the fw_state along with the
 DSP dump
Date: Wed,  6 Oct 2021 14:06:37 +0300
Message-Id: <20211006110645.26679-12-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
References: <20211006110645.26679-1-peter.ujfalusi@linux.intel.com>
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

The fw state can be an important information along with the DSP dump.
Print it out before the dump.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/debug.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index bcd381f495c0..dc1df5fb7b4c 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -822,6 +822,32 @@ void snd_sof_free_debug(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_GPL(snd_sof_free_debug);
 
+static const struct soc_fw_state_info {
+	enum snd_sof_fw_state state;
+	const char *name;
+} fw_state_dbg[] = {
+	{SOF_FW_BOOT_NOT_STARTED, "SOF_FW_BOOT_NOT_STARTED"},
+	{SOF_FW_BOOT_PREPARE, "SOF_FW_BOOT_PREPARE"},
+	{SOF_FW_BOOT_IN_PROGRESS, "SOF_FW_BOOT_IN_PROGRESS"},
+	{SOF_FW_BOOT_FAILED, "SOF_FW_BOOT_FAILED"},
+	{SOF_FW_BOOT_READY_FAILED, "SOF_FW_BOOT_READY_FAILED"},
+	{SOF_FW_BOOT_COMPLETE, "SOF_FW_BOOT_COMPLETE"},
+};
+
+static void snd_sof_dbg_print_fw_state(struct snd_sof_dev *sdev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fw_state_dbg); i++) {
+		if (sdev->fw_state == fw_state_dbg[i].state) {
+			dev_err(sdev->dev, "fw_state: %s (%d)\n", fw_state_dbg[i].name, i);
+			return;
+		}
+	}
+
+	dev_err(sdev->dev, "fw_state: UNKNOWN (%d)\n", sdev->fw_state);
+}
+
 void snd_sof_dsp_dbg_dump(struct snd_sof_dev *sdev, u32 flags)
 {
 	bool print_all = !!(sof_core_debug & SOF_DBG_PRINT_ALL_DUMPS);
@@ -831,6 +857,7 @@ void snd_sof_dsp_dbg_dump(struct snd_sof_dev *sdev, u32 flags)
 
 	if (sof_ops(sdev)->dbg_dump && !sdev->dbg_dump_printed) {
 		dev_err(sdev->dev, "------------[ DSP dump start ]------------\n");
+		snd_sof_dbg_print_fw_state(sdev);
 		sof_ops(sdev)->dbg_dump(sdev, flags);
 		dev_err(sdev->dev, "------------[ DSP dump end ]------------\n");
 		if (!print_all)
-- 
2.33.0

