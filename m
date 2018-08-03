From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: pci: Remove empty init and exit
Date: Fri,  3 Aug 2018 16:33:37 +0200
Message-ID: <20180803143338.5363-6-tiwai@suse.de>
References: <20180803143338.5363-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E1A72677CC
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 16:33:45 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 35B2DAF47
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 14:33:43 +0000 (UTC)
In-Reply-To: <20180803143338.5363-1-tiwai@suse.de>
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

For a sake of code simplification, remove the init and the exit
entries that do nothing.

Notes for readers: actually it's OK to remove *both* init and exit,
but not OK to remove the exit entry.  By removing only the exit while
keeping init, the module becomes permanently loaded; i.e. you cannot
unload it any longer!

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ac97/ac97_codec.c | 16 ----------------
 sound/pci/ice1712/ak4xxx.c  | 12 ------------
 2 files changed, 28 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 1ef7cdf1d3e8..f4459d1a9d67 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2941,19 +2941,3 @@ int snd_ac97_tune_hardware(struct snd_ac97 *ac97,
 }
 
 EXPORT_SYMBOL(snd_ac97_tune_hardware);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_ac97_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_ac97_exit(void)
-{
-}
-
-module_init(alsa_ac97_init)
-module_exit(alsa_ac97_exit)
diff --git a/sound/pci/ice1712/ak4xxx.c b/sound/pci/ice1712/ak4xxx.c
index 179ef7a5f0d1..a553897a4c4f 100644
--- a/sound/pci/ice1712/ak4xxx.c
+++ b/sound/pci/ice1712/ak4xxx.c
@@ -179,18 +179,6 @@ int snd_ice1712_akm4xxx_build_controls(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static int __init alsa_ice1712_akm4xxx_module_init(void)
-{
-	return 0;
-}
-        
-static void __exit alsa_ice1712_akm4xxx_module_exit(void)
-{
-}
-        
-module_init(alsa_ice1712_akm4xxx_module_init)
-module_exit(alsa_ice1712_akm4xxx_module_exit)
-
 EXPORT_SYMBOL(snd_ice1712_akm4xxx_init);
 EXPORT_SYMBOL(snd_ice1712_akm4xxx_free);
 EXPORT_SYMBOL(snd_ice1712_akm4xxx_build_controls);
-- 
2.18.0
