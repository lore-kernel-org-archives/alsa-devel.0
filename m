From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: i2c: Remove empty init and exit
Date: Fri,  3 Aug 2018 16:33:36 +0200
Message-ID: <20180803143338.5363-5-tiwai@suse.de>
References: <20180803143338.5363-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CB1D2677B0
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 16:33:43 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 27E5FAE5F
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
 sound/i2c/cs8427.c            | 12 ------------
 sound/i2c/i2c.c               | 13 -------------
 sound/i2c/other/ak4xxx-adda.c | 12 ------------
 sound/i2c/tea6330t.c          | 16 ----------------
 4 files changed, 53 deletions(-)

diff --git a/sound/i2c/cs8427.c b/sound/i2c/cs8427.c
index 7e21621e492a..2647309bc675 100644
--- a/sound/i2c/cs8427.c
+++ b/sound/i2c/cs8427.c
@@ -621,15 +621,3 @@ int snd_cs8427_iec958_pcm(struct snd_i2c_device *cs8427, unsigned int rate)
 }
 
 EXPORT_SYMBOL(snd_cs8427_iec958_pcm);
-
-static int __init alsa_cs8427_module_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_cs8427_module_exit(void)
-{
-}
-
-module_init(alsa_cs8427_module_init)
-module_exit(alsa_cs8427_module_exit)
diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
index ef2a9afe9e19..c4a232f18a79 100644
--- a/sound/i2c/i2c.c
+++ b/sound/i2c/i2c.c
@@ -338,16 +338,3 @@ static int snd_i2c_bit_probeaddr(struct snd_i2c_bus *bus, unsigned short addr)
 	snd_i2c_bit_stop(bus);
 	return err;
 }
-
-
-static int __init alsa_i2c_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_i2c_exit(void)
-{
-}
-
-module_init(alsa_i2c_init)
-module_exit(alsa_i2c_exit)
diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index bf377dc192aa..7f2761a2e7c8 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -911,15 +911,3 @@ int snd_akm4xxx_build_controls(struct snd_akm4xxx *ak)
 	return 0;
 }
 EXPORT_SYMBOL(snd_akm4xxx_build_controls);
-
-static int __init alsa_akm4xxx_module_init(void)
-{
-	return 0;
-}
-        
-static void __exit alsa_akm4xxx_module_exit(void)
-{
-}
-        
-module_init(alsa_akm4xxx_module_init)
-module_exit(alsa_akm4xxx_module_exit)
diff --git a/sound/i2c/tea6330t.c b/sound/i2c/tea6330t.c
index 2d22310dce05..239c4822427f 100644
--- a/sound/i2c/tea6330t.c
+++ b/sound/i2c/tea6330t.c
@@ -368,19 +368,3 @@ int snd_tea6330t_update_mixer(struct snd_card *card,
 
 EXPORT_SYMBOL(snd_tea6330t_detect);
 EXPORT_SYMBOL(snd_tea6330t_update_mixer);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_tea6330t_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_tea6330t_exit(void)
-{
-}
-
-module_init(alsa_tea6330t_init)
-module_exit(alsa_tea6330t_exit)
-- 
2.18.0
