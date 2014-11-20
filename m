From: eliot@blennerhassett.gen.nz
Subject: [PATCH 01/10] ALSA: asihpi: Minor string and dead code
	cleanup
Date: Thu, 20 Nov 2014 16:22:48 +1300
Message-ID: <1416453777-7155-2-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 387DF26584E
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:41 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp3.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB007V7IU4ZE20@smtp3.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:34 +1300 (NZDT)
In-reply-to: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/asihpi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index ac66b32..023d816 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -28,7 +28,6 @@
 #include "hpioctl.h"
 #include "hpicmn.h"
 
-
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
@@ -47,7 +46,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AudioScience inc. <support@audioscience.com>");
-MODULE_DESCRIPTION("AudioScience ALSA ASI5000 ASI6000 ASI87xx ASI89xx "
+MODULE_DESCRIPTION("AudioScience ALSA ASI5xxx ASI6xxx ASI87xx ASI89xx "
 			HPI_VER_STRING);
 
 #if defined CONFIG_SND_DEBUG_VERBOSE
@@ -87,11 +86,11 @@ MODULE_PARM_DESC(enable_hpi_hwdep,
 #ifdef KERNEL_ALSA_BUILD
 static char *build_info = "Built using headers from kernel source";
 module_param(build_info, charp, S_IRUGO);
-MODULE_PARM_DESC(build_info, "built using headers from kernel source");
+MODULE_PARM_DESC(build_info, "Built using headers from kernel source");
 #else
 static char *build_info = "Built within ALSA source";
 module_param(build_info, charp, S_IRUGO);
-MODULE_PARM_DESC(build_info, "built within ALSA source");
+MODULE_PARM_DESC(build_info, "Built within ALSA source");
 #endif
 
 /* set to 1 to dump every control from adapter to log */
@@ -538,7 +537,7 @@ static void snd_card_asihpi_pcm_timer_start(struct snd_pcm_substream *
 	int expiry;
 
 	expiry = HZ / 200;
-	/*? (dpcm->period_bytes * HZ / dpcm->bytes_per_sec); */
+
 	expiry = max(expiry, 1); /* don't let it be zero! */
 	dpcm->timer.expires = jiffies + expiry;
 	dpcm->respawn_timer = 1;
@@ -2935,10 +2934,6 @@ static struct pci_driver driver = {
 	.id_table = asihpi_pci_tbl,
 	.probe = snd_asihpi_probe,
 	.remove = snd_asihpi_remove,
-#ifdef CONFIG_PM_SLEEP
-/*	.suspend = snd_asihpi_suspend,
-	.resume = snd_asihpi_resume, */
-#endif
 };
 
 static int __init snd_asihpi_init(void)
-- 
1.9.1
