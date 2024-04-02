Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8015C6FD1F
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:01:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E77E2C3A;
	Tue,  2 Apr 2024 17:01:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E77E2C3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712070095;
	bh=Z+Ybbt9Fy1SY0EwppncHnxJ8noudvlaEyZRsTHXtmrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=q3NhLryAyWAQ/OewbRDna66GafswpTIF+clzln6tEJtkAn3p1bwDdyOXbCHPpQKxI
	 wDVPJLWuoeiQ2ahsPBomchJDs+h0qh/N1yhxZKg+tcdKa1eJeDtqY0lHX1E4xOdL2P
	 F0c4L//y2V7I983ldwkp5YGqRhnxxc2pLQ1FlsdI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF77BF805D2; Tue,  2 Apr 2024 17:00:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 52B13F805BB;
	Tue,  2 Apr 2024 17:00:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06316F805B2; Tue,  2 Apr 2024 17:00:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6AE8DF8016E
	for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2024 17:00:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AE8DF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i6DsXFjT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712070020; x=1743606020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z+Ybbt9Fy1SY0EwppncHnxJ8noudvlaEyZRsTHXtmrc=;
  b=i6DsXFjT+oA02RuCzLqCXf+wFrjW0kGjuNni83bhUzYhI049xzxKLHHn
   YBbpBnSmncSl88vcTlULEEsRG7+lKpCOwROf/+pcYjnLMLyqNMwMUaePL
   QHLSKC0g2eRfttxu2CnVMxZ6grmOUDjEcyya5FfoPRx9/2X9sf1ffVv+3
   FdVEsV2IxjMS9sgrmkVifm8944Hh/I6wkHioFiYoT86CrpAVaP6mfTtOv
   sAdaALoy+Se4tJZlO/91R7LCHkibIVhJ34OWumzzvhBT4IvsRRFj0Jeg5
   Si7KMF06Cn1DutF2lKqiyDqJJi07RHFAAzqr/jGLHT02q77vxYzGfBCus
   w==;
X-CSE-ConnectionGUID: zaCcvi8zTpWSOH+kZ4ND4w==
X-CSE-MsgGUID: Q4SnmtOBSjq7Q3Dh4YkW9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7433822"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000";
   d="scan'208";a="7433822"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 08:00:12 -0700
X-CSE-ConnectionGUID: TvxuCwT4SmegYy/4R03HAg==
X-CSE-MsgGUID: A4QkwMyIS4q/i3CB+PNzew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000";
   d="scan'208";a="22558027"
Received: from skhare-mobl5.amr.corp.intel.com (HELO pbossart-mobl6.intel.com)
 ([10.212.8.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 08:00:12 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Yong Zhi <yong.zhi@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/4] ASoC: SOF: ipc4-loader: save FW version info to debugfs
Date: Tue,  2 Apr 2024 09:59:56 -0500
Message-Id: <20240402145959.172619-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402145959.172619-1-pierre-louis.bossart@linux.intel.com>
References: <20240402145959.172619-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: U5TUKLDF65Y4YM44Y4ALPD2RVQRZLO3N
X-Message-ID-Hash: U5TUKLDF65Y4YM44Y4ALPD2RVQRZLO3N
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
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Yong Zhi <yong.zhi@intel.com>

To check loaded FW version:

$ hexdump -C /sys/kernel/debug/sof/fw_version
00000000  02 00 07 00 63 00 01 00  00 00 00 00 00 00 00 00  |....c...........|

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-loader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/ipc4-loader.c b/sound/soc/sof/ipc4-loader.c
index c79479afa8d0..641c4f24cca9 100644
--- a/sound/soc/sof/ipc4-loader.c
+++ b/sound/soc/sof/ipc4-loader.c
@@ -80,6 +80,14 @@ static ssize_t sof_ipc4_fw_parse_ext_man(struct snd_sof_dev *sdev,
 	dev_dbg(sdev->dev, "Header length: %u, module count: %u\n",
 		fw_header->len, fw_header->num_module_entries);
 
+	/* copy the fw_version of basefw into debugfs at first boot */
+	if (fw == sdev->basefw.fw) {
+		sdev->fw_version.major = fw_header->major_version;
+		sdev->fw_version.minor = fw_header->minor_version;
+		sdev->fw_version.micro = fw_header->hotfix_version;
+		sdev->fw_version.build = fw_header->build_version;
+	}
+
 	fw_lib->modules = devm_kmalloc_array(sdev->dev, fw_header->num_module_entries,
 					     sizeof(*fw_module), GFP_KERNEL);
 	if (!fw_lib->modules)
-- 
2.40.1

