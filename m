Return-Path: <SRS0=1P3b=4D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D6C35242
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Feb 2020 01:49:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5582E2073A
	for <alsa-devel@archiver.kernel.org>; Sat, 15 Feb 2020 01:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sSoMlnY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5582E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AE771670;
	Sat, 15 Feb 2020 02:48:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AE771670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581731381;
	bh=YPP4oar2ysUDcutd174TBfz/m0pftRlnymTLIlBD8P4=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sSoMlnY3Ol5Zv1xilmlJPrmMm7j1YJktoQlfYzFh19DyTeo3QPeZw9f4UOV5a030h
	 GSlyHLo0+9IEkWr7tLj9oCJxAPvPv/Mda6RxhaFBRuoKP98ReMwkhg7d7GjO28tyFq
	 jUCGYjuqYu/D6iJzfcc3l36bpI1JEt6P2B2S6icA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB689F8019B;
	Sat, 15 Feb 2020 02:48:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F33A9F80158; Sat, 15 Feb 2020 02:47:57 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A06F8F800F0
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2020 02:47:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A06F8F800F0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 17:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; d="scan'208";a="434975948"
Received: from gosalsar-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.252.136.64])
 by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2020 17:47:50 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 14 Feb 2020 19:47:37 -0600
Message-Id: <20200215014740.27580-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
References: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v3 2/5] soundwire: intel: add prepare support
	in sdw dai driver
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Rander Wang <rander.wang@linux.intel.com>

The existing code does not expose a prepare operation, which is very
much needed to deal with underflow and resume operations.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 78b2ebf0119c..bad7c30f1e01 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -699,6 +699,21 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int intel_prepare(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct sdw_cdns_dma_data *dma;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma) {
+		dev_err(dai->dev, "failed to get dma data in %s",
+			__func__);
+		return -EIO;
+	}
+
+	return sdw_prepare_stream(dma->stream);
+}
+
 static int
 intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
@@ -745,6 +760,7 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.hw_params = intel_hw_params,
+	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
@@ -752,6 +768,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.hw_params = intel_hw_params,
+	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
