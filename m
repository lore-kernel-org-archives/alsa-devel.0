Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E487CC47094
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 22:49:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62512610A1
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 22:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62512610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE0A816AE;
	Tue,  8 Jun 2021 00:48:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE0A816AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623106182;
	bh=gzA1AYtukz+7QLurYWx1xomzIlgFa7zOpXUgBNM8KnQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2lOjQCDXYMdy8+p+MtNya7ZghsDAqVH3+eZBK2B8JsO9v22XYh2RweXG7BiQ2kdb
	 0lQthXxJOAqgHpskr+YQfOU72t/EdZ+AFuoL9p71tAIAkxd6slOyOdM7Jr0A46se+4
	 YrnhGTsPWiB3Td3/X4zc2RIah1I7Zc81vRHYNyfs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F3A8F800DF;
	Tue,  8 Jun 2021 00:47:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6C47F8020D; Tue,  8 Jun 2021 00:47:08 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26BCFF8026C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 00:46:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26BCFF8026C
IronPort-SDR: N3ee5ElA5VMSoWrr91PriZzIFfYcM8htIOeEo17H9YfGLww8ZwO+fIIVgCzJvhkYJToFaEcScU
 EzWFEFA6A8qQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185102172"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="185102172"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 15:46:48 -0700
IronPort-SDR: ileYDVbiIjAHMe8XoYuRsi+NuTdUbG+NB2fKq8i3PWuVf1HvK3VbzRYroRWL3Qu9yyyZ8WxtNF
 9nVasFf2+1Mw==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="637437076"
Received: from marocham-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.108.70])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 15:46:47 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/10] ASoC: Intel: sof_sdw: remove hdac-hdmi support
Date: Mon,  7 Jun 2021 17:46:30 -0500
Message-Id: <20210607224638.585486-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607224638.585486-1-pierre-louis.bossart@linux.intel.com>
References: <20210607224638.585486-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Richard Fitzgerald <rf@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Remove support for using hdac_hdmi codec driver. No known products use
this configuration and hdac_hdmi cannot support all the platforms
sof_sdw does.

This change also fixes a bug in Kconfig rules.
SND_SOC_INTEL_SOUNDWIRE_SOF_MACH did not have a select SND_SOC_HDAC_HDMI
and this could cause build failures.

Reported-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c        |  2 --
 sound/soc/intel/boards/sof_sdw_common.h |  1 -
 sound/soc/intel/boards/sof_sdw_hdmi.c   | 37 +------------------------
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 970d7892568a..34f142d7b3f9 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1273,8 +1273,6 @@ static int mc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ctx->common_hdmi_codec_drv = mach->mach_params.common_hdmi_codec_drv;
-
 	/*
 	 * the default amp_num is zero for each codec and
 	 * amp_num will only be increased for active amp
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 37ae3a19fa49..ec5740486b75 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -79,7 +79,6 @@ struct sof_sdw_codec_info {
 
 struct mc_private {
 	struct list_head hdmi_pcm_list;
-	bool common_hdmi_codec_drv;
 	bool idisp_codec;
 	struct snd_soc_jack sdw_headset;
 };
diff --git a/sound/soc/intel/boards/sof_sdw_hdmi.c b/sound/soc/intel/boards/sof_sdw_hdmi.c
index 99b04bb2f3a0..d47d8bf528c1 100644
--- a/sound/soc/intel/boards/sof_sdw_hdmi.c
+++ b/sound/soc/intel/boards/sof_sdw_hdmi.c
@@ -13,11 +13,8 @@
 #include <sound/soc-acpi.h>
 #include <sound/jack.h>
 #include "sof_sdw_common.h"
-#include "../../codecs/hdac_hdmi.h"
 #include "hda_dsp_common.h"
 
-static struct snd_soc_jack hdmi[MAX_HDMI_NUM];
-
 struct hdmi_pcm {
 	struct list_head head;
 	struct snd_soc_dai *codec_dai;
@@ -49,8 +46,6 @@ int sof_sdw_hdmi_card_late_probe(struct snd_soc_card *card)
 	struct mc_private *ctx = snd_soc_card_get_drvdata(card);
 	struct hdmi_pcm *pcm;
 	struct snd_soc_component *component = NULL;
-	int err, i = 0;
-	char jack_name[NAME_SIZE];
 
 	if (!ctx->idisp_codec)
 		return 0;
@@ -62,35 +57,5 @@ int sof_sdw_hdmi_card_late_probe(struct snd_soc_card *card)
 			       head);
 	component = pcm->codec_dai->component;
 
-	if (ctx->common_hdmi_codec_drv)
-		return hda_dsp_hdmi_build_controls(card, component);
-
-	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
-		component = pcm->codec_dai->component;
-		snprintf(jack_name, sizeof(jack_name),
-			 "HDMI/DP, pcm=%d Jack", pcm->device);
-		err = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_AVOUT, &hdmi[i],
-					    NULL, 0);
-
-		if (err)
-			return err;
-
-		err = snd_jack_add_new_kctl(hdmi[i].jack,
-					    jack_name, SND_JACK_AVOUT);
-		if (err)
-			dev_warn(component->dev, "failed creating Jack kctl\n");
-
-		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
-					  &hdmi[i]);
-		if (err < 0)
-			return err;
-
-		i++;
-	}
-
-	if (!component)
-		return -EINVAL;
-
-	return hdac_hdmi_jack_port_init(component, &card->dapm);
+	return hda_dsp_hdmi_build_controls(card, component);
 }
-- 
2.25.1

