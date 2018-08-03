From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: drivers: Remove empty init and exit
Date: Fri,  3 Aug 2018 16:33:34 +0200
Message-ID: <20180803143338.5363-3-tiwai@suse.de>
References: <20180803143338.5363-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E0EF2677B5
 for <alsa-devel@alsa-project.org>; Fri,  3 Aug 2018 16:33:43 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0DEF6AD8D
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
 sound/drivers/mpu401/mpu401_uart.c | 16 ----------------
 sound/drivers/opl3/opl3_lib.c      | 16 ----------------
 sound/drivers/opl4/opl4_lib.c      | 12 ------------
 sound/drivers/vx/vx_core.c         | 15 ---------------
 4 files changed, 59 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 3e745f47dd2f..dae26e856b26 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -617,19 +617,3 @@ int snd_mpu401_uart_new(struct snd_card *card, int device,
 }
 
 EXPORT_SYMBOL(snd_mpu401_uart_new);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_mpu401_uart_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_mpu401_uart_exit(void)
-{
-}
-
-module_init(alsa_mpu401_uart_init)
-module_exit(alsa_mpu401_uart_exit)
diff --git a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
index 1a5355b747ec..cf86c36c7c3b 100644
--- a/sound/drivers/opl3/opl3_lib.c
+++ b/sound/drivers/opl3/opl3_lib.c
@@ -538,19 +538,3 @@ int snd_opl3_hwdep_new(struct snd_opl3 * opl3,
 }
 
 EXPORT_SYMBOL(snd_opl3_hwdep_new);
-
-/*
- *  INIT part
- */
-
-static int __init alsa_opl3_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_opl3_exit(void)
-{
-}
-
-module_init(alsa_opl3_init)
-module_exit(alsa_opl3_exit)
diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index db76a5bf2bd2..819d2dce2a19 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -263,15 +263,3 @@ int snd_opl4_create(struct snd_card *card,
 }
 
 EXPORT_SYMBOL(snd_opl4_create);
-
-static int __init alsa_opl4_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_opl4_exit(void)
-{
-}
-
-module_init(alsa_opl4_init)
-module_exit(alsa_opl4_exit)
diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index 121357397a6d..04368dd59a4c 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -815,18 +815,3 @@ struct vx_core *snd_vx_create(struct snd_card *card, struct snd_vx_hardware *hw,
 }
 
 EXPORT_SYMBOL(snd_vx_create);
-
-/*
- * module entries
- */
-static int __init alsa_vx_core_init(void)
-{
-	return 0;
-}
-
-static void __exit alsa_vx_core_exit(void)
-{
-}
-
-module_init(alsa_vx_core_init)
-module_exit(alsa_vx_core_exit)
-- 
2.18.0
