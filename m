Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B9C1975A
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:53:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CE12071B
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pv5+yRuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CE12071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 012D8176E;
	Thu, 12 Mar 2020 20:53:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 012D8176E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584042833;
	bh=35p5YyXxfbhMIF5WWXKeHFeXpG5Vg3hUQPFzAwCbxLA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pv5+yRuG/bBznpF+8cyrkgKgb/j/v/jKfCjF2UVNDKtcagSYorE4SRo+smd0uIN9P
	 1oSVSDlOrfnzDVl9urT9Pyml+aijGj1vZJnmB/5/miZx6+GAz/VZkFFue4qGy1eV/9
	 hXKW3HUYoAO0d303Rm3GEw0Lfq1/WrPQpu6C0jxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4140EF802A7;
	Thu, 12 Mar 2020 20:49:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99A64F802A0; Thu, 12 Mar 2020 20:49:50 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19CF8F80246
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 20:49:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19CF8F80246
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 12:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="416058388"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com)
 ([10.251.241.169])
 by orsmga005.jf.intel.com with ESMTP; 12 Mar 2020 12:49:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 05/10] ASoC: codecs: hdac_hdmi: (cosmetic) remove redundant
 variable initialisations
Date: Thu, 12 Mar 2020 14:48:54 -0500
Message-Id: <20200312194859.4051-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194859.4051-1-pierre-louis.bossart@linux.intel.com>
References: <20200312194859.4051-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 broonie@kernel.org,
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Remove several redundant variable initialisations.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e6558475e006..fba9b749839d 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1998,11 +1998,11 @@ static struct hdac_hdmi_drv_data intel_drv_data  = {
 
 static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 {
-	struct hdac_hdmi_priv *hdmi_priv = NULL;
+	struct hdac_hdmi_priv *hdmi_priv;
 	struct snd_soc_dai_driver *hdmi_dais = NULL;
-	struct hdac_ext_link *hlink = NULL;
+	struct hdac_ext_link *hlink;
 	int num_dais = 0;
-	int ret = 0;
+	int ret;
 	struct hdac_driver *hdrv = drv_to_hdac_driver(hdev->dev.driver);
 	const struct hda_device_id *hdac_id = hdac_get_device_id(hdev, hdrv);
 
-- 
2.20.1

