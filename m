From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/10] ALSA: ca0106: Fix/cleanup ifdef
	CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:07 +0200
Message-ID: <1432879571-3359-7-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 88CBF2666D8
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2E687AD3B
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:06:14 +0000 (UTC)
In-Reply-To: <1432879571-3359-1-git-send-email-tiwai@suse.de>
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

Build ca0106_proc.o conditionally to drop unneeded ifdef.
Some are replaced with the new CONFIG_SND_PROC_FS.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ca0106/Makefile      | 3 ++-
 sound/pci/ca0106/ca0106_main.c | 2 +-
 sound/pci/ca0106/ca0106_proc.c | 4 ----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/pci/ca0106/Makefile b/sound/pci/ca0106/Makefile
index dcbae7b31546..c1455fc5588c 100644
--- a/sound/pci/ca0106/Makefile
+++ b/sound/pci/ca0106/Makefile
@@ -1,3 +1,4 @@
-snd-ca0106-objs := ca0106_main.o ca0106_proc.o ca0106_mixer.o ca_midi.o
+snd-ca0106-objs := ca0106_main.o ca0106_mixer.o ca_midi.o
+snd-ca0106-$(CONFIG_SND_PROC_FS) += ca0106_proc.o
 
 obj-$(CONFIG_SND_CA0106) += snd-ca0106.o
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 0b31732eb4dc..d3cd95633ee2 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1885,7 +1885,7 @@ static int snd_ca0106_probe(struct pci_dev *pci,
 		goto error;
 	dev_dbg(card->dev, " done.\n");
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	snd_ca0106_proc_init(chip);
 #endif
 
diff --git a/sound/pci/ca0106/ca0106_proc.c b/sound/pci/ca0106/ca0106_proc.c
index 2c5c28adbefd..9b2b8b38122f 100644
--- a/sound/pci/ca0106/ca0106_proc.c
+++ b/sound/pci/ca0106/ca0106_proc.c
@@ -75,8 +75,6 @@
 #include "ca0106.h"
 
 
-#ifdef CONFIG_PROC_FS
-
 struct snd_ca0106_category_str {
 	int val;
 	const char *name;
@@ -453,5 +451,3 @@ int snd_ca0106_proc_init(struct snd_ca0106 *emu)
 		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read2);
 	return 0;
 }
-
-#endif /* CONFIG_PROC_FS */
-- 
2.4.2
