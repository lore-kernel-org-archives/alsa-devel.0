Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D58C4742C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 06:24:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35E0222B9
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 06:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vAfWXCHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35E0222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C05717B4;
	Mon, 16 Nov 2020 07:23:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C05717B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605507882;
	bh=xwOzgDW2GNUf3oC4oIia44eh26JeE08ggxMkjqxXjQo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vAfWXCHiT0RqbDj9v7r0q3ZINnugPZssgnrRmPmTxoL8fXK/5QaUATlBiGxu77ANb
	 xm3+rj39Ki2gTsZ056KalBCsfeodSBPBW5OMo410jsRpry0NjOXJ+dhKAjD+obOyxC
	 OkcRU1nHUpAqa3KlmHwGuPLLgL1AXg2lWYaHeH4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96BA5F804C1;
	Mon, 16 Nov 2020 07:22:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26EC7F804BD; Mon, 16 Nov 2020 07:22:21 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41B4CF8010A
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 07:22:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41B4CF8010A
IronPort-SDR: AMBLVvCcNi1PqLS88NTobEsvHaBxgstp5svcyAL3JvmComIXtTEg68UwcqoZCA6Rr5uA66yaOI
 oLs0HGwPKa4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158482335"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; d="scan'208";a="158482335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2020 22:22:10 -0800
IronPort-SDR: ZGKAufCm9xWz4GXtsw4hGCl/sNxIGWdiXXfbMCTLUq/Sx7a4wCEo2sEoWkQzu0XgFKtG3eRtSo
 EJ5Aw0A/2zjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; d="scan'208";a="362020332"
Received: from mike-ilbpg1.png.intel.com ([10.88.227.76])
 by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2020 22:22:07 -0800
From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ASoC: dmaengine_pcm: expose functions to header file for
 custom functions
Date: Mon, 16 Nov 2020 14:14:51 +0800
Message-Id: <20201116061452.32347-5-michael.wei.hong.sit@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116061452.32347-1-michael.wei.hong.sit@intel.com>
References: <20201116061452.32347-1-michael.wei.hong.sit@intel.com>
Cc: cezary.rojewski@intel.com, vinod.koul@linux.intel.com,
 andriy.shevchenko@intel.com, tiwai@suse.com, jee.heng.sia@intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org, lars@metafoo.de
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

