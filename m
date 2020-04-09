Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EB1C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:47:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF9D20757
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZmYQq8sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF9D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D80A2169C;
	Thu,  9 Apr 2020 20:46:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D80A2169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586458064;
	bh=g2ZrUr8WGp/Ug+zphZiS15LPSUsDxywgZZ16ls6rASk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZmYQq8srwTxjGeyWn+Cx3sLlQfgT7lXHy7POhkkXujfq6oOs8eXHGazHEng37+ALu
	 pWUFtW1JY/bmBIck7MM8Mjw5rKTnOWTgpBrkB/kKxDuMKzYZzMVb2/BaUlFvGrcmy6
	 5Nplz9dZ0zYA9hucd5g81WzP9xO18qlFP8NeIpNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D6FFF8028F;
	Thu,  9 Apr 2020 20:44:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0B6CF80218; Thu,  9 Apr 2020 20:44:47 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 171EAF800CB
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 20:44:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 171EAF800CB
IronPort-SDR: mm+jjWEOV6aWBwRPYJ/FfuyFSXdOo95oclTnDlLXOPdPG8VRtI6LelkulDf3DOhwMRBnRz0vrW
 wkJNlsliRCCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 11:44:34 -0700
IronPort-SDR: rkTyRlaYA+CElBJJPY0DsJ8cDrh935RPng5wivolZVWr4gaQNL8+3Cwfyi7w//XI9dYfRBPPgK
 E9C40qHQciZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="251981358"
Received: from davidadu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.151.218])
 by orsmga003.jf.intel.com with ESMTP; 09 Apr 2020 11:44:33 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ASoC: soc-core: Add dynamic debug logs in
 soc_dai_link_sanity_check()
Date: Thu,  9 Apr 2020 13:44:16 -0500
Message-Id: <20200409184416.15591-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409184416.15591-1-pierre-louis.bossart@linux.intel.com>
References: <20200409184416.15591-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

When a platform device is created successfully but the machine driver
probe fails due to errors with missing components during the card bind
stage, no error is propagated or logged. To help flag such problems,
add a dynamic debug log.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 843b8b1c89d4..8b2f6dd2fc8e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -865,8 +865,12 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 		 * Defer card registration if codec component is not added to
 		 * component list.
 		 */
-		if (!soc_find_component(codec))
+		if (!soc_find_component(codec)) {
+			dev_dbg(card->dev,
+				"ASoC: codec component %s not found for link %s\n",
+				codec->name, link->name);
 			return -EPROBE_DEFER;
+		}
 	}
 
 	for_each_link_platforms(link, i, platform) {
@@ -886,8 +890,12 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 		 * Defer card registration if platform component is not added to
 		 * component list.
 		 */
-		if (!soc_find_component(platform))
+		if (!soc_find_component(platform)) {
+			dev_dbg(card->dev,
+				"ASoC: platform component %s not found for link %s\n",
+				platform->name, link->name);
 			return -EPROBE_DEFER;
+		}
 	}
 
 	for_each_link_cpus(link, i, cpu) {
@@ -908,8 +916,12 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 		 * component list.
 		 */
 		if ((cpu->of_node || cpu->name) &&
-		    !soc_find_component(cpu))
+		    !soc_find_component(cpu)) {
+			dev_dbg(card->dev,
+				"ASoC: cpu component %s not found for link %s\n",
+				cpu->name, link->name);
 			return -EPROBE_DEFER;
+		}
 
 		/*
 		 * At least one of CPU DAI name or CPU device name/node must be
-- 
2.20.1

