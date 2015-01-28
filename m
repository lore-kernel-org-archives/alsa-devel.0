From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: Include linux/uaccess.h and
	linux/bitopts.h instead of asm/*
Date: Wed, 28 Jan 2015 17:37:44 +0100
Message-ID: <1422463066-18969-3-git-send-email-tiwai@suse.de>
References: <1422463066-18969-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C609261B11
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:37:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2588EADE5
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 16:37:48 +0000 (UTC)
In-Reply-To: <1422463066-18969-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memory.c           | 2 +-
 sound/drivers/pcsp/pcsp.c     | 2 +-
 sound/isa/sb/emu8000.c        | 2 +-
 sound/isa/sb/emu8000_patch.c  | 2 +-
 sound/pci/asihpi/hpioctl.c    | 2 +-
 sound/synth/emux/emux_hwdep.c | 2 +-
 sound/synth/emux/emux_oss.c   | 2 +-
 sound/synth/emux/soundfont.c  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/core/memory.c b/sound/core/memory.c
index ca775d7589db..4cd664efad77 100644
--- a/sound/core/memory.c
+++ b/sound/core/memory.c
@@ -22,7 +22,7 @@
 
 #include <linux/export.h>
 #include <linux/io.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <sound/core.h>
 
 /**
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 2adc7548ffca..d9647bd84d0f 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -13,7 +13,7 @@
 #include <sound/pcm.h>
 #include <linux/input.h>
 #include <linux/delay.h>
-#include <asm/bitops.h>
+#include <linux/bitops.h>
 #include "pcsp_input.h"
 #include "pcsp.h"
 
diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index 1449354a23fe..94c411299e5a 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -30,7 +30,7 @@
 #include <sound/core.h>
 #include <sound/emu8000.h>
 #include <sound/emu8000_reg.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/init.h>
 #include <sound/control.h>
 #include <sound/initval.h>
diff --git a/sound/isa/sb/emu8000_patch.c b/sound/isa/sb/emu8000_patch.c
index c99c6078be33..71d13c0bb746 100644
--- a/sound/isa/sb/emu8000_patch.c
+++ b/sound/isa/sb/emu8000_patch.c
@@ -20,7 +20,7 @@
  */
 
 #include "emu8000_local.h"
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/moduleparam.h>
 
 static int emu8000_reset_addr;
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 67d113356971..6610bd096fc9 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -28,7 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/pci.h>
 #include <linux/stringify.h>
 #include <linux/module.h>
diff --git a/sound/synth/emux/emux_hwdep.c b/sound/synth/emux/emux_hwdep.c
index 5ae1eae9f6db..e557946718a9 100644
--- a/sound/synth/emux/emux_hwdep.c
+++ b/sound/synth/emux/emux_hwdep.c
@@ -21,7 +21,7 @@
 
 #include <sound/core.h>
 #include <sound/hwdep.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include "emux_voice.h"
 
 
diff --git a/sound/synth/emux/emux_oss.c b/sound/synth/emux/emux_oss.c
index 319754cf6208..ab37add269ae 100644
--- a/sound/synth/emux/emux_oss.c
+++ b/sound/synth/emux/emux_oss.c
@@ -26,7 +26,7 @@
 #ifdef CONFIG_SND_SEQUENCER_OSS
 
 #include <linux/export.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <sound/core.h>
 #include "emux_voice.h"
 #include <sound/asoundef.h>
diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index 78683b2064f7..31a4ea94830e 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -25,7 +25,7 @@
  * of doing things so that the old sfxload utility can be used.
  * Everything may change when there is an alsa way of doing things.
  */
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <sound/core.h>
-- 
2.2.2
