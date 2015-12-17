From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: hda - Drop unused
	AZX_DCAPS_REVERSE_ASSIGN
Date: Thu, 17 Dec 2015 08:35:46 +0100
Message-ID: <1450337746-4580-5-git-send-email-tiwai@suse.de>
References: <1450337746-4580-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C66CF2654EA
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 08:35:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8580CAB13
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 07:35:44 +0000 (UTC)
In-Reply-To: <1450337746-4580-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AZX_DCAPS_REVERSE_ASSIGN is no longer referred by any code.
Let's drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.h | 2 +-
 sound/pci/hda/hda_intel.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index a288ac1b5451..ec63bbf1ec6d 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -43,7 +43,7 @@
 #define AZX_DCAPS_NO_ALIGN_BUFSIZE (1 << 21)	/* no buffer size alignment */
 /* 22 unused */
 #define AZX_DCAPS_4K_BDLE_BOUNDARY (1 << 23)	/* BDLE in 4k boundary */
-#define AZX_DCAPS_REVERSE_ASSIGN (1 << 24)	/* Assign devices in reverse order */
+/* 24 unused */
 #define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)	/* Take LPIB as delay */
 #define AZX_DCAPS_PM_RUNTIME	(1 << 26)	/* runtime PM support */
 #ifdef CONFIG_SND_HDA_I915
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 67e672a77576..1465f6a0e010 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -286,7 +286,7 @@ enum {
 /* quirks for Intel PCH */
 #define AZX_DCAPS_INTEL_PCH_BASE \
 	(AZX_DCAPS_NO_ALIGN_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
-	 AZX_DCAPS_REVERSE_ASSIGN | AZX_DCAPS_SNOOP_TYPE(SCH))
+	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 /* PCH up to IVB; no runtime PM */
 #define AZX_DCAPS_INTEL_PCH_NOPM \
-- 
2.6.4
