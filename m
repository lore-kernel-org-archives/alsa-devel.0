Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC829C2BD05
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jun 2024 12:13:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E011E82A;
	Mon, 24 Jun 2024 14:13:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E011E82A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719231191;
	bh=E4Fl9zHfo9CGU+x5houj6BkjHZoBUCL5ihfYUxwUujU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UflcM7yDhVWm9Ugbrt7nR05NBV+L5mAMHtiJl8K5LixFShGYPq21z629EGjOoC5TB
	 Q6ykFR3+8yS2Zb//QFsHZPgZ9a6gqkDzJoekdIwI7TDFFSkxJ7w3oH+O3seKN60npp
	 7gAMspdC/uzzm0fv7yWfN2YtPtE5PPSMK7hiQrL0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98BA3F80620; Mon, 24 Jun 2024 14:11:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F360F80637;
	Mon, 24 Jun 2024 14:11:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87394F80423; Mon, 24 Jun 2024 14:11:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E339F80154
	for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2024 14:11:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E339F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cPgUye1N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719231103; x=1750767103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4Fl9zHfo9CGU+x5houj6BkjHZoBUCL5ihfYUxwUujU=;
  b=cPgUye1NS5ILYtQ13DMfSSaQhAZ86rJDXN5GoRwU0WUCNzsBNuu9hJ4f
   bO0Ztx9Lp2DPdipQ4xCxwfm5IhGJ3UlzCBbZjAn3LubEu3pvZmfR9RIpR
   KeV6QtO00MQ/FmrEVuJnubUbjcu1F1wVwOuhfkXFDC62Ja8TbFug1vybb
   bJDiz0lmAGCxrCu8pCfIXKikiAZbWWFSFJa3gbvG1SpB9KHgax6eAIVYG
   ajX0lKz/JDHWAYfNw/J0AQm4eXU/Crzxr33nuiIC708fivwtpU7GkEF+B
   tncakUrb/nrcrwTK1KTx+IEaJMBWCm9pkr8jl/8JPxkHZz2Gl8yU3lMzE
   Q==;
X-CSE-ConnectionGUID: 5CvsYMEKRTiZxlt3KWGj/w==
X-CSE-MsgGUID: UfNM8TlIRymbqJCtmKFa/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="15887550"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000";
   d="scan'208";a="15887550"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2024 05:11:40 -0700
X-CSE-ConnectionGUID: 91UDQNYqQ8musUgYCZJfmA==
X-CSE-MsgGUID: y9Wh9RELQNuqNqAcb2zHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000";
   d="scan'208";a="43091219"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO
 pbossart-mobl6.intel.com) ([10.245.246.230])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2024 05:11:38 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 3/4] ASoC: Intel: sof_sdw: add quirk for Dell SKU 0B8C
Date: Mon, 24 Jun 2024 14:11:18 +0200
Message-ID: <20240624121119.91552-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624121119.91552-1-pierre-louis.bossart@linux.intel.com>
References: <20240624121119.91552-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZXNFAMN77Y4NGDPD2UFDVUJYDY6UW3XT
X-Message-ID-Hash: ZXNFAMN77Y4NGDPD2UFDVUJYDY6UW3XT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZXNFAMN77Y4NGDPD2UFDVUJYDY6UW3XT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Jack detection needs to rely on JD2, as most other Dell
AlderLake-based devices.

Closes: https://github.com/thesofproject/linux/issues/5021
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 89b92a061489..e94849b84a6b 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -406,6 +406,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		/* No Jack */
 		.driver_data = (void *)SOF_SDW_TGL_HDMI,
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0B8C"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.43.0

