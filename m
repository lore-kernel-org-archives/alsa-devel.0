Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCB7C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 08:13:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6933A22447
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C3J88OfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6933A22447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 909491770;
	Tue, 17 Nov 2020 09:12:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 909491770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605600816;
	bh=xwOzgDW2GNUf3oC4oIia44eh26JeE08ggxMkjqxXjQo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C3J88OfYJUpGLBtKli26hWiJhfQKtS7JYDzvLY3QvnygIncvpt1BMOTpwAi6VtkzD
	 dzONrGwS0eqIu4WdAHGKjWQtNSmqutctwrHD01zAb35TrR65fDPVgOhx+chJsmWDgz
	 SjGTvC+99S5bkn755t508oknQ2lRBMITIGdfUzs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79D74F804D2;
	Tue, 17 Nov 2020 09:11:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE42BF804CC; Tue, 17 Nov 2020 09:11:13 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24839F804CC
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 09:11:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24839F804CC
IronPort-SDR: MXZRYgbGcBg5+2zaeV4quQS6OkdDr1BrSetY6wezf8fEOYesHZeMOG4Q2tQ/ycUW6vJ33t5jaK
 djLsftb5eyDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="158656689"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; d="scan'208";a="158656689"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 00:11:01 -0800
IronPort-SDR: qsx53L8OO218AJlAuDhPHg1i87YKncRHpO5FZkojMZcjUl/M7zreby6occAR535B7B0RrdBWzL
 IEP/0kQ71qCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; d="scan'208";a="358799252"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2020 00:10:58 -0800
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 3/4] ASoC: dmaengine_pcm: expose functions to header file
 for custom functions
Date: Tue, 17 Nov 2020 16:03:50 +0800
Message-Id: <20201117080354.4309-6-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117080354.4309-1-michael.wei.hong.sit@intel.com>
References: <20201117080354.4309-1-michael.wei.hong.sit@intel.com>
Cc: cezary.rojewski@intel.com, lars@metafoo.de, andriy.shevchenko@intel.com,
 tiwai@suse.com, jee.heng.sia@intel.com, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
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

Moving some functions to the header file to be used by custom prepare and
submit function.

In the Intel KeemBay solution, there is a DMA limitation which requires
a custom prepare and submit function to modify the number of blocks per
linked link.

This patch exposes some of the functions used in the pcm_dmaengine.c to
be used by the custom function.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/dmaengine_pcm.h | 15 +++++++++++++++
 sound/core/pcm_dmaengine.c    | 16 ++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 9fae56d39ae2..d45652a27f73 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -174,8 +174,23 @@ struct dmaengine_pcm {
 	unsigned int flags;
 };
 
+struct dmaengine_pcm_runtime_data {
+	struct dma_chan *dma_chan;
+	dma_cookie_t cookie;
+
+	unsigned int pos;
+};
+
+static inline struct dmaengine_pcm_runtime_data *substream_to_prtd(
+	const struct snd_pcm_substream *substream)
+{
+	return substream->runtime->private_data;
+}
+
 static inline struct dmaengine_pcm *soc_component_to_pcm(struct snd_soc_component *p)
 {
 	return container_of(p, struct dmaengine_pcm, component);
 }
+
+void dmaengine_pcm_dma_complete(void *arg);
 #endif
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index cbd1429de509..0f99c63964ec 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -19,19 +19,6 @@
 
 #include <sound/dmaengine_pcm.h>
 
-struct dmaengine_pcm_runtime_data {
-	struct dma_chan *dma_chan;
-	dma_cookie_t cookie;
-
-	unsigned int pos;
-};
-
-static inline struct dmaengine_pcm_runtime_data *substream_to_prtd(
-	const struct snd_pcm_substream *substream)
-{
-	return substream->runtime->private_data;
-}
-
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
@@ -128,7 +115,7 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
 
-static void dmaengine_pcm_dma_complete(void *arg)
+void dmaengine_pcm_dma_complete(void *arg)
 {
 	struct snd_pcm_substream *substream = arg;
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
@@ -139,6 +126,7 @@ static void dmaengine_pcm_dma_complete(void *arg)
 
 	snd_pcm_period_elapsed(substream);
 }
+EXPORT_SYMBOL_GPL(dmaengine_pcm_dma_complete);
 
 static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 {
-- 
2.17.1

