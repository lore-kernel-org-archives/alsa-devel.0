From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/12] ALSA: hda - Remove superfluous header
	inclusions
Date: Mon, 21 Jan 2013 17:06:14 +0100
Message-ID: <1358784377-26102-10-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 93633262600
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 02863A51F5
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
In-Reply-To: <1358784377-26102-1-git-send-email-tiwai@suse.de>
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
 sound/pci/hda/patch_analog.c   | 1 -
 sound/pci/hda/patch_ca0110.c   | 1 -
 sound/pci/hda/patch_cirrus.c   | 1 -
 sound/pci/hda/patch_cmedia.c   | 1 -
 sound/pci/hda/patch_realtek.c  | 1 -
 sound/pci/hda/patch_sigmatel.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 6feaec4..162bc2f 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/module.h>
diff --git a/sound/pci/hda/patch_ca0110.c b/sound/pci/hda/patch_ca0110.c
index db7635c..30b3a4b 100644
--- a/sound/pci/hda/patch_ca0110.c
+++ b/sound/pci/hda/patch_ca0110.c
@@ -19,7 +19,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/module.h>
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index b9dfbd8..72ebb8a 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -19,7 +19,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/module.h>
diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index 087cabb..9c6ce73 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/module.h>
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 79ff34d..6eb9551 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -29,7 +29,6 @@
 #include <linux/pci.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
-#include <linux/sort.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include "hda_codec.h"
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index fe3e082..fd29f49 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -31,7 +31,6 @@
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <sound/core.h>
-#include <sound/asoundef.h>
 #include <sound/jack.h>
 #include <sound/tlv.h>
 #include "hda_codec.h"
-- 
1.8.1.1
