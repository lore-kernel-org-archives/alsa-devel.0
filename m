Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3CFC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:43:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE80821527
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GR6dkMIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE80821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85CBE1615;
	Wed, 17 Jun 2020 18:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85CBE1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592412180;
	bh=p1m0RvXMUt54jnJJYOnr4cGGsLs9AXynW+HMECtdHZs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GR6dkMIRPyXtjcIiQObFN5/CZ/kmEjehMsaT7B9LvqCLcB/jO3lbEdTc5y2WHBsa4
	 k9Hd/ywMHWYAH/JMB5Ccgyo4i2zyBiyGhoHw3glpFFLJwgp462DQyzAKwwtMXSVY2R
	 /gtqOUoFK4Y3Zu+k31Tp7JEhmZKKdVvopqRFkfj8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2656DF80162;
	Wed, 17 Jun 2020 18:42:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8AA68F80171; Wed, 17 Jun 2020 18:42:08 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A24FF80116
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 18:42:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A24FF80116
IronPort-SDR: o4g0wgLxsj5plM+JOgSBZOVYvc3D1mL4PeRmEBMmBnj4d9LKY+FbO3eRqA+p6LR9I1qTV+fUis
 oqUkExbJ/AGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 09:42:02 -0700
IronPort-SDR: RYdysJBWCBlUu249VHcc2HqtcoC1Xs6QRdFmyvEHBNJ7f43ufWOjqnKlTCh49uRHmnUu/bGEk8
 QhMYxuYslqzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; d="scan'208";a="261775607"
Received: from zdsmith-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.128])
 by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2020 09:41:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: hdac_hda: fix memleak with regmap not freed on remove
Date: Wed, 17 Jun 2020 11:41:44 -0500
Message-Id: <20200617164144.17859-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

kmemleak throws error reports on module load/unload tests, add
snd_hdac_regmap_exit() in .remove().

While we are at it, also fix the error handling flow in .probe() to
use snd_hdac_regmap_exit() if needed.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index de003acb1951..473efe9ef998 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -441,13 +441,13 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	ret = snd_hda_codec_set_name(hcodec, hcodec->preset->name);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "name failed %s\n", hcodec->preset->name);
-		goto error;
+		goto error_pm;
 	}
 
 	ret = snd_hdac_regmap_init(&hcodec->core);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "regmap init failed\n");
-		goto error;
+		goto error_pm;
 	}
 
 	patch = (hda_codec_patch_t)hcodec->preset->driver_data;
@@ -455,7 +455,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 		ret = patch(hcodec);
 		if (ret < 0) {
 			dev_err(&hdev->dev, "patch failed %d\n", ret);
-			goto error;
+			goto error_regmap;
 		}
 	} else {
 		dev_dbg(&hdev->dev, "no patch file found\n");
@@ -467,7 +467,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	ret = snd_hda_codec_parse_pcms(hcodec);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to map pcms to dai %d\n", ret);
-		goto error;
+		goto error_regmap;
 	}
 
 	/* HDMI controls need to be created in machine drivers */
@@ -476,7 +476,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 		if (ret < 0) {
 			dev_err(&hdev->dev, "unable to create controls %d\n",
 				ret);
-			goto error;
+			goto error_regmap;
 		}
 	}
 
@@ -496,7 +496,9 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 
 	return 0;
 
-error:
+error_regmap:
+	snd_hdac_regmap_exit(hdev);
+error_pm:
 	pm_runtime_put(&hdev->dev);
 error_no_pm:
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
@@ -518,6 +520,8 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 
 	pm_runtime_disable(&hdev->dev);
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
+
+	snd_hdac_regmap_exit(hdev);
 }
 
 static const struct snd_soc_dapm_route hdac_hda_dapm_routes[] = {
-- 
2.20.1

