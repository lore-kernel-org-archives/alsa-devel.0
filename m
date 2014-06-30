From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ALSA: hda - Remove obsoleted SFX
	definitions
Date: Mon, 30 Jun 2014 14:21:01 +0200
Message-ID: <1404130862-3152-7-git-send-email-tiwai@suse.de>
References: <1404130862-3152-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D2DA12655AA
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 14:21:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B418DACE0
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:21:05 +0000 (UTC)
In-Reply-To: <1404130862-3152-1-git-send-email-tiwai@suse.de>
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

It's no longer referred by anyone after standardizing with dev_*()
macros.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 2 --
 sound/pci/hda/hda_priv.h        | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index dabe41975a9d..a9790198aa17 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -17,8 +17,6 @@
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 
-#define SFX	"hda_codec: "
-
 /*
  * Helper for automatic pin configuration
  */
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 0688aaff09f1..da2d3a41f8f3 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -358,12 +358,6 @@ struct azx {
 #endif
 };
 
-#ifdef CONFIG_SND_VERBOSE_PRINTK
-#define SFX	/* nop */
-#else
-#define SFX	"hda-intel "
-#endif
-
 #ifdef CONFIG_X86
 #define azx_snoop(chip)		((chip)->snoop)
 #else
-- 
2.0.0
