From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC_VREF_EVENT value change
Date: Fri, 14 Nov 2008 17:46:22 -0500
Message-ID: <491DFFBE.3060909@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 161DC103817
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 23:46:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Changed value for STAC_VREF_EVENT from 0x40 to 0x00 because the
unsol response value is only 6-bits width and the former value
was 1<<6 which is an overrun.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index ec8f5ab..86e5cd9 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -36,10 +36,10 @@
 #include "hda_patch.h"
 #include "hda_beep.h"

+#define STAC_VREF_EVENT		0x00
 #define STAC_INSERT_EVENT	0x10
 #define STAC_PWR_EVENT		0x20
 #define STAC_HP_EVENT		0x30
-#define STAC_VREF_EVENT		0x40

 enum {
 	STAC_REF,
