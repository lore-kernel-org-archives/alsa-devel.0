Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6446C6FA99
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Mar 2023 13:36:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D7651861;
	Fri, 10 Mar 2023 14:35:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D7651861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678455359;
	bh=9WpvSekLnoMoMA9/uJ5Eegqw5tWDtYOfu64eO7bbNu8=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=s32jHitdcWJiKwC6zPnFRKya0Qooze51wwQPEXoCSlcDq17duwLrHpdoC9zCuT0mD
	 MgVg9bsELSFrxpnQaNVjlUu0a288U5d13o0L+z4pCaAlfqfz2Y0EAZJxdgC7ertCln
	 t8mZsOU6kZUfC9cmqor0x+lIXhSVAwrkg699l1iw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98FD2F8042F;
	Fri, 10 Mar 2023 14:34:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC143F8042F; Fri, 10 Mar 2023 14:34:42 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0FC09F800DF
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2023 14:34:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FC09F800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cqZj9Y7P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678455278; x=1709991278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9WpvSekLnoMoMA9/uJ5Eegqw5tWDtYOfu64eO7bbNu8=;
  b=cqZj9Y7PzGtRfNnWBDxspxK8EMYB3wwvgC9ZOA+7kIYIJJ0fNlI/h8Oj
   MdAGahKE4uDiiewK/tAQRBnXJkEM/ohNQ7L95tqmzAkLZq9GDWm4VIsxN
   rbEXOgpR2k9DipzBlGF3ziR35Etb5JPQVmBHQQ/navgme6dOhmGCwt5KI
   eosZ5dSZfBHx1oZ9aWk0jc0Sl6E6xvUcsAXBuVgEuVUuJP1YCS3OggtZX
   tqN+/vti6yn+pCiotIJcT6GETnbRvdbL7cKNYqlS0H/lFhEIHL1IVpHrk
   jMxxCeGUGWrsgJYxLYSnFTyN2QS8YQocSfNXQelRzjBX+i0J1jm+MlX5N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="401586459"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400";
   d="scan'208";a="401586459"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 05:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="708008699"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400";
   d="scan'208";a="708008699"
Received: from kfrascar-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.220.67])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 05:34:32 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH] Revert "ASoC: SOF: Intel: MTL: Enable DMI L1"
Date: Fri, 10 Mar 2023 15:34:54 +0200
Message-Id: <20230310133454.15362-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WNAV77BI24BBXYGUICSCBP4J2SDOCUL2
X-Message-ID-Hash: WNAV77BI24BBXYGUICSCBP4J2SDOCUL2
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WNAV77BI24BBXYGUICSCBP4J2SDOCUL2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This reverts commit 2b5a30cafb2eff4e6a34bc80b1d16ed6ca5c2c71.

It came to our attention that the access to the EM2 register is restricted
to the DSP side on MTL compared to prior platforms.

Writing to it from the host side has no effect (negative or positive), it
is better to remove the code to not cause confusion and wrong impression.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/mtl.c | 3 ---
 sound/soc/sof/intel/mtl.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 216fd07a3a93..307faad2ecf4 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -280,9 +280,6 @@ static int mtl_dsp_post_fw_run(struct snd_sof_dev *sdev)
 	}
 
 	hda_sdw_int_enable(sdev, true);
-
-	/* enable DMI L1 */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, MTL_EM2, MTL_EM2_L1SEN, MTL_EM2_L1SEN);
 	return 0;
 }
 
diff --git a/sound/soc/sof/intel/mtl.h b/sound/soc/sof/intel/mtl.h
index ddc05304a9d5..26418fb08807 100644
--- a/sound/soc/sof/intel/mtl.h
+++ b/sound/soc/sof/intel/mtl.h
@@ -28,8 +28,6 @@
 #define MTL_HFINTIPPTR_PTR_MASK		GENMASK(20, 0)
 
 #define MTL_HDA_VS_D0I3C		0x1D4A
-#define MTL_EM2				0x1c44
-#define MTL_EM2_L1SEN			BIT(13)
 
 #define MTL_DSP2CXCAP_PRIMARY_CORE	0x178D00
 #define MTL_DSP2CXCTL_PRIMARY_CORE	0x178D04
-- 
2.39.2

