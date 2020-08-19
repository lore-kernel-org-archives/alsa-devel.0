Return-Path: <SRS0=2rKR=B6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6EC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:38:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8352078D
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IrbF9t9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8352078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BD191677;
	Thu, 20 Aug 2020 02:38:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BD191677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597883936;
	bh=C3jnknJ1yuaV6xhGfTQ3QQX+NK0wLk1Dvya86qEqb6M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IrbF9t9NDLeZEkAqHkSA34m6y6jnpZes1Mu/5WDOqiKmTFuO06AyHrQm+T9OFx/B0
	 Ches+eShf9PdK7JjqCoI6JsRmtmdZt2yI2NwU2DGEB8srR5zGEsNHlRmjEw5+zmYef
	 hUtwbt4qVXOouPjyb2btuaRDzVjOZ4jQcEgYWBN8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95405F80216;
	Thu, 20 Aug 2020 02:38:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 317C9F80218; Thu, 20 Aug 2020 02:38:04 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34E2DF80114
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 02:37:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34E2DF80114
IronPort-SDR: k57juKCOePq8ga9u9aD+3Di5rFTKKaZkyX/uLLnFoui3KWrzTxsThCWTrwJ2kuw/MkHZMY71qM
 VCgYsz4Arqaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152821935"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="152821935"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 17:37:50 -0700
IronPort-SDR: wB+ijCfBDvyAk7iBk8biFOdg8/UgprPuE+bWvigBN/oBn+14Lx/jpAfpZwks9xBXDTarmHxEEf
 N5rHUpV8G7Hg==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="472442637"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 17:37:48 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [RESEND] ASoC: SOF: Intel: hda: import SOUNDWIRE_INIT namespace
Date: Wed, 19 Aug 2020 20:44:04 +0800
Message-Id: <20200819124404.3734-1-yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Make sure the SoundWire driver can be loaded

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 63ca920c8e6e..c0b75d682750 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1207,3 +1207,4 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(SND_SOC_SOF_HDA_AUDIO_CODEC);
 MODULE_IMPORT_NS(SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 MODULE_IMPORT_NS(SND_SOC_SOF_XTENSA);
+MODULE_IMPORT_NS(SOUNDWIRE_INTEL_INIT);
-- 
2.17.1

