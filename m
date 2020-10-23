Return-Path: <SRS0=Lvkp=D6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5134C388F9
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:25:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A7320EDD
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c5/wVbZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A7320EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A09481815;
	Fri, 23 Oct 2020 12:24:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A09481815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603448747;
	bh=j1ec91HJlQ66XEbCY/J9ZkxJUOmXGXnHPIGN8fxmI14=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5/wVbZE4BwPf00WMTpjFyoO9ALYdNxXJ3ps0thzEeirHAnUxuKjBx3l3gwhzYIo/
	 sMIKazZGIiqIXtoztO/MKwQArSjZ2pb+Ao0yu4dzWHEDmU4j8RvvDwVbNF8ArWJBt9
	 unMx2ps8HOMFwBjxGrD6VNpb73aAup+UrNoEXxK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62A53F8026F;
	Fri, 23 Oct 2020 12:24:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5BA73F80279; Fri, 23 Oct 2020 12:24:09 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63F6BF80253
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2020 12:24:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63F6BF80253
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1kVuEn-0006Rd-CU; Fri, 23 Oct 2020 10:23:57 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Subject: [PATCH 3/4] ALSA: hda: Refactor controller PM to use direct-complete
 optimization
Date: Fri, 23 Oct 2020 18:23:37 +0800
Message-Id: <20201023102340.25494-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023102340.25494-1-kai.heng.feng@canonical.com>
References: <20201023102340.25494-1-kai.heng.feng@canonical.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Alex Deucher <alexander.deucher@amd.com>
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

Similar to codec, we can use direct-complete optimization to keep HDA
controller suspended if conditions are met.

For most integrated HDA controllers, direct-complete won't happen because
ACPI wakeup is enabled for runtime suspend, but wakeup needs to be
disabled for system suspend.

For most HDA controller in discrete graphics, they will stay suspended
through system PM.

Note that HDA controllers don't need to use a complete() callback.
Codecs will decide if resume is needed.

While at it, also remove AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP, as the
original bug commit a6630529aecb ("ALSA: hda: Workaround for spurious
wakeups on some Intel platforms") solves doesn't happen with this
patch.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 39 ++++++++++++----------------------
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index be63ead8161f..fe171685492d 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -41,7 +41,7 @@
 /* 24 unused */
 #define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)	/* Take LPIB as delay */
 #define AZX_DCAPS_PM_RUNTIME	(1 << 26)	/* runtime PM support */
-#define AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP (1 << 27) /* Workaround for spurious wakeups after suspend */
+/* 27 unused */
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 #define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 #define AZX_DCAPS_SEPARATE_STREAM_TAG	(1 << 30) /* capture and playback use separate stream tag */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b4aa1dcf1aae..14d935d8805f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -297,8 +297,7 @@ enum {
 /* PCH for HSW/BDW; with runtime PM */
 /* no i915 binding for this as HSW/BDW has another controller for HDMI */
 #define AZX_DCAPS_INTEL_PCH \
-	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME |\
-	 AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
+	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME)
 
 /* HSW HDMI */
 #define AZX_DCAPS_INTEL_HASWELL \
@@ -1018,6 +1017,11 @@ static void __azx_runtime_resume(struct azx *chip, bool from_rt)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int azx_prepare(struct device *dev)
+{
+	return pm_runtime_suspended(dev);
+}
+
 static int azx_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
@@ -1028,14 +1032,7 @@ static int azx_suspend(struct device *dev)
 
 	chip = card->private_data;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	/* An ugly workaround: direct call of __azx_runtime_suspend() and
-	 * __azx_runtime_resume() for old Intel platforms that suffer from
-	 * spurious wakeups after S3 suspend
-	 */
-	if (chip->driver_caps & AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
-		__azx_runtime_suspend(chip);
-	else
-		pm_runtime_force_suspend(dev);
+	__azx_runtime_suspend(chip);
 
 	trace_azx_suspend(chip);
 	return 0;
@@ -1050,11 +1047,7 @@ static int azx_resume(struct device *dev)
 		return 0;
 
 	chip = card->private_data;
-
-	if (chip->driver_caps & AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
-		__azx_runtime_resume(chip, false);
-	else
-		pm_runtime_force_resume(dev);
+	__azx_runtime_resume(chip, false);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 
 	trace_azx_resume(chip);
@@ -1103,10 +1096,8 @@ static int azx_runtime_suspend(struct device *dev)
 	chip = card->private_data;
 
 	/* enable controller wake up event */
-	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0) {
-		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
-			   STATESTS_INT_MASK);
-	}
+	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
+		   STATESTS_INT_MASK);
 
 	__azx_runtime_suspend(chip);
 	trace_azx_runtime_suspend(chip);
@@ -1117,18 +1108,15 @@ static int azx_runtime_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
-	bool from_rt = snd_power_get_state(card) == SNDRV_CTL_POWER_D0;
 
 	if (!azx_is_pm_ready(card))
 		return 0;
 	chip = card->private_data;
-	__azx_runtime_resume(chip, from_rt);
+	__azx_runtime_resume(chip, true);
 
 	/* disable controller Wake Up event*/
-	if (from_rt) {
-		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
-			   ~STATESTS_INT_MASK);
-	}
+	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
+		   ~STATESTS_INT_MASK);
 
 	trace_azx_runtime_resume(chip);
 	return 0;
@@ -1160,6 +1148,7 @@ static int azx_runtime_idle(struct device *dev)
 }
 
 static const struct dev_pm_ops azx_pm = {
+	.prepare = azx_prepare,
 	SET_SYSTEM_SLEEP_PM_OPS(azx_suspend, azx_resume)
 #ifdef CONFIG_PM_SLEEP
 	.freeze_noirq = azx_freeze_noirq,
-- 
2.17.1

