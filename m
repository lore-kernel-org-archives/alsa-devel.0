Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56B5C001B0
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 10:40:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9E1AA4D;
	Tue,  8 Aug 2023 12:39:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9E1AA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691491224;
	bh=/uDOp8plFCO9bzxvpn7EZ2/6YCbU6FyHDi7vYspaqjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ty2PTw6QUuB2Wnnr2hnoU7ZlYEBO9LhbaSUHAlWLHlEOTxFCtO42GkuPoFMjHNJPP
	 JU0rog1dRkwF6HQSb3zy0j319BnhPWCuR+zDUIywe1lz+B6tH8KX7F6ogGcPxhNZwc
	 JFL8dqncP02mziKgx161r1cEBmA06QhZLXwyDft0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 143B1F80617; Tue,  8 Aug 2023 12:36:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D18FF80551;
	Tue,  8 Aug 2023 12:36:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90A23F8055A; Mon,  7 Aug 2023 11:01:35 +0200 (CEST)
Received: from mblankhorst.nl (lankhorst.se
 [IPv6:2a02:2308:0:7ec:e79c:4e97:b6c4:f0ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 34B30F8053B;
	Mon,  7 Aug 2023 11:01:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34B30F8053B
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
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
	sound-open-firmware@alsa-project.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v3 8/9] ASoC: SOF: Intel: Move binding to display driver
 outside of deferred probe
Date: Mon,  7 Aug 2023 11:00:44 +0200
Message-Id: <20230807090045.198993-9-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mlankhorst@mblankhorst.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: BKKB3RFR7273GZN6FCZDIFYPUQG6RXZ7
X-Message-ID-Hash: BKKB3RFR7273GZN6FCZDIFYPUQG6RXZ7
X-Mailman-Approved-At: Tue, 08 Aug 2023 10:35:41 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BKKB3RFR7273GZN6FCZDIFYPUQG6RXZ7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Now that we can use -EPROBE_DEFER, it's no longer required to spin off
the snd_hdac_i915_init into a workqueue.

Use the -EPROBE_DEFER mechanism instead, which must be returned in the
probe function.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 sound/soc/sof/core.c            | 19 +++++++------------
 sound/soc/sof/intel/hda-codec.c |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 30db685cc5f4..cd4d06d1800b 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -188,13 +188,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	struct snd_sof_pdata *plat_data = sdev->pdata;
 	int ret;
 
-	/* probe the DSP hardware */
-	ret = snd_sof_probe(sdev);
-	if (ret < 0) {
-		dev_err(sdev->dev, "error: failed to probe DSP %d\n", ret);
-		goto probe_err;
-	}
-
 	sof_set_fw_state(sdev, SOF_FW_BOOT_PREPARE);
 
 	/* check machine info */
@@ -325,10 +318,6 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 dbg_err:
 	snd_sof_free_debug(sdev);
 dsp_err:
-	snd_sof_remove(sdev);
-probe_err:
-	sof_ops_free(sdev);
-
 	/* all resources freed, update state to match */
 	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
 	sdev->first_boot = true;
@@ -436,6 +425,12 @@ int snd_sof_device_probe(struct device *dev, struct snd_sof_pdata *plat_data)
 
 	sof_set_fw_state(sdev, SOF_FW_BOOT_NOT_STARTED);
 
+	ret = snd_sof_probe(sdev);
+	if (ret) {
+		dev_err_probe(sdev->dev, ret, "failed to probe DSP\n");
+		return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)) {
 		INIT_WORK(&sdev->probe_work, sof_probe_work);
 		schedule_work(&sdev->probe_work);
@@ -485,9 +480,9 @@ int snd_sof_device_remove(struct device *dev)
 
 		snd_sof_ipc_free(sdev);
 		snd_sof_free_debug(sdev);
-		snd_sof_remove(sdev);
 	}
 
+	snd_sof_remove(sdev);
 	sof_ops_free(sdev);
 
 	/* release firmware */
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index f1fd5b44aaac..344b61576c0e 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -415,7 +415,7 @@ int hda_codec_i915_init(struct snd_sof_dev *sdev)
 		return 0;
 
 	/* i915 exposes a HDA codec for HDMI audio */
-	ret = snd_hdac_i915_init(bus, true);
+	ret = snd_hdac_i915_init(bus, false);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.2

