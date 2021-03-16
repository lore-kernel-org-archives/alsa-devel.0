Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654BAC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 00:54:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA5A64F04
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 00:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA5A64F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 677B41925;
	Tue, 16 Mar 2021 01:53:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 677B41925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615856049;
	bh=cDMLyaVL1XuNoAg2DYgXOqTFbOF4dcTo2Lrv9kox6AE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uxQY95YUNp+301ldb9H+EwZJb6xsdokmSfB+fMF4OoX7wrYBfbBygCd2a4YixQdPj
	 xb0dc9i53b91fgwI5PM+FnJJSgZP+3n7brzjdddxMFPkuUcXIkIKDayR9Z6YJPdthb
	 5So6vF79xQuf+FF/s+VHVtgDiWOW/OxffF1XSUkU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9E28F80163;
	Tue, 16 Mar 2021 01:53:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53D68F80171; Tue, 16 Mar 2021 01:53:17 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CACCF8010E
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 01:53:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CACCF8010E
IronPort-SDR: 6gU/q3hp1wDeYHoK1MNBl/WCz2iOg6OCdMDeNZ4jmfAcBsOyCT48k1ANQ8kPyABNqY+rW1tCdq
 YkF9nfLNU9vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="168449320"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="168449320"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 17:53:05 -0700
IronPort-SDR: aD5EhP2CoJk8JDSDz5hf83OzxcxX66qiHwPKzRLaIk6ugYciYL3umJBE3tTQgcBM+ZmnY3grBz
 cXvQXg7P1Bwg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; d="scan'208";a="412026890"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 17:53:03 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH] ASoC: rt711: add snd_soc_component remove callback
Date: Tue, 16 Mar 2021 08:52:54 +0800
Message-Id: <20210316005254.29699-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

We do some IO operations in the snd_soc_component_set_jack callback
function and snd_soc_component_set_jack() will be called when soc
component is removed. However, we should not access SoundWire registers
when the bus is suspended.
So set regcache_cache_only(regmap, true) to avoid accessing in the
soc component removal process.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/codecs/rt711.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 202bf6fbc5be..9f5b2dc16c54 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -895,6 +895,13 @@ static int rt711_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static void rt711_remove(struct snd_soc_component *component)
+{
+	struct rt711_priv *rt711 = snd_soc_component_get_drvdata(component);
+
+	regcache_cache_only(rt711->regmap, true);
+}
+
 static const struct snd_soc_component_driver soc_codec_dev_rt711 = {
 	.probe = rt711_probe,
 	.set_bias_level = rt711_set_bias_level,
@@ -905,6 +912,7 @@ static const struct snd_soc_component_driver soc_codec_dev_rt711 = {
 	.dapm_routes = rt711_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(rt711_audio_map),
 	.set_jack = rt711_set_jack_detect,
+	.remove = rt711_remove,
 };
 
 static int rt711_set_sdw_stream(struct snd_soc_dai *dai, void *sdw_stream,
-- 
2.17.1

