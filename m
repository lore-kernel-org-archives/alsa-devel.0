Return-Path: <SRS0=II5U=3J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA5C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:02:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE0B2073D
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jp96qey0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE0B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33820166D;
	Mon, 20 Jan 2020 17:01:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33820166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579536142;
	bh=BV6039R9TfrbNALQOajqzxzfejsJLvWb93qffKG5VV8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jp96qey0my0kLL/j1ghRNbueZmsdPCnlHEYgUfz/0i5wGAumrrM+cd4RTT/eT3yZ3
	 Omz0oPY8Z2wUYxsoK45PMcxDIFei1GsxkhzCwHtr4Lj6zpzB7/7iMRwdPpqaRfwm3m
	 7u3FZ50a2fVGU30i89xteok3+bfK4SW2Y0Of/dk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B357AF800C6;
	Mon, 20 Jan 2020 17:01:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98749F8022D; Mon, 20 Jan 2020 17:01:29 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFD57F8012F
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2020 17:01:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFD57F8012F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jan 2020 08:01:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; d="scan'208";a="258751436"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2020 08:01:22 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Date: Mon, 20 Jan 2020 18:01:15 +0200
Message-Id: <20200120160117.29130-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120160117.29130-1-kai.vehmanen@linux.intel.com>
References: <20200120160117.29130-1-kai.vehmanen@linux.intel.com>
Cc: tiwai@suse.de, cujomalainey@chromium.org, kai.vehmanen@linux.intel.com
Subject: [alsa-devel] [PATCH v2 1/3] ASoC: SOF: Intel: refactor i915_get/put
	functions
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The current interface to control i915 display power is misleading.
The hda_codec_i915_get() and hda_codec_i915_put() names suggest
a refcounting based interface. This is confusing as no refcounting
is done and the underlying HDAC library interface does not support
refcounts eithers.

Clarify the code by replacing the functions with a single
hda_codec_i915_display_power() that is aligned with
snd_hdac_display_power().

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-codec.c | 21 ++++++---------------
 sound/soc/sof/intel/hda.c       |  2 +-
 sound/soc/sof/intel/hda.h       |  7 +++----
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 78dfd5f5c034..9106ab8dac6f 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -170,23 +170,14 @@ EXPORT_SYMBOL_NS(hda_codec_probe_bus, SND_SOC_SOF_HDA_AUDIO_CODEC);
 #if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI) || \
 	IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)
 
-void hda_codec_i915_get(struct snd_sof_dev *sdev)
+void hda_codec_i915_display_power(struct snd_sof_dev *sdev, bool enable)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
 
-	dev_dbg(bus->dev, "Turning i915 HDAC power on\n");
-	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
+	dev_dbg(bus->dev, "Turning i915 HDAC power %d\n", enable);
+	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, enable);
 }
-EXPORT_SYMBOL_NS(hda_codec_i915_get, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
-
-void hda_codec_i915_put(struct snd_sof_dev *sdev)
-{
-	struct hdac_bus *bus = sof_to_bus(sdev);
-
-	dev_dbg(bus->dev, "Turning i915 HDAC power off\n");
-	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
-}
-EXPORT_SYMBOL_NS(hda_codec_i915_put, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
+EXPORT_SYMBOL_NS(hda_codec_i915_display_power, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 
 int hda_codec_i915_init(struct snd_sof_dev *sdev)
 {
@@ -198,7 +189,7 @@ int hda_codec_i915_init(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	hda_codec_i915_get(sdev);
+	hda_codec_i915_display_power(sdev, true);
 
 	return 0;
 }
@@ -209,7 +200,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 	struct hdac_bus *bus = sof_to_bus(sdev);
 	int ret;
 
-	hda_codec_i915_put(sdev);
+	hda_codec_i915_display_power(sdev, false);
 
 	ret = snd_hdac_i915_exit(bus);
 
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index d08462f481de..54a7ba881150 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -380,7 +380,7 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	/* create codec instances */
 	hda_codec_probe_bus(sdev, hda_codec_use_common_hdmi);
 
-	hda_codec_i915_put(sdev);
+	hda_codec_i915_display_power(sdev, false);
 
 	/*
 	 * we are done probing so decrement link counts
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index a4d030bfeee1..6191d9192fae 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -586,15 +586,14 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev);
 	(IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI) || \
 	 IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
 
-void hda_codec_i915_get(struct snd_sof_dev *sdev);
-void hda_codec_i915_put(struct snd_sof_dev *sdev);
+void hda_codec_i915_display_power(struct snd_sof_dev *sdev, bool enable);
 int hda_codec_i915_init(struct snd_sof_dev *sdev);
 int hda_codec_i915_exit(struct snd_sof_dev *sdev);
 
 #else
 
-static inline void hda_codec_i915_get(struct snd_sof_dev *sdev)  { }
-static inline void hda_codec_i915_put(struct snd_sof_dev *sdev)  { }
+static inline void hda_codec_i915_display_power(struct snd_sof_dev *sdev,
+						bool enable) { }
 static inline int hda_codec_i915_init(struct snd_sof_dev *sdev) { return 0; }
 static inline int hda_codec_i915_exit(struct snd_sof_dev *sdev) { return 0; }
 
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
