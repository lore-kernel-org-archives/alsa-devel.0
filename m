Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B22CC43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:42:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963D4206F2
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sWAc83tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963D4206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F214E1664;
	Fri, 27 Mar 2020 19:42:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F214E1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585334575;
	bh=qsRcAAN/f2qeRCW+qiVM9nTlE9O7ttRoYsK0DR2tY1s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sWAc83tN0uMk0817OENTJsIwf0lJcJrqGX2Yaug9nHeeT4XQqJve7c4gfkiD39YQ1
	 QbIMVZCMOR+ejQpziItKPLFYirT+UQLDVZU3bfqWB6I0F/PAD2mcmGsV2bqyDEdUGq
	 iVcyONPrCoWYAymBeDcAwVgaj9v8Su8Vp9vrLfGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AEEBF802BD;
	Fri, 27 Mar 2020 19:38:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7AD48F8028F; Fri, 27 Mar 2020 19:38:07 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E73FF80274
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 19:38:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E73FF80274
IronPort-SDR: QNxRVSlxGarx4qzZF5hkksaiylv98EUMlZ5g6tU7eLO6xSkp8jY1CMSoRTLAM6IqFz9AxbKmq0
 oB5UL0Tncc7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 11:38:02 -0700
IronPort-SDR: LFUZbSmWNcxMqoqW/N3V68g4/IgUHhENKU8DkIwXhp5Pn4n9jBPskr7isZGhxfizf+/pCVcLLQ
 H4k7piw8Jatw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; d="scan'208";a="421192580"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 11:38:00 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 6/6] ASoC: topology: Check return value of
 soc_tplg_dai_config
Date: Fri, 27 Mar 2020 16:47:29 -0400
Message-Id: <20200327204729.397-7-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327204729.397-1-amadeuszx.slawinski@linux.intel.com>
References: <20200327204729.397-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Function soc_tplg_dai_config can fail, check for and handle possible
failure.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---

 v2:
  Added this patch

 sound/soc/soc-topology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index dade27588e51..9d6b266ccef8 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2524,7 +2524,7 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
 {
 	struct snd_soc_tplg_dai *dai;
 	int count;
-	int i;
+	int i, ret;
 
 	count = le32_to_cpu(hdr->count);
 
@@ -2539,7 +2539,12 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
 			return -EINVAL;
 		}
 
-		soc_tplg_dai_config(tplg, dai);
+		ret = soc_tplg_dai_config(tplg, dai);
+		if (ret < 0) {
+			dev_err(tplg->dev, "ASoC: failed to configure DAI\n");
+			return ret;
+		}
+
 		tplg->pos += (sizeof(*dai) + le32_to_cpu(dai->priv.size));
 	}
 
-- 
2.17.1

