Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15755C83F10
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Aug 2023 08:25:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F86A84B;
	Thu, 31 Aug 2023 10:24:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F86A84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693470305;
	bh=Lz7qVQMSKZdt0Xdj59WpeGTKAYXMD3kvDzbvxN2Z/qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Zg6BL0FfTEq7pm9MnLs4e5mvAFApjiOCxBaBLBtjJP9bi6jU5hSzBhVJ8ax8hgwFk
	 dm1dzqWn8lFQE+7SbJZlTrdAU6v1pYmlHRB5M+9Erpifuie27rymng0TvM0VPCFsk8
	 LRzBRyYwa5tPAXvD2yA6qEQhzrJi57kVk4J9rRj4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0CC25F8032D; Thu, 31 Aug 2023 10:24:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 46897F80094;
	Thu, 31 Aug 2023 10:24:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2F67F80158; Wed, 30 Aug 2023 17:37:04 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se
 [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D9239F80074;
	Wed, 30 Aug 2023 17:37:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9239F80074
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: [PATCH v4 01/11] ASoC: SOF: core: add 'no_wq' probe and remove
 callbacks
Date: Wed, 30 Aug 2023 17:36:42 +0200
Message-Id: <20230830153652.217855-2-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
References: <20230830153652.217855-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mlankhorst@mblankhorst.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 7QLWNKFRDEVBG5URJDQUBYG7RCQI2NS4
X-Message-ID-Hash: 7QLWNKFRDEVBG5URJDQUBYG7RCQI2NS4
X-Mailman-Approved-At: Thu, 31 Aug 2023 08:22:31 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7QLWNKFRDEVBG5URJDQUBYG7RCQI2NS4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing DSP probe may be handled in a workqueue to allow for
extra time, typically for the i915 request_module and HDAudio codec
handling.

With the upcoming changes for i915/Xe driver relying on the
-EPROBE_DEFER mechanism, we need to have a first pass of the probe
which cannot be pushed to a workqueue. Introduce 2 new optional
callbacks.

Note that instead of probe_no_wq/probe we could have use a more
self-explanatory naming such as probe/probe_wq_allowed, but that would
have been a very intrusive change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 sound/soc/sof/core.c     | 11 +++++++++--
 sound/soc/sof/ops.h      | 16 ++++++++++++++++
 sound/soc/sof/sof-priv.h |  2 ++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 30db685cc5f4b..54c384a5d6140 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -327,8 +327,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 dsp_err:
 	snd_sof_remove(sdev);
 probe_err:
-	sof_ops_free(sdev);
-
 	/* all resources freed, update state to match */
 	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
 	sdev->first_boot = true;
@@ -436,6 +434,14 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
 
 	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
 
+	/*
+	 * first pass of probe which isn't allowed to run in a work-queue,
+	 * typically to rely on -EPROBE_DEFER dependencies
+	 */
+	ret = snd_sof_probe_no_wq(sdev);
+	if (ret < 0)
+		return ret;
+
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)) {
 		INIT_WORK(&sdev->probe_work, sof_probe_work);
 		schedule_work(&sdev->probe_work);
@@ -487,6 +493,7 @@ int snd_sof_device_remove(struct device *dev)
 		snd_sof_free_debug(sdev);
 		snd_sof_remove(sdev);
 	}
+	snd_sof_remove_no_wq(sdev);
 
 	sof_ops_free(sdev);
 
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 9ab7b9be765bc..2a03b152e9313 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -38,6 +38,14 @@ static inline void sof_ops_free(struct snd_sof_dev *sdev)
 /* Mandatory operations are verified during probing */
 
 /* init */
+static inline int snd_sof_probe_no_wq(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->probe_no_wq)
+		return sof_ops(sdev)->probe_no_wq(sdev);
+
+	return 0;
+}
+
 static inline int snd_sof_probe(struct snd_sof_dev *sdev)
 {
 	return sof_ops(sdev)->probe(sdev);
@@ -51,6 +59,14 @@ static inline int snd_sof_remove(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+static inline int snd_sof_remove_no_wq(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->remove_no_wq)
+		return sof_ops(sdev)->remove_no_wq(sdev);
+
+	return 0;
+}
+
 static inline int snd_sof_shutdown(struct snd_sof_dev *sdev)
 {
 	if (sof_ops(sdev)->shutdown)
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index d4f6702e93dcb..addaef282ee92 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -165,6 +165,8 @@ struct sof_firmware {
 struct snd_sof_dsp_ops {
 
 	/* probe/remove/shutdown */
+	int (*probe_no_wq)(struct snd_sof_dev *sof_dev); /* optional */
+	int (*remove_no_wq)(struct snd_sof_dev *sof_dev); /* optional */
 	int (*probe)(struct snd_sof_dev *sof_dev); /* mandatory */
 	int (*remove)(struct snd_sof_dev *sof_dev); /* optional */
 	int (*shutdown)(struct snd_sof_dev *sof_dev); /* optional */
-- 
2.39.2

