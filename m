Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CADCD1292
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:05:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 342152CEC;
	Thu,  4 Apr 2024 21:04:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 342152CEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712257502;
	bh=dO0+Df+UCol+vwpv6OirQZXMXDUJ4CDtRVfQipUXjgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ExibwIxz471VMXzK3Ha6AuweQCIiqHb/jS4IsRwCC76ZGIlFT5BuUL2A2GzUIXGif
	 JDS8XUJ6WkZdOpyS7IhP4HRnt2ktsD2Ys33u/RZ+r08ITc+RjC5PLFRyn2sM/dKPT0
	 aywW6WhwrdVt6emdWGsrEufskv1AH5pKv2dPFkyU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47875F805C0; Thu,  4 Apr 2024 21:04:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73276F80238;
	Thu,  4 Apr 2024 21:04:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C6FDF80007; Thu,  4 Apr 2024 21:04:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ACC31F8020D
	for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2024 21:04:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACC31F8020D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a/YlBOrd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712257450; x=1743793450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dO0+Df+UCol+vwpv6OirQZXMXDUJ4CDtRVfQipUXjgI=;
  b=a/YlBOrd9rru5ZYmkYjIW/9XtG+fC4LDIzu+t83qxP5IOvXcfpV368EY
   jnL5GyI7IDFaBDA2/pM1HBGjkakUO54VgKC69K+AW394lTUvXr7DTx9LD
   44qEjSUn9N5JmFDGkiUhE7Af8qyYKy2XO+zsozJnxkD3C06LC2p2omKMu
   ydg0E8YK+1t2zfJSwtwDqyd3qUcj6l0oar7NV5GvtJ2S98admHYzn1YvH
   BOHn2GNXl7vuzquvmGYGhkxWqmrNmpyy/SFTYepaGoJDW7zUvP8jGCSOO
   UnWf9rqMMhJjqJYBPIzqEgKiLK04yMU5L2LctwZi2tbdDGDKQBhJmZOsY
   g==;
X-CSE-ConnectionGUID: h41VHZU0ToSftRQLEoP6qQ==
X-CSE-MsgGUID: dA5lUh/DQTmjtap/GF693w==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7433865"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000";
   d="scan'208";a="7433865"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 12:04:05 -0700
X-CSE-ConnectionGUID: NlKdAZtzQk+zr/P2+CC+Ug==
X-CSE-MsgGUID: +h89JjrjQ0anJj+DMVWDLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000";
   d="scan'208";a="19492309"
Received: from sparrish-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl6.intel.com) ([10.212.119.106])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 12:04:05 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>
Subject: [PATCH 2/4] ASoC: SOF: Intel: lnl: add helper to detect SoundWire
 wakes
Date: Thu,  4 Apr 2024 14:03:55 -0500
Message-Id: <20240404190357.138073-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240404190357.138073-1-pierre-louis.bossart@linux.intel.com>
References: <20240404190357.138073-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: H2FXGSIRMMXMVW3ED55LHZ3OPED3HQ6E
X-Message-ID-Hash: H2FXGSIRMMXMVW3ED55LHZ3OPED3HQ6E
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The global STATESTS register will provide information on all
links. Rather than iterate on all possible links, the helpers only
filters the range of possible bits for a quick lookup. The
process_wakeen() helper will walk through all the links and deal with
wakes.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/sof/intel/lnl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
index 95da0c626832..c3ee507e2e21 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -205,6 +205,23 @@ static int lnl_dsp_disable_interrupts(struct snd_sof_dev *sdev)
 	return mtl_enable_interrupts(sdev, false);
 }
 
+static bool lnl_sdw_check_wakeen_irq(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	u16 wake_sts;
+
+	/*
+	 * we need to use the global HDaudio WAKEEN/STS to be able to
+	 * detect wakes in low-power modes. The link-specific information
+	 * is handled in the process_wakeen() helper, this helper only
+	 * detects a SoundWire wake without identifying the link.
+	 */
+	wake_sts = snd_hdac_chip_readw(bus, STATESTS);
+
+	/* filter out the range of SDIs that can be set for SoundWire */
+	return wake_sts & GENMASK(SDW_MAX_DEVICES, SDW_INTEL_DEV_NUM_IDA_MIN);
+}
+
 const struct sof_intel_dsp_desc lnl_chip_info = {
 	.cores_num = 5,
 	.init_core_mask = BIT(0),
@@ -221,6 +238,7 @@ const struct sof_intel_dsp_desc lnl_chip_info = {
 	.read_sdw_lcount =  hda_sdw_check_lcount_ext,
 	.enable_sdw_irq = lnl_enable_sdw_irq,
 	.check_sdw_irq = lnl_dsp_check_sdw_irq,
+	.check_sdw_wakeen_irq = lnl_sdw_check_wakeen_irq,
 	.check_ipc_irq = mtl_dsp_check_ipc_irq,
 	.cl_init = mtl_dsp_cl_init,
 	.power_down_dsp = mtl_power_down_dsp,
-- 
2.40.1

