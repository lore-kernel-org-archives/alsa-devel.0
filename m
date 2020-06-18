Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835EAC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:41:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F8C2083B
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MtWJUcPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F8C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 621111790;
	Thu, 18 Jun 2020 16:41:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 621111790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592491312;
	bh=gf/ufkqNZkMrOXQZMd7wJpSC5ZT5K2rDC9VxwYk7PHk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MtWJUcPciSfB4Dz91xMo2VFH7m4U9s8vXeZrZOz9FtRetKQdNBZtr0BTPn3IvNeLq
	 sACqWVtZ3YLAPZPqdfFOj+FYIN/Xp8bdOT6VkBYHfwUBYVAnt/alzP0ZmHyw7n3FOY
	 MRb2Bf+xF7uhfJE+ZHkGgB+Le/wGvT/Jfe7JIESI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFA5FF80101;
	Thu, 18 Jun 2020 16:41:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FF5BF80171; Thu, 18 Jun 2020 16:41:00 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20B35F80101
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 16:40:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20B35F80101
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4C636AD25
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 14:40:52 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Enable sync-write operation as default for all
 controllers
Date: Thu, 18 Jun 2020 16:40:51 +0200
Message-Id: <20200618144051.7415-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

In the end we already enabled the sync-write mode for most of HD-audio
controllers including Intel, and it's no big merit to keep the async
write mode for the rest.  Let's make it as default and drop the
superfluous AZX_DCAPS_SYNC_WRITE bit flag.

Also, avoid to set the allow_bus_reset flag, which is a quite unstable
and hackish behavior that was needed only for some early platforms
(decades ago).  The straight fallback to the single cmd mode is more
robust.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 11 ++---------
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 16 +++++++---------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 9765652a73d7..80016b7b6849 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1202,15 +1202,8 @@ int azx_bus_init(struct azx *chip, const char *model)
 	if (chip->driver_caps & AZX_DCAPS_4K_BDLE_BOUNDARY)
 		bus->core.align_bdle_4k = true;
 
-	/* AMD chipsets often cause the communication stalls upon certain
-	 * sequence like the pin-detection.  It seems that forcing the synced
-	 * access works around the stall.  Grrr...
-	 */
-	if (chip->driver_caps & AZX_DCAPS_SYNC_WRITE) {
-		dev_dbg(chip->card->dev, "Enable sync_write for stable communication\n");
-		bus->core.sync_write = 1;
-		bus->allow_bus_reset = 1;
-	}
+	/* enable sync_write flag for stable communication as default */
+	bus->core.sync_write = 1;
 
 	return 0;
 }
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 82e26442724b..fe171685492d 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -33,7 +33,7 @@
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
 #define AZX_DCAPS_AMD_WORKAROUND (1 << 17)	/* AMD-specific workaround */
 #define AZX_DCAPS_NO_64BIT	(1 << 18)	/* No 64bit address */
-#define AZX_DCAPS_SYNC_WRITE	(1 << 19)	/* sync each cmd write */
+/* 19 unused */
 #define AZX_DCAPS_OLD_SSYNC	(1 << 20)	/* Old SSYNC reg for ICH */
 #define AZX_DCAPS_NO_ALIGN_BUFSIZE (1 << 21)	/* no buffer size alignment */
 /* 22 unused */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3565e2ab0965..b2bd21f5a52e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -283,13 +283,12 @@ enum {
 
 /* quirks for old Intel chipsets */
 #define AZX_DCAPS_INTEL_ICH \
-	(AZX_DCAPS_OLD_SSYNC | AZX_DCAPS_NO_ALIGN_BUFSIZE |\
-	 AZX_DCAPS_SYNC_WRITE)
+	(AZX_DCAPS_OLD_SSYNC | AZX_DCAPS_NO_ALIGN_BUFSIZE)
 
 /* quirks for Intel PCH */
 #define AZX_DCAPS_INTEL_PCH_BASE \
 	(AZX_DCAPS_NO_ALIGN_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
-	 AZX_DCAPS_SNOOP_TYPE(SCH) | AZX_DCAPS_SYNC_WRITE)
+	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 /* PCH up to IVB; no runtime PM; bind with i915 gfx */
 #define AZX_DCAPS_INTEL_PCH_NOPM \
@@ -304,13 +303,13 @@ enum {
 #define AZX_DCAPS_INTEL_HASWELL \
 	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_COUNT_LPIB_DELAY |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_COMPONENT |\
-	 AZX_DCAPS_SNOOP_TYPE(SCH) | AZX_DCAPS_SYNC_WRITE)
+	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 /* Broadwell HDMI can't use position buffer reliably, force to use LPIB */
 #define AZX_DCAPS_INTEL_BROADWELL \
 	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_POSFIX_LPIB |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_COMPONENT |\
-	 AZX_DCAPS_SNOOP_TYPE(SCH) | AZX_DCAPS_SYNC_WRITE)
+	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 #define AZX_DCAPS_INTEL_BAYTRAIL \
 	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_I915_COMPONENT)
@@ -321,19 +320,18 @@ enum {
 
 #define AZX_DCAPS_INTEL_SKYLAKE \
 	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME |\
-	 AZX_DCAPS_SYNC_WRITE |\
 	 AZX_DCAPS_SEPARATE_STREAM_TAG | AZX_DCAPS_I915_COMPONENT)
 
 #define AZX_DCAPS_INTEL_BROXTON		AZX_DCAPS_INTEL_SKYLAKE
 
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
-	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB |\
+	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_POSFIX_LPIB |\
 	 AZX_DCAPS_SNOOP_TYPE(ATI))
 
 /* quirks for ATI/AMD HDMI */
 #define AZX_DCAPS_PRESET_ATI_HDMI \
-	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
+	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_POSFIX_LPIB|\
 	 AZX_DCAPS_NO_MSI64)
 
 /* quirks for ATI HDMI with snoop off */
@@ -342,7 +340,7 @@ enum {
 
 /* quirks for AMD SB */
 #define AZX_DCAPS_PRESET_AMD_SB \
-	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_AMD_WORKAROUND |\
+	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_AMD_WORKAROUND |\
 	 AZX_DCAPS_SNOOP_TYPE(ATI) | AZX_DCAPS_PM_RUNTIME)
 
 /* quirks for Nvidia */
-- 
2.25.0

