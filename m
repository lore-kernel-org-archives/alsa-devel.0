Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4D9C001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:48:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B3B1850;
	Mon, 31 Jul 2023 23:48:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B3B1850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690840131;
	bh=ZSDWJHntUt2uNuQEDwc3u3RCmyZQu3SHjuHoOKgKr9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kSnWlN5YBTjpDW7krOibpv2XSfpxVmmeJpO2DkL7WV5jt3jhh2otkHxjh2HwEM95j
	 isPpbe5l8ksWlvfKsxjZ8g3Drcr0wyfSxX/vAVOa7KNlFcTU+4/nuk70rI4icsKq04
	 y8Bo35eSx3mcJRnVjz4l9tXfuoRKlMbj/URhnsRk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFE07F80620; Mon, 31 Jul 2023 23:44:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3148CF80620;
	Mon, 31 Jul 2023 23:44:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13A64F805B1; Mon, 31 Jul 2023 23:43:34 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE947F80163
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:43:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE947F80163
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=moL92I9u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839805; x=1722375805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSDWJHntUt2uNuQEDwc3u3RCmyZQu3SHjuHoOKgKr9M=;
  b=moL92I9ucxXKr0IatON4YWo4UEDcnxxNClPN2CyUORfZ40+U/kx5IXpn
   SjPCbOp/Nh5YJ6I/c6FSrl9vAdHj/pmxhgUI+4R/W8Agl/voINvcCR8yI
   /IfGEnqbjGl1tp48Aypa8+SJKfLjguOWbqygvrdmoo0ennAV2/2APbLXT
   Ky66GKH8frpjb3e5GF3CzTL8fPUpeX/FeK6sJLU2BWQVxE2XfA/Mnz1I2
   woJoaPJrQAssYfgurjnmEYnQyY2POfCg+miM3NBGGUgGaSPmPevxprX9s
   jCw6gpaF5V/5MeXuGxWH6HupOUs1Tc42pDXbowqMFzqxXmYDjUTRTjEAi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435449805"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435449805"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="763523566"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="763523566"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:20 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 19/23] ASoC: intel: sof_sdw: Allow direct specification of
 CODEC name
Date: Mon, 31 Jul 2023 16:42:53 -0500
Message-Id: <20230731214257.444605-20-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
References: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7N3Y7UZIY2WPT7FXE25Q66GMXODM6GUI
X-Message-ID-Hash: 7N3Y7UZIY2WPT7FXE25Q66GMXODM6GUI
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7N3Y7UZIY2WPT7FXE25Q66GMXODM6GUI/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Charles Keepax <ckeepax@opensource.cirrus.com>

Add support for MFD based CODEC drivers, by allowing the CODEC name to
not be the SoundWire device directly.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c        | 6 +++++-
 sound/soc/intel/boards/sof_sdw_common.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 846ba8e1515c..e6faed2b99b2 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1174,7 +1174,11 @@ static int create_codec_dai_name(struct device *dev,
 		class_id = SDW_CLASS_ID(adr);
 
 		comp_index = i - adr_index + offset;
-		if (is_unique_device(adr_link, sdw_version, mfg_id, part_id,
+		if (codec_info_list[codec_index].codec_name) {
+			codec[comp_index].name =
+				devm_kstrdup(dev, codec_info_list[codec_index].codec_name,
+					     GFP_KERNEL);
+		} else if (is_unique_device(adr_link, sdw_version, mfg_id, part_id,
 				     class_id, i)) {
 			codec_str = "sdw:%01x:%04x:%04x:%02x";
 			codec[comp_index].name =
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index 37402170d5f9..fe234b98eb64 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -80,6 +80,7 @@ struct sof_sdw_dai_info {
 struct sof_sdw_codec_info {
 	const int part_id;
 	const int version_id;
+	const char *codec_name;
 	int amp_num;
 	const u8 acpi_id[ACPI_ID_LEN];
 	const bool ignore_pch_dmic;
-- 
2.39.2

