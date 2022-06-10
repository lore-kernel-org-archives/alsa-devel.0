Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A8BC43334
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 02:37:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFD6021D5;
	Fri, 10 Jun 2022 04:37:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFD6021D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654828672;
	bh=uprg4ZL4jSezrQW9p9662ttg9PS3pP4zuCPQgHXP8oA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tY+lCVfhIahsx2rdKqw17L95dIKdOgSqrbEn+Rk2jbRgMOM6E0n+bl+sQgp/Huos0
	 xBR50rZTzVwrnY4mUgYPDU72WbzFR11n93/zXzlsxCL/pLWX5xnPHy0YfVFB3MrfoE
	 GKPLB5fgQ334CMhy35gTP6mEjjMlatzVGMuKoSsA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02D18F8052E;
	Fri, 10 Jun 2022 04:36:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4872CF8052F; Fri, 10 Jun 2022 04:36:15 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CC93F804CF
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 04:36:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CC93F804CF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="bltS1gaM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654828569; x=1686364569;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=uprg4ZL4jSezrQW9p9662ttg9PS3pP4zuCPQgHXP8oA=;
 b=bltS1gaMUr80qc2HrnUDaWodkAcq1sboI8fEJF51ONs5O/G0rbOMx3QO
 x57cjc5NGpUxlMNHvJBR21QAdlH9kXaBlP2/K/xQpV5/+r+Ra3gZCmXt3
 CCrcaP8TH/8NB5hC/7hBqXOyoeoeeKaItm6D3979Qm+w+HwE5Wi2nqH6w
 l3Hh6OtEPvAnlgCeR36MyENassmSbYJnU6W6ydS/lY1E8e1Ejyf4DDapR
 urRpL4NmwEUxiALu++BTIYo/2wb9tNNvGHeT8YNeFJC8wew6I2tT4JsMD
 Fpoeu/6bVJsFIj5Tihat2djdHUgA50ViXk/0uE/AHeYmE0MijSF9QhKrQ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266258667"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="266258667"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 19:35:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="637874970"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 19:35:51 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 2/2] soundwire: Intel: add trigger callback
Date: Fri, 10 Jun 2022 10:35:37 +0800
Message-Id: <20220610023537.27223-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com,
 bard.liao@intel.com
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

When a pipeline is split into FE and BE parts, the BE pipeline may need to
be triggered separately in the BE trigger op. So add the trigger callback
in the link_res ops that will be invoked during BE DAI trigger.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/intel.c           | 8 ++++++++
 include/linux/soundwire/sdw_intel.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 808e2f320052..3f3c2c99cb8e 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1004,9 +1004,17 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_cdns_dma_data *dma;
 	int ret = 0;
 
+	/* The .trigger callback is used to send required IPC to audio
+	 * firmware. The .free_stream callback will still be called
+	 * by intel_free_stream() in the TRIGGER_SUSPEND case.
+	 */
+	if (res->ops && res->ops->trigger)
+		res->ops->trigger(dai, cmd, substream->stream);
+
 	dma = snd_soc_dai_get_dma_data(dai, substream);
 	if (!dma) {
 		dev_err(dai->dev, "failed to get dma data in %s\n",
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 67e0d3e750b5..f638707fd712 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -119,6 +119,7 @@ struct sdw_intel_ops {
 			     struct sdw_intel_stream_params_data *params_data);
 	int (*free_stream)(struct device *dev,
 			   struct sdw_intel_stream_free_data *free_data);
+	int (*trigger)(struct snd_soc_dai *dai, int cmd, int stream);
 };
 
 /**
-- 
2.17.1

