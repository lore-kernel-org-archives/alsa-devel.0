Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A8EC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 15:25:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44962610A0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 15:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44962610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B970B174D;
	Mon,  2 Aug 2021 17:24:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B970B174D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627917901;
	bh=MMOaVk6uXFq38tQ1ZsV19rDNcZG3ybnRJ5SfGJ+7Mjc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ns5ZN7lMYDSNQCxE83pz6snzTCCHHIx0Afm6wMRWscZltDcLEjgWw4YnBw+vBNExP
	 XPLKqmzvb5+czhyeERyRxhxNiEpavt239cd9C73SOL3SwBvKz2BVxwTRQq5M5OjcGi
	 L6x3P27FXYHq4bWhSa5/BF+NniReJzmcexoPcnSQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61948F804FA;
	Mon,  2 Aug 2021 17:22:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 698E3F804EB; Mon,  2 Aug 2021 17:22:48 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DFA1F802C4
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 17:22:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DFA1F802C4
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="299065253"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="299065253"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 08:22:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="457974813"
Received: from skarumur-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.72.192])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 08:22:07 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/4] ASoC: Intel: sof_sdw_max98373: remove useless inits
Date: Mon,  2 Aug 2021 10:21:51 -0500
Message-Id: <20210802152151.15832-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802152151.15832-1-pierre-louis.bossart@linux.intel.com>
References: <20210802152151.15832-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

No need to initialize a variable if the next line overwrites the value.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/intel/boards/sof_sdw_max98373.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw_max98373.c b/sound/soc/intel/boards/sof_sdw_max98373.c
index 25daef910aee..25f9065b627c 100644
--- a/sound/soc/intel/boards/sof_sdw_max98373.c
+++ b/sound/soc/intel/boards/sof_sdw_max98373.c
@@ -90,7 +90,7 @@ static int mx8373_enable_spk_pin(struct snd_pcm_substream *substream, bool enabl
 
 static int mx8373_sdw_prepare(struct snd_pcm_substream *substream)
 {
-	int ret = 0;
+	int ret;
 
 	/* according to soc_pcm_prepare dai link prepare is called first */
 	ret = sdw_prepare(substream);
@@ -102,7 +102,7 @@ static int mx8373_sdw_prepare(struct snd_pcm_substream *substream)
 
 static int mx8373_sdw_hw_free(struct snd_pcm_substream *substream)
 {
-	int ret = 0;
+	int ret;
 
 	/* according to soc_pcm_hw_free dai link free is called first */
 	ret = sdw_hw_free(substream);
-- 
2.25.1

