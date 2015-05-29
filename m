From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ALSA: ac97: Fix ifdef CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:06 +0200
Message-ID: <1432879571-3359-6-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A00E2666D5
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 26AD8AD33
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

Replaced with the new CONFIG_SND_PROC_FS.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ac97/Makefile     | 2 +-
 sound/pci/ac97/ac97_local.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ac97/Makefile b/sound/pci/ac97/Makefile
index 41fa322f0971..526175333710 100644
--- a/sound/pci/ac97/Makefile
+++ b/sound/pci/ac97/Makefile
@@ -4,7 +4,7 @@
 #
 
 snd-ac97-codec-y := ac97_codec.o ac97_pcm.o
-snd-ac97-codec-$(CONFIG_PROC_FS) += ac97_proc.o
+snd-ac97-codec-$(CONFIG_SND_PROC_FS) += ac97_proc.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AC97_CODEC) += snd-ac97-codec.o
diff --git a/sound/pci/ac97/ac97_local.h b/sound/pci/ac97/ac97_local.h
index c276a5e3f7ac..941a5062cc20 100644
--- a/sound/pci/ac97/ac97_local.h
+++ b/sound/pci/ac97/ac97_local.h
@@ -28,7 +28,7 @@ int snd_ac97_update_bits_nolock(struct snd_ac97 *ac97, unsigned short reg,
 				unsigned short mask, unsigned short value);
 
 /* ac97_proc.c */
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 void snd_ac97_bus_proc_init(struct snd_ac97_bus * ac97);
 void snd_ac97_bus_proc_done(struct snd_ac97_bus * ac97);
 void snd_ac97_proc_init(struct snd_ac97 * ac97);
-- 
2.4.2
