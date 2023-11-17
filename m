Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAC1C072A2
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Nov 2023 12:10:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3777CE8A;
	Fri, 17 Nov 2023 13:09:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3777CE8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700223021;
	bh=2YYQR5ixxhTMKNWeou1HeGzKjXJ4T6/uurneYHpopNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Int7NIeACMwNu0abIRagmjH7r8DuH0H034/65H3ZCSTIoqDuX3+g8q1+xBzxeuQ5b
	 w33/6IqautkjV++BmW9BVAszHNIGS7X5CuDtyWsa/Ev0ccXumnxrkDXAKMk+v3wJdY
	 XuMVkkyEHnW/oYWzBgGeQzuB3z7sCxo2v5fPxkW8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83C0BF805A8; Fri, 17 Nov 2023 13:07:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2103F805A9;
	Fri, 17 Nov 2023 13:07:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CF4AF801D5; Fri, 17 Nov 2023 13:07:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7B8B8F80249
	for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2023 13:04:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B8B8F80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SQsr+1TI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700222662; x=1731758662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2YYQR5ixxhTMKNWeou1HeGzKjXJ4T6/uurneYHpopNo=;
  b=SQsr+1TIDNIjzon6c4V5GV0u8QspbDeEJwKwrES6ev2zcwkWcCtWUjgV
   wsCKfCvDrpQaM6ag3E+KOJ12jBvB9BpBJVWIV6OgbgtYD34RTdoZ0Tp9M
   +msUwpYB2hSgbTx4yTpuIiIa26cTNjPB9jzbmHkoonwTC6gxR8t39t4eQ
   DDuf0vUBvglbqgw3mxYPbXZ6dM2xk6bdfQ/5Ho49//O89crFPqyP6LugU
   hiFKnRPUXXD2g4esTkekegijSAATEgbBqrb1QyQGt9J47QjdG71DOqcaK
   +iTKTNjMwxS8iXiSR9MixiL9gH1LPw8hag/Wp6fF+TM+ED/jVMp+wAqhN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="381675232"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600";
   d="scan'208";a="381675232"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 04:04:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="883110178"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600";
   d="scan'208";a="883110178"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2023 04:04:14 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v5 06/16] ALSA: hda/hdmi: Switch to new stream-format
 interface
Date: Fri, 17 Nov 2023 13:06:00 +0100
Message-Id: <20231117120610.1755254-7-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117120610.1755254-1-cezary.rojewski@intel.com>
References: <20231117120610.1755254-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: WKPHOEXNCQP2P7FVDDT24WVBZKSB2BGL
X-Message-ID-Hash: WKPHOEXNCQP2P7FVDDT24WVBZKSB2BGL
X-MailFrom: cezary.rojewski@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WKPHOEXNCQP2P7FVDDT24WVBZKSB2BGL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

To provide option for selecting different bit-per-sample than just the
maximum one, use the new format calculation mechanism.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 687b8b8fd7ac..dff2d7221982 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1655,7 +1655,6 @@ static void hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 
 #define I915_SILENT_RATE		48000
 #define I915_SILENT_CHANNELS		2
-#define I915_SILENT_FORMAT		SNDRV_PCM_FORMAT_S16_LE
 #define I915_SILENT_FORMAT_BITS	16
 #define I915_SILENT_FMT_MASK		0xf
 
@@ -1668,8 +1667,8 @@ static void silent_stream_enable_i915(struct hda_codec *codec,
 				 per_pin->dev_id, I915_SILENT_RATE);
 
 	/* trigger silent stream generation in hw */
-	format = snd_hdac_calc_stream_format(I915_SILENT_RATE, I915_SILENT_CHANNELS,
-					     I915_SILENT_FORMAT, I915_SILENT_FORMAT_BITS, 0);
+	format = snd_hdac_stream_format(I915_SILENT_CHANNELS, I915_SILENT_FORMAT_BITS,
+					I915_SILENT_RATE);
 	snd_hda_codec_setup_stream(codec, per_pin->cvt_nid,
 				   I915_SILENT_FMT_MASK, I915_SILENT_FMT_MASK, format);
 	usleep_range(100, 200);
-- 
2.25.1

