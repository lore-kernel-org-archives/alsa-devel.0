Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116BEC4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Nov 2023 10:43:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B7EE844;
	Mon, 27 Nov 2023 11:43:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B7EE844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701081819;
	bh=QeE+iwgmw3Sq38zAMShCiOEs8yjCxoRZ9RY/QNtRo1U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=LZt80Q0OnfZhz91d4mkzJbJvRx32ZSUP9j+KFTBsRATiuFrtqeXGwZciqAPV5Iz/c
	 HIRne/VOXoV0v9FALwQgL3bvQpIRkMzvtY8TExPs2arn0HviQ66U+MCMsAfZz3wOiS
	 C8uzcQLLkmBDEnoLGs7TyncVc74sgI4zTK2flW6w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1120FF8057C; Mon, 27 Nov 2023 11:43:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E047DF80587;
	Mon, 27 Nov 2023 11:43:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE3A6F801D5; Mon, 27 Nov 2023 11:42:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A0C7DF8007E
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2023 11:42:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0C7DF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N2UvX0Fu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701081770; x=1732617770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QeE+iwgmw3Sq38zAMShCiOEs8yjCxoRZ9RY/QNtRo1U=;
  b=N2UvX0Fuge0A37hu6eeaV1Qv2dckNJhQWPg6SzWCmRCEDwJAUdPeHOUx
   usk5C148rYyXH3urvANUTwyrWxKdi9bcKnLmPFJx3AO7OcBji+JClZwtz
   vWB8Y+ONhl2lqfPItszNcKVAmgiNuxR9ZlxM1//IUAWtq02rGK0zXQ2GI
   GKUXJRbocS6NUE+BONS8jlaEYu7CqKxuRlRLIJPSNoU69w21vD6lkIrp0
   WA0PWtYo/ZQRKazmLfe5yJy91kHnVW4Pxa8RkxCNdXQN8O8WKChzmkjgi
   q3vOGGacxMNCudoz1TkxR7+fVBicD7UvxqVwTM+/H+iTW3TdI9wITtWGT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="383068336"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600";
   d="scan'208";a="383068336"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 02:42:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="1015514043"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600";
   d="scan'208";a="1015514043"
Received: from acornagl-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.58.144])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 02:42:38 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com
Subject: [PATCH] ASoC: SOF: Intel: Use existing helpers to change GPROCEN and
 PIE bits
Date: Mon, 27 Nov 2023 12:43:13 +0200
Message-ID: <20231127104313.16661-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TMI6LQKT5MU2JXVC54ZHJAJ44ASULZZS
X-Message-ID-Hash: TMI6LQKT5MU2JXVC54ZHJAJ44ASULZZS
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TMI6LQKT5MU2JXVC54ZHJAJ44ASULZZS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Instead of directly changing the GPROCEN/PIE bits in PPCTL we should use
the existing helper hda_dsp_ctrl_ppcap_enable() and
hda_dsp_ctrl_ppcap_int_enable() helpers for clarity.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 5 ++---
 sound/soc/sof/intel/hda.c        | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 46fb2d1425e9..1805cf754beb 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -510,9 +510,8 @@ int hda_dsp_cl_boot_firmware(struct snd_sof_dev *sdev)
 		return chip_info->init_core_mask;
 
 	/* disable DSP */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR,
-				SOF_HDA_REG_PP_PPCTL,
-				SOF_HDA_PPCTL_GPROCEN, 0);
+	hda_dsp_ctrl_ppcap_enable(sdev, false);
+
 	return ret;
 }
 
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 744c0dd5766d..fe4ae349dad5 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1350,8 +1350,7 @@ void hda_dsp_remove(struct snd_sof_dev *sdev)
 
 	if (!sdev->dspless_mode_selected) {
 		/* disable DSP IRQ */
-		snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR, SOF_HDA_REG_PP_PPCTL,
-					SOF_HDA_PPCTL_PIE, 0);
+		hda_dsp_ctrl_ppcap_int_enable(sdev, false);
 	}
 
 	/* disable CIE and GIE interrupts */
@@ -1366,8 +1365,7 @@ void hda_dsp_remove(struct snd_sof_dev *sdev)
 		chip->power_down_dsp(sdev);
 
 	/* disable DSP */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR, SOF_HDA_REG_PP_PPCTL,
-				SOF_HDA_PPCTL_GPROCEN, 0);
+	hda_dsp_ctrl_ppcap_enable(sdev, false);
 
 skip_disable_dsp:
 	free_irq(sdev->ipc_irq, sdev);
-- 
2.43.0

