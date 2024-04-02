Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641B1CD1284
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:01:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 763B12C08;
	Tue,  2 Apr 2024 17:01:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 763B12C08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712070082;
	bh=KEiSZsipQm/e3f21LS8Ya39Ul+7YeHp7MqC0Uee8uzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m8V0v0w/rbf79cUxt3XOTIihkcS6+H+PRuy0q0XfS60tkqouj1RSyfHslvmDNYKOY
	 BDPlRW3DkilllBrr+x5wXx39DD/uGhfTPA+6N1xjQaVPasmK81NQRRkHn4SF2vP9de
	 CjEyeQmKu4KlNhoUTnEyi98CetsQVwo92+zehoY0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8094F805B5; Tue,  2 Apr 2024 17:00:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68691F80580;
	Tue,  2 Apr 2024 17:00:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EA9DF8055C; Tue,  2 Apr 2024 17:00:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1B1CAF80114
	for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2024 17:00:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B1CAF80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=J8Hg1yo5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712070021; x=1743606021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KEiSZsipQm/e3f21LS8Ya39Ul+7YeHp7MqC0Uee8uzY=;
  b=J8Hg1yo5MXcZNO8lzOgqZ1rLBmpPmk6uH2korh+cjEer9zpL3j9eYGNn
   e6aviJKus/OKlRl3B9ra6M6EcTYMN25TFwk+NJ2z4YYRhzHZcDVVq24XC
   g90gfyDIadtm+GSrq6BYY+cgid9LXmMCO0Vp/8A0NUQFm0+peKWRiiLbA
   2UuUzvz2O53T5RJ6TfDd51jUAHXzbUBnv4ht9544fJSRCUZSKQnkyF5d9
   gMzXEwzSqXB4O6VmmXWaEnaziIKx3H1+BkZfU1tHhSfE+iNYGOa8sF1xD
   iHkX7Qn5w35kGH/XiUZk0hYbD716pVfxxWJjyo4BdgO7LeV6XIOrMFGDY
   Q==;
X-CSE-ConnectionGUID: 9SQgLNFSS7GWRDjvmhnKUw==
X-CSE-MsgGUID: bqg6Np27SdO5Fr7DFXtvSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7433826"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000";
   d="scan'208";a="7433826"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 08:00:12 -0700
X-CSE-ConnectionGUID: j7c6EjLCQ2G1F8K60/gzEg==
X-CSE-MsgGUID: LyJ8yZEbR/ujCc/5/Oj1YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000";
   d="scan'208";a="22558028"
Received: from skhare-mobl5.amr.corp.intel.com (HELO pbossart-mobl6.intel.com)
 ([10.212.8.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 08:00:13 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 2/4] ASoC: SOF: amd: acp-loader: abort firmware download on
 write error
Date: Tue,  2 Apr 2024 09:59:57 -0500
Message-Id: <20240402145959.172619-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402145959.172619-1-pierre-louis.bossart@linux.intel.com>
References: <20240402145959.172619-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4I2AMLVMK23C4NAHPQPG23UMK4OBSXQQ
X-Message-ID-Hash: 4I2AMLVMK23C4NAHPQPG23UMK4OBSXQQ
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4I2AMLVMK23C4NAHPQPG23UMK4OBSXQQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

cppcheck reports this issue:

sound/soc/sof/amd/acp-loader.c:299:6: style: Variable 'ret' is
reassigned a value before the old one has been
used. [redundantAssignment]
 ret = request_firmware(&adata->fw_dbin, fw_filename, sdev->dev);
     ^
sound/soc/sof/amd/acp-loader.c:289:6: note: ret is assigned
 ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_IRAM, 0,
     ^
sound/soc/sof/amd/acp-loader.c:299:6: note: ret is overwritten
 ret = request_firmware(&adata->fw_dbin, fw_filename, sdev->dev);
     ^

This behavior is probably unintentional, there's no reason to return
an error for the DRAM but not the IRAM.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp-loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index aad904839b81..2d5e58846499 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -289,6 +289,8 @@ int acp_sof_load_signed_firmware(struct snd_sof_dev *sdev)
 	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_IRAM, 0,
 				      (void *)sdev->basefw.fw->data,
 				      sdev->basefw.fw->size);
+	if (ret < 0)
+		return ret;
 
 	fw_filename = kasprintf(GFP_KERNEL, "%s/%s",
 				plat_data->fw_filename_prefix,
-- 
2.40.1

