Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA7C10F27
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:49:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869342146E
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ge9CD8oX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869342146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC9791692;
	Tue, 10 Mar 2020 18:48:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC9791692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583862546;
	bh=GMfM6M1cDVXvXWF0yw8a/rZqyqymMfuRuBye/VtFFcc=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Ge9CD8oX6SODXlalPBH5yru6ZM5CACL9Zqxg58zw9POfmKNaCf/xzIPVjDaDtuL4+
	 PStlqEwUNTJ7dSTZyX2cX5JY10vFSR4sMmKGVoudxJ7Uk3vbX4n0ly80SobNYLvYym
	 H1rHkfdNRoE5FLKu37pdQ/NwmkMcKGnewHORnggI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2121F802BC;
	Tue, 10 Mar 2020 18:45:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EA8AF802BD; Tue, 10 Mar 2020 18:45:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C0D61F8029B
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 18:45:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0D61F8029B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43E68106F;
 Tue, 10 Mar 2020 10:45:08 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D843F67D;
 Tue, 10 Mar 2020 10:45:07 -0700 (PDT)
Date: Tue, 10 Mar 2020 17:45:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Applied "ASoC: Intel: Skylake: Remove superfluous chip
 initialization" to the asoc tree
In-Reply-To: <20200305145314.32579-2-cezary.rojewski@intel.com>
Message-Id: <applied-20200305145314.32579-2-cezary.rojewski@intel.com>
X-Patchwork-Hint: ignore
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org,
 Mark Brown <broonie@kernel.org>
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

The patch

   ASoC: Intel: Skylake: Remove superfluous chip initialization

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 2ef81057d80456870b97890dd79c8f56a85b1242 Mon Sep 17 00:00:00 2001
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Thu, 5 Mar 2020 15:53:08 +0100
Subject: [PATCH] ASoC: Intel: Skylake: Remove superfluous chip initialization

Skylake driver does the controller init operation twice:
- first during probe (only to stop it just before scheduling probe_work)
- and during said probe_work where the actual correct sequence is
executed

To properly complete boot sequence when iDisp codec is present, bus
initialization has to be called only after _i915_init() finishes.
With additional _reset_list preceding _i915_init(), iDisp codec never
gets the chance to enumerate on the link. Remove the superfluous
initialization to address the issue.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-2-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f755ca2484cf..d66231525356 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -803,6 +803,9 @@ static void skl_probe_work(struct work_struct *work)
 			return;
 	}
 
+	skl_init_pci(skl);
+	skl_dum_set(bus);
+
 	err = skl_init_chip(bus, true);
 	if (err < 0) {
 		dev_err(bus->dev, "Init chip failed with err: %d\n", err);
@@ -918,8 +921,6 @@ static int skl_first_init(struct hdac_bus *bus)
 		return -ENXIO;
 	}
 
-	snd_hdac_bus_reset_link(bus, true);
-
 	snd_hdac_bus_parse_capabilities(bus);
 
 	/* check if PPCAP exists */
@@ -967,11 +968,7 @@ static int skl_first_init(struct hdac_bus *bus)
 	if (err < 0)
 		return err;
 
-	/* initialize chip */
-	skl_init_pci(skl);
-	skl_dum_set(bus);
-
-	return skl_init_chip(bus, true);
+	return 0;
 }
 
 static int skl_probe(struct pci_dev *pci,
@@ -1064,8 +1061,6 @@ static int skl_probe(struct pci_dev *pci,
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
 
-	snd_hdac_bus_stop_chip(bus);
-
 	/* create device for soc dmic */
 	err = skl_dmic_device_register(skl);
 	if (err < 0) {
-- 
2.20.1

