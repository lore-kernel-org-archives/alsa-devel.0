Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09635C433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:34:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52111208B6
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cKiPIYk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52111208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46F021684;
	Mon, 12 Oct 2020 12:33:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46F021684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602498837;
	bh=DFR422AfGkt5ek3ubbUc00riWjgB+kVSm8yCL4F8Ys4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cKiPIYk9YsYfK7jtVqX0SH9cTAn1/bCyT78Ut9/JovjlQHWJLPKkY0gD1mEfuYalX
	 JWTJX/xWPJRJSk00CXSZiEV2vXvf0OoxH5E8zD5P3/5pJMdRFRLS0nqyxWq3vWPIen
	 Pk9x2/xR9TGr/U6CeeQD3DbgXdSMhEKGUb6yZnAU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2F90F800F6;
	Mon, 12 Oct 2020 12:33:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3B7CF8021D; Mon, 12 Oct 2020 12:33:04 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75092F8020D
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 12:32:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75092F8020D
IronPort-SDR: 9SCIJZxQl2TaHPv1R3A5Hq7IH6hxFf9hD5/spLDtHsB7j8IwUVN+xFtUNjeRfzVlG6xzXLxS8n
 0DbR37qTiDCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164933662"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="164933662"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 03:32:56 -0700
IronPort-SDR: EotqRfeeMA09PLk6GuPLSXNzhs89dCDv+kJivr2hlNXXav9Zk9IdArLVSmhdzjZ+y4Vlf8RyDn
 qPoWoTVqx5pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="519574027"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 12 Oct 2020 03:32:54 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: Intel: catpt: Relax clock selection conditions
Date: Mon, 12 Oct 2020 12:32:21 +0200
Message-Id: <20201012103221.30759-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201012103221.30759-1-cezary.rojewski@intel.com>
References: <20201012103221.30759-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, andriy.shevchenko@linux.intel.com,
 lgirdwood@gmail.com, tiwai@suse.com, hdegoede@redhat.com, vkoul@kernel.org,
 broonie@kernel.org
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

Stress tests show that DSP may occasionally be late with signaling WAIT
state when all pins are made use of simultaneously plus start/stop
(pause) gets involved. While this isn't tied to standard audio scenarios
where only System Pin (playback and capture) is involved, ensure user is
not hindered when playing with more advanced scenarios.

From DSP perspective, clock acts as a resource: low clock equals less
resources, high clock more resources. Relax clock selection procedure so
only low -> high switch is allowed when awaiting WAIT signal times out.
Once active stream count decreases, DSP will have more time internally to
adjust thus low clock selection becomes possible again.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

TLDR:
While issue is connected to DSP hw/firmware, software may address this
by relaxing the conditions so audio remains stable when stress scenarios
are ongoing for several iterations. It is rare for user to start
system pb/offload0/offload1/system cp/loopback all at once and play with
them but let's account for that too.

 sound/soc/intel/catpt/dsp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/catpt/dsp.c b/sound/soc/intel/catpt/dsp.c
index 7d2968571951..9e807b941732 100644
--- a/sound/soc/intel/catpt/dsp.c
+++ b/sound/soc/intel/catpt/dsp.c
@@ -267,9 +267,12 @@ static int catpt_dsp_select_lpclock(struct catpt_dev *cdev, bool lp, bool waiti)
 					    reg, (reg & CATPT_ISD_DCPWM),
 					    500, 10000);
 		if (ret) {
-			dev_err(cdev->dev, "await WAITI timeout\n");
-			mutex_unlock(&cdev->clk_mutex);
-			return ret;
+			dev_warn(cdev->dev, "await WAITI timeout\n");
+			/* no signal - only high clock selection allowed */
+			if (lp) {
+				mutex_unlock(&cdev->clk_mutex);
+				return 0;
+			}
 		}
 	}
 
-- 
2.17.1

