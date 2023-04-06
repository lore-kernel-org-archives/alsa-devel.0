Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E7FC76196
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Apr 2023 15:31:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03FD3EF4;
	Thu,  6 Apr 2023 17:30:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03FD3EF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680795069;
	bh=XgEED2Lkt0pBRk4zfZ1HY9BKvT411zspHGOb3jgP2/c=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=F2i2A68Cv/q9Yav5tZpe00py2xc3BqLPBEEB7KB0/qEE9CkQ2pUGhOFCvFx2DVcCM
	 7qgAIZhImlr91x0OAZBG+YLkIV3uhU0vl17a5k3BosWtZ7MvQY0NbSKyYqS3wYnJKp
	 tzoSa5WN4UD85o2LITMEWDqxWDiHtTki4PsYXn+o=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7253AF80149;
	Thu,  6 Apr 2023 17:29:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 354E6F80246; Thu,  6 Apr 2023 17:29:52 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE50DF8015B
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2023 17:29:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE50DF8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gwPSlv7X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680794990; x=1712330990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XgEED2Lkt0pBRk4zfZ1HY9BKvT411zspHGOb3jgP2/c=;
  b=gwPSlv7X/We55G2J0B9iLRFneN0ay6tWYXh6lTSCAzimyCArtovt1CJ+
   Ko4lGXwGku8uQJgkdBVsxseOFRs+uI799mrnXsKiCGR1YVjEnOh50jbMu
   rXPG0zQaCNntUZs5ZyHeOyjJg7lAQIWB/1gHQZAXZCWQvy0fRD02ww8Yq
   RhXCgn1OrVEJf/yfOoiHEUcnE2zkv0dzHp8u5izSYfJkbMds7ZXaq3hA8
   Y1LCX/R6wNONTsRxy9wUsbgORvcpLrWer9BuMz5vlsvsJtrDtZm5Xo5pT
   cuwAzv7diuVxTDrkxBIWXk8kRcaMsQOkZZaXQfw6+oNQtiZ9w0MYqSlJG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="323138233"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400";
   d="scan'208";a="323138233"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 08:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="751681329"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400";
   d="scan'208";a="751681329"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.83.247])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 08:29:45 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: Intel: hda: add __func__ in SoundWire lcount()
 error logs
Date: Thu,  6 Apr 2023 10:29:37 -0500
Message-Id: <20230406152937.15347-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7ZBK4Q6BF5NUZUHPGLZSMDCW2W25PUXN
X-Message-ID-Hash: 7ZBK4Q6BF5NUZUHPGLZSMDCW2W25PUXN
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>
X-Mailman-Version: 3.3.8
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

Make sure SoundWire lcount helpers have unique error logs, but a
common pattern for reporting issues.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/sof/intel/hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 483ec80f3160..2f1f0756ed75 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -213,8 +213,8 @@ int hda_sdw_check_lcount_common(struct snd_sof_dev *sdev)
 	/* Check HW supported vs property value */
 	if (caps < ctx->count) {
 		dev_err(sdev->dev,
-			"BIOS master count %d is larger than hardware capabilities %d\n",
-			ctx->count, caps);
+			"%s: BIOS master count %d is larger than hardware capabilities %d\n",
+			__func__, ctx->count, caps);
 		return -EINVAL;
 	}
 
-- 
2.37.2

