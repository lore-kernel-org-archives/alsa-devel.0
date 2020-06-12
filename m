Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF17C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 21:02:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628BB20663
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 21:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iJ5hbdow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628BB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1FFB168A;
	Fri, 12 Jun 2020 23:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1FFB168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591995741;
	bh=1EUs+P8XcNHofGX8tUHPSjJ2uDs6SEat5WSBJ5NZKaU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iJ5hbdow2ppIzjAoWRElYrVnwUeol+b3qhqikG3v0Oj5kWIWrrmrrsJ5Ey1/3VImH
	 HU0XbIUz96A4zwk7GMaIgcLHpydSNIiqNm1Rae0xbX6vGslhu4+fKpTrpsMUPsRDP7
	 F8DqbsBYdTi2P3DICBrZFVL79Y0YmFUnd0udd6jc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09E51F80259;
	Fri, 12 Jun 2020 22:59:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDE5BF80252; Fri, 12 Jun 2020 22:59:54 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FBB4F801F7
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 22:59:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FBB4F801F7
IronPort-SDR: VS6+Sa6fKDgnvHaiRMmN6kMjb401PjTi1RiwM8ZXDYohrst/+hgnoXhMD3F0lVv1dqvpJXjX7B
 tofr/hNIaAww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 13:59:42 -0700
IronPort-SDR: AosUFrwEPv7Jy4LROPLNd1hIK5ALeyuZGk9bLmlewuJIlHv9j8Qs2VbnuFEkK+DjSXDdyM3ij7
 gBlq5dv+9ZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; d="scan'208";a="272026626"
Received: from tcampell-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.137])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2020 13:59:42 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: soc-topology: use devm_snd_soc_register_dai()
Date: Fri, 12 Jun 2020 15:59:38 -0500
Message-Id: <20200612205938.26415-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612205938.26415-1-pierre-louis.bossart@linux.intel.com>
References: <20200612205938.26415-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

Use devm_ to avoid use-after-free KASAN reports and simplify error
handling.

BugLink: https://github.com/thesofproject/linux/issues/2186
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/soc-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 9e89633676b7..43e5745b06aa 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1851,7 +1851,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	list_add(&dai_drv->dobj.list, &tplg->comp->dobj_list);
 
 	/* register the DAI to the component */
-	dai = snd_soc_register_dai(tplg->comp, dai_drv, false);
+	dai = devm_snd_soc_register_dai(tplg->comp->dev, tplg->comp, dai_drv, false);
 	if (!dai)
 		return -ENOMEM;
 
@@ -1859,7 +1859,6 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	ret = snd_soc_dapm_new_dai_widgets(dapm, dai);
 	if (ret != 0) {
 		dev_err(dai->dev, "Failed to create DAI widgets %d\n", ret);
-		snd_soc_unregister_dai(dai);
 		return ret;
 	}
 
-- 
2.20.1

