Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9192EC48BE0
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 20:57:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DC3613D8
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 20:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DC3613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DF8417C9;
	Thu, 10 Jun 2021 22:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DF8417C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623358636;
	bh=RFiaPg2Jkn54kCfz1PAi9QoxJXgKKNrtPH5Pj3t29ps=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LeY2DQfq7i/rFx9qQ2mKQHQymJKGv9c0gzsJ9/mUTcaZEmYzYkNkBHw+enMh/waKy
	 2P8GLNhKDDK8GixAlPUU3e0TpcW5NZFPw9MqDzZoxMDappW+OzxAI+TBAJdm5Zypyr
	 9j0FPp4+JTr69vILn0yjmifnnF2wYozlQq1Ghhnc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EE18F804E1;
	Thu, 10 Jun 2021 22:54:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06648F804CB; Thu, 10 Jun 2021 22:54:11 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0E8DF804C2
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 22:54:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0E8DF804C2
IronPort-SDR: cKswenGYdKa2aUS+cnWN4Mg8qwKGGonIEeFDssK0oTfvxqmrZNUWMj725QOchJIhkx23aypSeY
 BIZ1xPjj1AKg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="226812425"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; d="scan'208";a="226812425"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 13:53:54 -0700
IronPort-SDR: p2IIfkmCbBXQWZ1yUbeB49ZUtASAVDtO8MkjUNE8ZugPHiWzANnoET9rhyDK5ckxOxkesZFvhF
 r6vZNb8UKEbQ==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; d="scan'208";a="620183646"
Received: from umedepal-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.170.65])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 13:53:53 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 7/8] ASOC: SOF: pcm: add .ack callback support
Date: Thu, 10 Jun 2021 15:53:25 -0500
Message-Id: <20210610205326.1176400-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
References: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add the indirections required at the core level for platform-specific
operations on ack.

Note that on errors in the .ack the ALSA core will restore the
previous appl_ptr.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.h      | 10 ++++++++++
 sound/soc/sof/pcm.c      |  9 +++++++++
 sound/soc/sof/sof-priv.h |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 4a5d6e497f05..fc9142fe3421 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -428,6 +428,16 @@ snd_sof_pcm_platform_pointer(struct snd_sof_dev *sdev,
 	return 0;
 }
 
+/* pcm ack */
+static inline int snd_sof_pcm_platform_ack(struct snd_sof_dev *sdev,
+					   struct snd_pcm_substream *substream)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->pcm_ack)
+		return sof_ops(sdev)->pcm_ack(sdev, substream);
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_PROBES)
 static inline int
 snd_sof_probe_compr_assign(struct snd_sof_dev *sdev,
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index bab837ed8c7f..8c47687d0d3a 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -817,6 +817,14 @@ static void sof_pcm_remove(struct snd_soc_component *component)
 	snd_soc_tplg_component_remove(component);
 }
 
+static int sof_pcm_ack(struct snd_soc_component *component,
+		       struct snd_pcm_substream *substream)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+
+	return snd_sof_pcm_platform_ack(sdev, substream);
+}
+
 void snd_sof_new_platform_drv(struct snd_sof_dev *sdev)
 {
 	struct snd_soc_component_driver *pd = &sdev->plat_drv;
@@ -835,6 +843,7 @@ void snd_sof_new_platform_drv(struct snd_sof_dev *sdev)
 	pd->hw_free = sof_pcm_hw_free;
 	pd->trigger = sof_pcm_trigger;
 	pd->pointer = sof_pcm_pointer;
+	pd->ack = sof_pcm_ack;
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_COMPRESS)
 	pd->compress_ops = &sof_compressed_ops;
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index fd8423172d8f..8640ffed6cb5 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -178,6 +178,9 @@ struct snd_sof_dsp_ops {
 	snd_pcm_uframes_t (*pcm_pointer)(struct snd_sof_dev *sdev,
 					 struct snd_pcm_substream *substream); /* optional */
 
+	/* pcm ack */
+	int (*pcm_ack)(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream); /* optional */
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_PROBES)
 	/* Except for probe_pointer, all probe ops are mandatory */
 	int (*probe_assign)(struct snd_sof_dev *sdev,
-- 
2.25.1

