Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9877DC54764
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:52:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8772E80;
	Mon, 19 Feb 2024 11:52:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8772E80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708339930;
	bh=dzTaso4wO+G6d/H8AhaEyUh/RCIlWQ/zztQlM6V9F0w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Z253nG7wMChfWps+MuY3Xg4lmXCO5wKPZg7xKwxe5T6+iTVO7fE58KbAXM+1t0bv8
	 poe0dvYaJ5jg75RIAUnWnxyKKlnc0BFNzZZPSLALiSfvmSwIPYFSBmssS4RfKvrkfo
	 GI6CrPqIyK2yaSdrfIX3c8PuT1XeMGkXe5m0a5eo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE381F80580; Mon, 19 Feb 2024 11:51:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1302BF805A9;
	Mon, 19 Feb 2024 11:51:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C20CF80496; Mon, 19 Feb 2024 11:50:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 20A5EF800EE
	for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2024 11:50:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20A5EF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U5FI3Wgb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708339821; x=1739875821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dzTaso4wO+G6d/H8AhaEyUh/RCIlWQ/zztQlM6V9F0w=;
  b=U5FI3Wgb9dGH9MMUxuFRvIQYWBp2imTIwdWRzh3pdRPsxqe3mb5YOrya
   fYzjnz4BqBf5p5KpFiLHOCRokWLe3grIX+kLr+cp/z8m01AbGBhEnoyQD
   qchuPDHkE00kex21FQqfbIp/H0YJ1Ynb6h8Xl7Y1tbH9lWPgJrF1U0HAg
   Hdk3t5oEjerhsfFEjwwlR8R44RZbLxn8XzR1+Ege6nTCSorVR7j0/RAGn
   bC5VlIPXELbyeOCL3olpO861l1A0EM5n+y15qd5g0r27lH1YpcafGmL4e
   5cv2w21G7JmI33rz8waSHN5KAeEz92RXqjWqngv7ONzArDM4c6iCsulHo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6189523"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000";
   d="scan'208";a="6189523"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2024 02:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000";
   d="scan'208";a="4616255"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa008.fm.intel.com with ESMTP; 19 Feb 2024 02:50:12 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: vkoul@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	amadeuszx.slawinski@linux.intel.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH] soundwire: Use snd_soc_substream_to_rtd() to obtain rtd
Date: Mon, 19 Feb 2024 11:52:06 +0100
Message-Id: <20240219105206.335738-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3RRD32EFMALHUSAHIM4MD7ATZ45FISUB
X-Message-ID-Hash: 3RRD32EFMALHUSAHIM4MD7ATZ45FISUB
X-MailFrom: cezary.rojewski@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3RRD32EFMALHUSAHIM4MD7ATZ45FISUB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Utilize the helper function instead of casting from ->private_data
directly.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/soundwire/stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index f9c0adc0738d..4e9e7d2a942d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1718,7 +1718,7 @@ EXPORT_SYMBOL(sdw_deprepare_stream);
 static int set_stream(struct snd_pcm_substream *substream,
 		      struct sdw_stream_runtime *sdw_stream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *dai;
 	int ret = 0;
 	int i;
@@ -1771,7 +1771,7 @@ EXPORT_SYMBOL(sdw_alloc_stream);
 int sdw_startup_stream(void *sdw_substream)
 {
 	struct snd_pcm_substream *substream = sdw_substream;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sdw_stream_runtime *sdw_stream;
 	char *name;
 	int ret;
@@ -1815,7 +1815,7 @@ EXPORT_SYMBOL(sdw_startup_stream);
 void sdw_shutdown_stream(void *sdw_substream)
 {
 	struct snd_pcm_substream *substream = sdw_substream;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct sdw_stream_runtime *sdw_stream;
 	struct snd_soc_dai *dai;
 
-- 
2.25.1

