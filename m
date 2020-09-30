Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0451C4727E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:45:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4546B20789
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pSB+FiGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4546B20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA19C17EC;
	Wed, 30 Sep 2020 13:44:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA19C17EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601466318;
	bh=JcRYHHTXMXjunL1eThkOST6f6H73xSylh8XSZlfrAUw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pSB+FiGaBgqdkgxoyGqgQE6EsaJaVxgNF1JD4M3TevbwMWsAitPtYsuWzkdiMK9iM
	 yZLIs8zeRWUyBEkciIImrhJEwEsVGUr42jgRLwbrbZyk4e8TCO07EmP9t3uFZ98wCH
	 z6NnOFqeu020JuIOakgzbpIATXR3QMGSMyUTZC30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 622C1F801D8;
	Wed, 30 Sep 2020 13:43:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CB1BF80292; Wed, 30 Sep 2020 13:43:37 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 210F9F80110
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 13:43:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 210F9F80110
IronPort-SDR: abLMZpv7b2Mtz+5pO+QzM57EgzUjSvu2s1QAl+LbKvjBRaBwKEqZLkoHtpK96FP0mwlQFXesbK
 BeJBhA9r/WHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="224022341"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="224022341"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 04:43:24 -0700
IronPort-SDR: qBgwsuT00fsXvHaD4FbK5ZPEC+KO7lXS2vR9n/NOCzZtpGMcmxYjnZqxpGM+n5w+CiGIv+rQD0
 H6nFSwyAifkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="294582996"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2020 04:43:22 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org
Subject: [PATCH v2 1/2] ALSA: HDA: Early Forbid of runtime PM
Date: Wed, 30 Sep 2020 14:41:39 +0300
Message-Id: <20200930114140.3839617-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930114140.3839617-1-kai.vehmanen@linux.intel.com>
References: <20200930114140.3839617-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: cezary.rojewski@intel.com, kailang@realtek.com,
 kai.vehmanen@linux.intel.com, harshapriya.n@intel.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 emmanuel.jillela@intel.com
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

From: Harsha Priya <harshapriya.n@intel.com>

For certain codecs (like Realtek), pm_runtime_forbid() is invoked
in the probe function after build_controls(). In a stress test,
its observed occasionally that runtime PM calls are invoked
before controls are built. This causes the codec to be
runtime suspended before probe completes. Because of this, not all
controls are enumerated correctly, and audio does not work until
system is rebooted.

This issue being common across all codecs, pm_runtime_forbid() is
called when the codec object is created to fix this issue.
A codec enables or disables runtime pm in its own probe function.

Multiple stress tests of 2000+ cycles has been done to test the fix.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Emmanuel Jillela <emmanuel.jillela@intel.com>
Reviewed-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/pci/hda/hda_codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e96a87f1b611..a356c21edb90 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1000,6 +1000,9 @@ int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
 	if (err < 0)
 		goto error;
 
+	/* PM runtime needs to be enabled later after binding codec */
+	pm_runtime_forbid(&codec->core.dev);
+
 	return 0;
 
  error:
-- 
2.27.0

