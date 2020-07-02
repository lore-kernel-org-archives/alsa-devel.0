Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B3C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:48:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE9F20760
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AD5CK2ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE9F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D09716CB;
	Thu,  2 Jul 2020 21:47:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D09716CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593719278;
	bh=PIYFXVvN2iIGV2gLBsyVqXoMCPkbHK9ScOBMYkTQa1c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AD5CK2qlxj9FIBBIa8EPTRQ7AInSQPJ5UVbtlp/1TsxwG+0iLacvjo9pYFKL5fBxI
	 vTKFoG/jxnbJ+EIlpFX1+Qq7TRXB7e0fGbk8F/CNQ2XuYFGCFqUJ/2qJGiS0RvtdNt
	 BD0xC5GMZEWEzvmLHMGKCaNtGOE8TOfCVTjeTd6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3681FF8035F;
	Thu,  2 Jul 2020 21:37:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9878F8032A; Thu,  2 Jul 2020 21:37:01 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18D3FF802EC
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:36:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18D3FF802EC
IronPort-SDR: rGviRutvYrB3d8U+hQNEt+/ISzk9a5t4lmAA+wlAK+t8gaI69A7ir9uV9SyxBt/2DflW3A6PFu
 vs3wBErVhs0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148549362"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="148549362"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:30 -0700
IronPort-SDR: 805mtUyw88EYuZtpujctD5eaSxCeEV1RJEsHmz7Q70nwIfq9l3KBB7SBzOMAVD+vUSgECu5uly
 JZro9UcKvblw==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="482116398"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:36:29 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 19/23] ALSA: pci/fm801: fix kernel-doc
Date: Thu,  2 Jul 2020 14:36:00 -0500
Message-Id: <20200702193604.169059-20-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
References: <20200702193604.169059-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warnings, add missing field descriptions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/fm801.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 181ebafa550a..0a95032fd297 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -144,6 +144,8 @@ MODULE_PARM_DESC(radio_nr, "Radio device numbers");
 	
 /**
  * struct fm801 - describes FM801 chip
+ * @dev:		device for this chio
+ * @irq:		irq number
  * @port:		I/O port number
  * @multichannel:	multichannel support
  * @secondary:		secondary codec
@@ -151,6 +153,31 @@ MODULE_PARM_DESC(radio_nr, "Radio device numbers");
  * @tea575x_tuner:	tuner access method & flags
  * @ply_ctrl:		playback control
  * @cap_ctrl:		capture control
+ * @ply_buffer:		playback buffer
+ * @ply_buf:		playback buffer index
+ * @ply_count:		playback buffer count
+ * @ply_size:		playback buffer size
+ * @ply_pos:		playback position
+ * @cap_buffer:		capture buffer
+ * @cap_buf:		capture buffer index
+ * @cap_count:		capture buffer count
+ * @cap_size:		capture buffer size
+ * @cap_pos:		capture position
+ * @ac97_bus:		ac97 bus handle
+ * @ac97:		ac97 handle
+ * @ac97_sec:		ac97 secondary handle
+ * @card:		ALSA card
+ * @pcm:		PCM devices
+ * @rmidi:		rmidi device
+ * @playback_substream:	substream for playback
+ * @capture_substream:	substream for capture
+ * @p_dma_size:		playback DMA size
+ * @c_dma_size:		capture DMA size
+ * @reg_lock:		lock
+ * @proc_entry:		/proc entry
+ * @v4l2_dev:		v4l2 device
+ * @tea:		tea575a structure
+ * @saved_regs:		context saved during suspend
  */
 struct fm801 {
 	struct device *dev;
-- 
2.25.1

