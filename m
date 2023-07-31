Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAE7C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:35:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6443583B;
	Mon, 31 Jul 2023 23:34:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6443583B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690839299;
	bh=Qisg1jzvkj1V1v1DiOJVrF1PE0elLuMSX6vPM5oWG/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=B2C6wzuYXS0b3u0728c4FoqYWXkI79RDm14DRrZT7WxB6+z61hUsLn7XlhMxQnw3L
	 qUzkdCrE+LHXM9DLDRAO3xg67ps09V9hvFiRCD3BGarye/qtMoTxWDzae2m+GiTlM6
	 lQTPG75EnQ8vnPbVFSlU60n8OU3FJCydYX7WN1PM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5239BF80570; Mon, 31 Jul 2023 23:33:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 550DDF80553;
	Mon, 31 Jul 2023 23:33:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CF5EF80535; Mon, 31 Jul 2023 23:33:12 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A179DF80163
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:33:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A179DF80163
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Bnee8Yqw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839188; x=1722375188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qisg1jzvkj1V1v1DiOJVrF1PE0elLuMSX6vPM5oWG/U=;
  b=Bnee8YqwxtBPTyrGVWtMWT65dODQlZPwZ45n41I9ykJ59bh9FqLM+Uno
   Nk57eU3M13duULL0W6swkvPxY4vjSCBCHT3p5XTgWQxe2ekDlqZps6Qic
   JeLwRlRv7MvgsI8+fM7qQfw5X+qGSS4/nZnCqWiJdd15H/RlYozU7rxAq
   SDbqxlYdqt8z/o50HDzjKqHmpz0okECf2OI41FHDAstaplQDshxfEOdzd
   XXVsiAdFMd4DPtyBfS3RHHlncwtDP9LFm9oZ34MFQTML7RvQcb38lW/82
   Jc4I8Knv9E8zqq/peVrCcLBhA8bAmuz4TAMa6Igjade57pY+VAh0WM3CM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435447515"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435447515"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731708907"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="731708907"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:33:04 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 3/6] ASoC: soc-acpi: improve log messagesin
 link_slaves_found()
Date: Mon, 31 Jul 2023 16:32:39 -0500
Message-Id: <20230731213242.434594-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731213242.434594-1-pierre-louis.bossart@linux.intel.com>
References: <20230731213242.434594-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VS75M2STLQXGWJD3LX6WYPAPCLC6ZSIT
X-Message-ID-Hash: VS75M2STLQXGWJD3LX6WYPAPCLC6ZSIT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VS75M2STLQXGWJD3LX6WYPAPCLC6ZSIT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

use 'part_id' to follow MIPI/SoundWire wording and use more consistent
%#x format.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/soc-acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 9319e9b2a033..6d693b2ad5a3 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -181,16 +181,16 @@ bool snd_soc_acpi_sdw_link_slaves_found(struct device *dev,
 				unique_id = SDW_UNIQUE_ID(adr);
 				if (reported_part_count == 1 ||
 				    ids[j].id.unique_id == unique_id) {
-					dev_dbg(dev, "found %x at link %d\n", part_id, link_id);
+					dev_dbg(dev, "found part_id %#x at link %d\n", part_id, link_id);
 					break;
 				}
 			} else {
-				dev_dbg(dev, "part %x reported %d expected %d on link %d, skipping\n",
+				dev_dbg(dev, "part_id %#x reported %d expected %d on link %d, skipping\n",
 					part_id, reported_part_count, expected_part_count, link_id);
 			}
 		}
 		if (j == num_slaves) {
-			dev_dbg(dev, "Slave %x not found\n", part_id);
+			dev_dbg(dev, "Slave part_id %#x not found\n", part_id);
 			return false;
 		}
 	}
-- 
2.39.2

