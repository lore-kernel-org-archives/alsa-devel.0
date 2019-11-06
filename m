Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F39EC5DF63
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:29:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E5E2178F
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NJYa8cvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E5E2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE5081699;
	Wed,  6 Nov 2019 20:28:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE5081699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573068578;
	bh=UkAnZMCtopVlyRPCu9tfBFQMhTEqSWsL3ut4FC+t85M=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NJYa8cvy+2/Lqd/ngX/ESlcnstJasUaYllRXkDkW8LRoGrncFTrvQgTABCTIgqmSM
	 8VQTEQikPClh+ZbXQF/CruP9Jzl0nsZo37NeRlhWga6MIeyw7kcm1fbsrg7JI8N5M1
	 rmE/fL9w54rZ713jdI0Q3KtOA4HFQ1Tbgr156X0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAD5EF80676;
	Wed,  6 Nov 2019 20:22:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45DEEF8063D; Wed,  6 Nov 2019 20:22:42 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 156CFF805FF
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 20:22:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 156CFF805FF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 11:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; d="scan'208";a="403835096"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
 by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 11:22:35 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed,  6 Nov 2019 13:22:09 -0600
Message-Id: <20191106192223.6003-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
References: <20191106192223.6003-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 05/19] soundwire: intel: add helpers for
	link power down and shim wake
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

These routines are required for power management

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c918a26d0772..fe3a8b3b2c04 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -362,6 +362,59 @@ static int intel_shim_init(struct sdw_intel *sdw)
 	return ret;
 }
 
+static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
+{
+	void __iomem *shim = sdw->link_res->shim;
+	unsigned int link_id = sdw->instance;
+	u16 wake_en, wake_sts;
+
+	if (wake_enable) {
+		/* Enable the wakeup */
+		intel_writew(shim, SDW_SHIM_WAKEEN,
+			     (SDW_SHIM_WAKEEN_ENABLE << link_id));
+	} else {
+		/* Disable the wake up interrupt */
+		wake_en = intel_readw(shim, SDW_SHIM_WAKEEN);
+		wake_en &= ~(SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKEEN, wake_en);
+
+		/* Clear wake status */
+		wake_sts = intel_readw(shim, SDW_SHIM_WAKESTS);
+		wake_sts |= (SDW_SHIM_WAKEEN_ENABLE << link_id);
+		intel_writew(shim, SDW_SHIM_WAKESTS_STATUS, wake_sts);
+	}
+}
+
+static int intel_link_power_down(struct sdw_intel *sdw)
+{
+	int link_control, spa_mask, cpa_mask, ret;
+	unsigned int link_id = sdw->instance;
+	void __iomem *shim = sdw->link_res->shim;
+	u16 ioctl;
+
+	/* Glue logic */
+	ioctl = intel_readw(shim, SDW_SHIM_IOCTL(link_id));
+	ioctl |= SDW_SHIM_IOCTL_BKE;
+	ioctl |= SDW_SHIM_IOCTL_COE;
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	ioctl &= ~(SDW_SHIM_IOCTL_MIF);
+	intel_writew(shim, SDW_SHIM_IOCTL(link_id), ioctl);
+
+	/* Link power down sequence */
+	link_control = intel_readl(shim, SDW_SHIM_LCTL);
+	spa_mask = ~(SDW_SHIM_LCTL_SPA << link_id);
+	cpa_mask = (SDW_SHIM_LCTL_CPA << link_id);
+	link_control &=  spa_mask;
+
+	ret = intel_clear_bit(shim, SDW_SHIM_LCTL, link_control, cpa_mask);
+	if (ret < 0)
+		return ret;
+
+	sdw->cdns.link_up = false;
+	return 0;
+}
+
 /*
  * PDI routines
  */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
