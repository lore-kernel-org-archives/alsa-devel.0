Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07486C5DF63
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:24:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D87F2067B
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I8zPU0sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D87F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC4F21666;
	Wed,  6 Nov 2019 20:23:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC4F21666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573068252;
	bh=pioqzvnm/FkMepRGzR0NWrOUb5Doecch1BZTFAjKQIY=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I8zPU0spPw9VgXpy5/s6VUNtIjnxMECO1lystB18ah3wZqCV0n6rlgaJOyYbojWNN
	 DrdVFjVgCYGEFsjzr9XZ74wSx5NXWnuRD9BirN6zK3Z0J5gp1hy05gG6ih4CzkfvnZ
	 B9SU/PYmuAyA4XiB3c9v/ZZ2ZHwGRr/JH0Int3U4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29048F8072A;
	Wed,  6 Nov 2019 20:14:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCF9DF806E9; Wed,  6 Nov 2019 20:14:27 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85140F80679
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 20:14:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85140F80679
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 11:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; d="scan'208";a="402465857"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
 by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2019 11:14:22 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 13:13:57 -0600
Message-Id: <20191106191358.5712-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
References: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 13/14] soundwire: intel: free all resources
	on hw_free()
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

Make sure all calls to the SoundWire stream API are done and involve
callback

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 40 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index af24fa048add..cad1c0b64ee3 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -548,6 +548,25 @@ static int intel_params_stream(struct sdw_intel *sdw,
 	return -EIO;
 }
 
+static int intel_free_stream(struct sdw_intel *sdw,
+			     struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai,
+			     int link_id)
+{
+	struct sdw_intel_link_res *res = sdw->link_res;
+	struct sdw_intel_stream_free_data free_data;
+
+	free_data.substream = substream;
+	free_data.dai = dai;
+	free_data.link_id = link_id;
+
+	if (res->ops && res->ops->free_stream && res->dev)
+		return res->ops->free_stream(res->dev,
+					     &free_data);
+
+	return 0;
+}
+
 /*
  * bank switch routines
  */
@@ -816,6 +835,7 @@ static int
 intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dma_data *dma;
 	int ret;
 
@@ -823,12 +843,28 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	if (!dma)
 		return -EIO;
 
+	ret = sdw_deprepare_stream(dma->stream);
+	if (ret) {
+		dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
+		return ret;
+	}
+
 	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
 			dma->stream->name, ret);
+		return ret;
+	}
 
-	return ret;
+	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
+	if (ret < 0) {
+		dev_err(dai->dev, "intel_free_stream: failed %d", ret);
+		return ret;
+	}
+
+	sdw_release_stream(dma->stream);
+
+	return 0;
 }
 
 static void intel_shutdown(struct snd_pcm_substream *substream,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
