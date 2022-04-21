Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5005C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 16:39:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9672167B;
	Thu, 21 Apr 2022 18:38:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9672167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650559170;
	bh=PDwfEvpSqAkyBt27EKGSP3yVfAb9+fMilZrvdQMVELA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ue/9mvyYGelRLeu3sY9XZ03QljmdxS1c+J4JhAG+CJVFruuLqlyn69lt2SKAV+7gF
	 5VsCy/N1Ks1OE5LDgA2tRUdY0EtCgJQIgl5S6xFjAqgejvi/bFw3A79TJWqclBdX4f
	 X25d3KQgGoRt+lTVyaNaA1s0uGM1qkK6S13pvSis=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60DBDF80279;
	Thu, 21 Apr 2022 18:38:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03307F8047D; Thu, 21 Apr 2022 18:38:39 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72604F800C1
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 18:38:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72604F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ITObFCI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650559113; x=1682095113;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PDwfEvpSqAkyBt27EKGSP3yVfAb9+fMilZrvdQMVELA=;
 b=ITObFCI5TJy8PuPsgRBIc+VfMQ/7opshvg2g8DaibnwD1p2IutVGA9Zc
 PNI/Ej3cD2ANyhwcI+gbY4ZaCsP/JdDXIiwaSyaUOWGKpwg1EvG1HHRV8
 IT3l0+MTYcrXr0lFXBCc0grE5X+LB5b3iv4db4czCOLpkO/2yuqNriOCa
 uBTVLieQMIR/NnB4pAAFG8B5M1wc9WXYeEPaRVTU+T3oDO62E0SIrmNy3
 zdbUWUtB9t/uM/WGigCV1ZOXCbNFySg+zxmcQVcbVhGddJVvfY/YqnGLz
 Bg7RpgsKtljJxtcEah3XCaPvI1X/x4xZCykxzQVQD0YhFoLwxlSYdGGI0 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262011387"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="262011387"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 09:36:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; d="scan'208";a="658604053"
Received: from qingsu-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.148.250])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2022 09:36:01 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: intel-dsp-config: Add RaptorLake PCI IDs
Date: Thu, 21 Apr 2022 11:35:46 -0500
Message-Id: <20220421163546.319604-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Gongjun Song <gongjun.song@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Gongjun Song <gongjun.song@intel.com>

Add RaptorLake-P PCI IDs

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Gongjun Song <gongjun.song@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 8b0a16ba27d39..a8fe01764b254 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -424,6 +424,15 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x54c8,
 	},
+	/* RaptorLake-P */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x51ca,
+	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x51cb,
+	},
 #endif
 
 };
-- 
2.30.2

