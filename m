Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A4C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:10:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C75020675
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J+ct06Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C75020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE6C71693;
	Thu, 13 Aug 2020 22:09:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE6C71693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597349413;
	bh=hMKlzBxXhaiQAXfevdBspN1Fj5KQy7rLhOFG5kTM5X8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J+ct06KjDnqeYesLkANSJFvCOeg/V0s9hrIZ2ELVcKoPbAeOXC9E///gN1gnGKdjx
	 04HvXsLiGNGDGCMQaohcmuLhkqd41g5q7k9dpFeiKSVKMfycfLXZWcVK19liUPHPU5
	 TvVXyo0149I/eEAXglA5yQaxiHP9Dl/qG7OZo+gM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4190FF8014C;
	Thu, 13 Aug 2020 22:02:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01428F80307; Thu, 13 Aug 2020 22:02:29 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A056F802A1
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 22:02:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A056F802A1
IronPort-SDR: i9XAi2qX0NVKjK3JQqdUkVyMmaY/BTA+GqPIiNvlsX9TOtPYM7RNMKOoX/XYPB3q0UdW4dbrF/
 NV3dgS8dyzig==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="134374665"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="134374665"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:08 -0700
IronPort-SDR: hnZRzX2ZhFqxQGv0sRRAhdX/l6UUjWa0y5Sh8Rw65b8/g8N43sc3gldkZgHRftqhSfmy3PG88C
 3aLRT2StzCyw==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="495506319"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:06 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 14/21] ASoC: Intel: haswell: (cosmetic) align function
 parameters
Date: Thu, 13 Aug 2020 15:01:40 -0500
Message-Id: <20200813200147.61990-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
References: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
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

Fix cppcheck warning:

sound/soc/intel/haswell/sst-haswell-ipc.c:963:8: style:inconclusive:
Function 'sst_hsw_stream_new' argument 3 names different: declaration
'get_write_position' definition
'notify_position'. [funcArgNamesDifferent]

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.h b/sound/soc/intel/haswell/sst-haswell-ipc.h
index fdc70c77e688..646dbbba327b 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.h
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.h
@@ -414,7 +414,7 @@ int sst_hsw_mixer_get_volume(struct sst_hsw *hsw, u32 stage_id, u32 channel,
 
 /* Stream API */
 struct sst_hsw_stream *sst_hsw_stream_new(struct sst_hsw *hsw, int id,
-	u32 (*get_write_position)(struct sst_hsw_stream *stream, void *data),
+	u32 (*notify_position)(struct sst_hsw_stream *stream, void *data),
 	void *data);
 
 int sst_hsw_stream_free(struct sst_hsw *hsw, struct sst_hsw_stream *stream);
-- 
2.25.1

