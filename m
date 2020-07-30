Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB5C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:06:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80DD2074B
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AcYJUHkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80DD2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A22C178D;
	Thu, 30 Jul 2020 16:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A22C178D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596117959;
	bh=3tdV5j0cpnlw7whw0DETcuyvp11WfPDXDH3Fj1U9hgY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AcYJUHkkZ/Mnz1CjaqjlragbqJ9zj+gd6rdbl24IB1ShBKVp0qKJw/Vu1Nk80DKnV
	 Kt0Bu33owTMhAhyfuU6qZOaNPjKg3mDHjZ47ntuc0adtV+E01LjaoavSzuIqyU0XXJ
	 e90k6/FEQzJhnb+AjVUrTmYvfh1rwSIlSsRTBp4Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9EDCF8021C;
	Thu, 30 Jul 2020 16:05:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD72EF8021E; Thu, 30 Jul 2020 16:05:06 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B40E2F80111
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 16:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B40E2F80111
IronPort-SDR: t1Nti4OqSgyRPbh3uzAk5eLfDRdTsAvbIrVAivjl8CSou6DYJMExJ+XVeTWJKaIOJYy8x3Q513
 YplzSCWQy/uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139143833"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; d="scan'208";a="139143833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 07:04:44 -0700
IronPort-SDR: aJO6Pw+qYww7vT08+mMIEnlBvzlNsTuyG0Di0FFwK4/qev5Mwy6FKx5/xzPJIb7EyUfnLvpPwN
 VpfvysIVs7Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; d="scan'208";a="272929496"
Received: from sinjanma-mobl.amr.corp.intel.com (HELO
 yzhi-desktop.amr.corp.intel.com) ([10.251.18.27])
 by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2020 07:04:43 -0700
From: Yong Zhi <yong.zhi@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: da7219: Fix general protection fault in
 da7219_register_dai_clks
Date: Thu, 30 Jul 2020 09:04:28 -0500
Message-Id: <1596117868-3317-1-git-send-email-yong.zhi@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Adam.Thomson.Opensource@diasemi.com, pierre-louis.bossart@linux.intel.com,
 Yong Zhi <yong.zhi@intel.com>
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

clkdev_drop(cl) does not null the removed cl, if da7219_register_dai_clks()
entered again after card removal, devm_clk_register() will return -EEXIST,
the goto err to clkdev_drop() will trigger board reboot.

Test commands:
   modprobe -r snd_sof_pci
   modprobe snd_sof_pci

The oops looks like:

da7219 i2c-DLGS7219:00: Using default DAI clk names: da7219-dai-wclk, da7219-dai-bclk
da7219 i2c-DLGS7219:00: Failed to register da7219-dai-wclk: -17
general protection fault: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:clkdev_drop+0x20/0x52
Call Trace:
 da7219_probe+0x52e/0x6dc [snd_soc_da7219]
 soc_probe_component+0x206/0x3a1
 snd_soc_bind_card+0x4ee/0x9a6
 devm_snd_soc_register_card+0x48/0x7b
 audio_probe+0x1f0/0x221 [snd_soc_sof_da7219_max98373]
 platform_drv_probe+0x89/0xa2
 really_probe+0x129/0x30d
 driver_probe_device+0x59/0xec
 ? driver_sysfs_remove+0x55/0x55
 bus_for_each_drv+0xa1/0xdc
 __device_attach+0xc2/0x146
 bus_probe_device+0x32/0x97
 device_add+0x311/0x3b4
 platform_device_add+0x184/0x1eb

Fix by marking (nullifying) the da7219->dai_clks_lookup[i]
after clkdev_drop().

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/codecs/da7219.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 153ea30b5a8f..54da7cfbb5f4 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2369,8 +2369,10 @@ static void da7219_remove(struct snd_soc_component *component)
 
 #ifdef CONFIG_COMMON_CLK
 	for (i = DA7219_DAI_NUM_CLKS - 1; i >= 0; --i) {
-		if (da7219->dai_clks_lookup[i])
+		if (da7219->dai_clks_lookup[i]) {
 			clkdev_drop(da7219->dai_clks_lookup[i]);
+			da7219->dai_clks_lookup[i] = NULL;
+		}
 	}
 #endif
 
-- 
2.7.4

