Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8C9C54E5B
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Nov 2023 20:14:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0874E10;
	Tue, 14 Nov 2023 21:13:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0874E10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699992851;
	bh=uFo3JTP2alB99rkg19E443MKdeHnjsbmxR/ux1VI5Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=szRn4VZwzxw643IaXsC3oxQy4+vgPIVjukJxRMoXbVlh+UZa1sH9FpWj2kSELGgue
	 3/0M9BVCfFtetfSKbCSnKc+6vkeHlgBzgqaES11eWMLfeJghqFsZjtmy0cycb27J7h
	 LqftohCMVCyLDCtC+9wDsU0vFxW6XYYijegCpdes=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00A71F805C0; Tue, 14 Nov 2023 21:11:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2225FF805C2;
	Tue, 14 Nov 2023 21:11:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DF87F8058C; Tue, 14 Nov 2023 21:11:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B699F80557
	for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2023 21:11:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B699F80557
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VzMLpQon
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699992694; x=1731528694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFo3JTP2alB99rkg19E443MKdeHnjsbmxR/ux1VI5Z8=;
  b=VzMLpQon2mRuFZqJs5YIm6+JwGTbJz8bkVXI25lNZU8b4lKLSew6nU5O
   agwSqFvDzE6o6yy42yp//be3KwSV/DtfKV2xscdR5nttf8TQIFc7CE5x9
   tOohcSeItXuHHnEUPglWySn0JE9Sp3PaabUh4rVUkpZk5AK+/xSG472qc
   mffdmEToFFbsLqrsznKmZ+Bylme/j0b0ZyeJ2SuMo/dVk9GyBn0+FtzOi
   zcAdFxtLx/oPz0ENyNPU1IJygG+Ojyq7x/uGRb4bOx2ePDfwRSCQ8nbmi
   mV7tZ0Dw2ThRJ51wLYmjV4akDQWbbT3TfJdyfRgVACjJOfayubDRTYHSz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="381134691"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200";
   d="scan'208";a="381134691"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 12:11:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="855422415"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200";
   d="scan'208";a="855422415"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2023 12:11:30 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org,
	tiwai@suse.com,
	perex@perex.cz
Cc: alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	linux-sound@vger.kernel.org,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v3 07/16] ALSA: hda/ca0132: Switch to new stream-format
 interface
Date: Tue, 14 Nov 2023 21:13:08 +0100
Message-Id: <20231114201317.1348066-8-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114201317.1348066-1-cezary.rojewski@intel.com>
References: <20231114201317.1348066-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UNGG3T6DUOQ5K2XQZ374D7LFSWBTHVVN
X-Message-ID-Hash: UNGG3T6DUOQ5K2XQZ374D7LFSWBTHVVN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UNGG3T6DUOQ5K2XQZ374D7LFSWBTHVVN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

To provide option for selecting different bit-per-sample than just the
maximum one, use the new format calculation mechanism.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/pci/hda/patch_ca0132.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 748a3c40966e..aa312441604f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3022,8 +3022,7 @@ static int dma_convert_to_hda_format(struct hda_codec *codec,
 {
 	unsigned int format_val;
 
-	format_val = snd_hdac_calc_stream_format(sample_rate,
-				channels, SNDRV_PCM_FORMAT_S32_LE, 32, 0);
+	format_val = snd_hdac_stream_format(channels, 32, sample_rate);
 
 	if (hda_format)
 		*hda_format = (unsigned short)format_val;
-- 
2.25.1

