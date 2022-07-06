Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8390C43334
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jul 2022 11:55:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7EB516C2;
	Wed,  6 Jul 2022 13:54:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7EB516C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657108514;
	bh=1eXT+G98E/o3gr3OosP9Y9JKjt6nvh8Gu8NXUG2kDOY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bOygOzWsTB99adB+2NXZ9RWJxpWpDUNl9pn4InkW5IbNugf5LOk/88tiWx0RTV808
	 yvy37sEzGkWm4xUnPzUVt2MP/oheXOwz267F+DNg1EEu8hjP5TsPL/s7P7tprdNdlE
	 qnFQwWs1YOzcQfuA0aZBWmEX5shtoFzg8g2G7j0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9ED50F8053A;
	Wed,  6 Jul 2022 13:52:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0340FF8055B; Wed,  6 Jul 2022 13:52:53 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B780AF80552
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2022 13:52:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B780AF80552
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="MnrL2o9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657108370; x=1688644370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1eXT+G98E/o3gr3OosP9Y9JKjt6nvh8Gu8NXUG2kDOY=;
 b=MnrL2o9M4Q+A9ZAs3LGguGK9AjB0VfZvmqOJ/uVGICljzkRozhYOMSdm
 kHXvHh+dTlJWOzIv5GI3yaMvaCQgKSX7IUlZjtyJJo9URq4V0Gt8auIC6
 hg5Wy4cf1jwCvA9mgc4wRHFcEjl9rrZy3qcfjjAaUloTDmPrclDAdCYXu
 HuHMjc7ohVxBEE3yGxG1jOVfmMFENEjAv2xmtGSnpFpgQVTQUJ0pW+vNk
 xOog+eh/UDEhYIL9oCPmMm83lNfLxok02/ha+AevtTNBDQIiFoLa406X8
 CPMT5E5VMPlQbWmAh7WQx9tbbG7Er4mTuiYA2Ol0Cd74RpkyIXnu2hkuA w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="370042649"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; d="scan'208";a="370042649"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2022 04:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; d="scan'208";a="920136306"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2022 04:52:46 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.com
Subject: [PATCH 7/9] ALSA: hda: Reset all SIE bits in INTCTL
Date: Wed,  6 Jul 2022 14:02:28 +0200
Message-Id: <20220706120230.427296-8-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706120230.427296-1-cezary.rojewski@intel.com>
References: <20220706120230.427296-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Old code resets SIE for up to 8 streams using byte accessor, but
register is laid out in following way:

31 GIE
30 CIE
29:x Reserved
x-1:0 SIE

If there is more than 8 streams, some of them may and up with enabled
interrupts. To fix this just clear whole INTCTL register when disabling
interrupts.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/hda/hdac_controller.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index f7bd6e2db085..9a60bfdb39ba 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -474,11 +474,8 @@ static void azx_int_disable(struct hdac_bus *bus)
 	list_for_each_entry(azx_dev, &bus->stream_list, list)
 		snd_hdac_stream_updateb(azx_dev, SD_CTL, SD_INT_MASK, 0);
 
-	/* disable SIE for all streams */
-	snd_hdac_chip_writeb(bus, INTCTL, 0);
-
-	/* disable controller CIE and GIE */
-	snd_hdac_chip_updatel(bus, INTCTL, AZX_INT_CTRL_EN | AZX_INT_GLOBAL_EN, 0);
+	/* disable SIE for all streams & disable controller CIE and GIE */
+	snd_hdac_chip_writel(bus, INTCTL, 0);
 }
 
 /* clear interrupts */
-- 
2.25.1

