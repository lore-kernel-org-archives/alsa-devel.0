Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238B5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:49:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8083F64F0B
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 17:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8083F64F0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1072A166D;
	Mon,  1 Mar 2021 18:48:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1072A166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614620960;
	bh=kmMTmN0aIQKYc4lZUz/OrxYV294lCnyqGKBrrDWhV1w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rXSuDnD/0DChTNfNYxLX30hryF4JUDOADsmKSXNl0QI8HeqGSBKMnkTaiNxe8b7uT
	 jWP/uk94RGpzl7W+hMnp/NOIUGEZ8aWS6qKhFYwbCqRK33Rydsf+ah1FdKE3C/Rszc
	 T0G1KoIf8xccK83V6kABr4e8ukDK8T54lTXXPID0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54434F8042F;
	Mon,  1 Mar 2021 18:47:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E38BBF80423; Mon,  1 Mar 2021 18:47:19 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54085F80423
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 18:47:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54085F80423
IronPort-SDR: pWl46YC/a0oQflJMQfoQ530LJZ30WF5pnRwmq2osJpxZ/6e9218w4kpNfa5fn2yT6IjUhQd/en
 qcI6k+Pl5/Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="185869299"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="185869299"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 09:47:13 -0800
IronPort-SDR: mmBZFFUKcYtGM2WGkCFqkrrxgwaBq11X5VkVXHVqYEek01ol6tlwlv086VJS8QB/ql8/DAi5X7
 tIsLV3JOE++w==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; d="scan'208";a="434363251"
Received: from mhuang8-mobl3.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.25.220])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 09:47:13 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: soc-dai: fix kernel-doc
Date: Mon,  1 Mar 2021 11:46:59 -0600
Message-Id: <20210301174659.117122-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
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

v5.12-rc1 flags new warnings with make W=1, fix missing or broken
function descriptors.

sound/soc/soc-dai.c:167: warning: expecting prototype for
snd_soc_xlate_tdm_slot(). Prototype was for
snd_soc_xlate_tdm_slot_mask() instead

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index cd3bb9a7983f..080fbe053fc5 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -154,7 +154,7 @@ int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 
 /**
- * snd_soc_xlate_tdm_slot - generate tx/rx slot mask.
+ * snd_soc_xlate_tdm_slot_mask - generate tx/rx slot mask.
  * @slots: Number of slots in use.
  * @tx_mask: bitmask representing active TX slots.
  * @rx_mask: bitmask representing active RX slots.
-- 
2.25.1

