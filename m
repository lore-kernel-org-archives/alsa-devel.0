Return-Path: <SRS0=MK90=ML=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9BEC07E95
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 23:19:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69E360FE9
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 23:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69E360FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 965911614;
	Tue, 20 Jul 2021 01:18:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 965911614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626736744;
	bh=6kzXE3MdOCuPCtknLlN+15HxrzAKwH7FJqx5XRG9Cgs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pMyzDeuWBuj4W+VJVrA49DZgRCRXl+k1YvqQT8QHQVhDWBss8JJ4IWji5F79ONiA/
	 rqYsnK58lY29z6Q4hXBMKenPcxVI8QDnmMMHJxAJ/LvXT3I8FeJ+gcDQgbDk0oRTXP
	 yOPu44P0GX1bbkAHjIawlBbjKdsshwVCeqaXmHbU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33B81F80218;
	Tue, 20 Jul 2021 01:18:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0677F800DA; Tue, 20 Jul 2021 01:18:11 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 261D3F800DA
 for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2021 01:17:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 261D3F800DA
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190733691"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="190733691"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 16:17:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="575600803"
Received: from mjduranm-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.21])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 16:17:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: intel-dsp-cfg: add missing ElkhartLake PCI ID
Date: Mon, 19 Jul 2021 18:17:46 -0500
Message-Id: <20210719231746.557325-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

We missed the fact that ElkhartLake platforms have two different PCI
IDs. We only added one so the SOF driver is never selected by the
autodetection logic for the missing configuration.

BugLink: https://github.com/thesofproject/linux/issues/2990
Fixes: cc8f81c7e625 ('ALSA: hda: fix intel DSP config')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index d8be146793ee..c9d0ba353463 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -319,6 +319,10 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC,
 		.device = 0x4b55,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC,
+		.device = 0x4b58,
+	},
 #endif
 
 /* Alder Lake */
-- 
2.25.1

