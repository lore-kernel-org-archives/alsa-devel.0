From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda - Remove superfluous inclusion
	of linux/pci.h
Date: Sat, 15 Feb 2014 10:17:35 +0100
Message-ID: <1392455855-10594-3-git-send-email-tiwai@suse.de>
References: <1392455855-10594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 55BD92618F2
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 10:17:36 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D03DAABA6
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 09:17:35 +0000 (UTC)
In-Reply-To: <1392455855-10594-1-git-send-email-tiwai@suse.de>
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

Some codec drivers still have it since using PCI_VENDOR_ID_*.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 1 -
 sound/pci/hda/hda_hwdep.c      | 1 -
 sound/pci/hda/patch_analog.c   | 1 -
 sound/pci/hda/patch_ca0110.c   | 1 -
 sound/pci/hda/patch_ca0132.c   | 1 -
 sound/pci/hda/patch_cirrus.c   | 1 -
 sound/pci/hda/patch_cmedia.c   | 1 -
 sound/pci/hda/patch_conexant.c | 1 -
 8 files changed, 8 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index dafcf82139e2..4be322b0d745 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/async.h>
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 72d8389fb399..53c961992d0c 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -20,7 +20,6 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/compat.h>
 #include <linux/mutex.h>
 #include <linux/ctype.h>
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index df3652ad15ef..1eb00a6d3ef5 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -21,7 +21,6 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/module.h>
 
 #include <sound/core.h>
diff --git a/sound/pci/hda/patch_ca0110.c b/sound/pci/hda/patch_ca0110.c
index 30b3a4bc06ee..5e65999e0d8e 100644
--- a/sound/pci/hda/patch_ca0110.c
+++ b/sound/pci/hda/patch_ca0110.c
@@ -20,7 +20,6 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include "hda_codec.h"
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 54d14793725a..4c5132cdb0cf 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index fc492ac24caa..387f0b551889 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -20,7 +20,6 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index 139ef301c914..d782292b1ba9 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -23,7 +23,6 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include "hda_codec.h"
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 59e3aeac2233..13a416060eb8 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/jack.h>
-- 
1.8.5.2
