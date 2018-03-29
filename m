From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] ALSA: hda - Silence PM ops build warning
Date: Thu, 29 Mar 2018 13:46:26 +0200
Message-ID: <b8e70e34a9acbd4f0a1a6c7673cea96888ae9503.1522323444.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.90.233])
 by alsa0.perex.cz (Postfix) with ESMTP id 37D15266F69
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 13:46:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The system sleep PM ops azx_suspend() and azx_resume() were previously
called by vga_switcheroo, but commit 07f4f97d7b4b ("vga_switcheroo: Use
device link for HDA controller") removed their invocation.

Unfortunately the commit neglected to update the #ifdef surrounding the
two functions, so if CONFIG_PM_SLEEP is *not* enabled but all three of
CONFIG_PM, CONFIG_VGA_SWITCHEROO and CONFIG_SND_HDA_CODEC_HDMI *are*
enabled, the compiler now emits the following warning:

sound/pci/hda/hda_intel.c:1024:12: warning: 'azx_resume' defined but not used [-Wunused-function]
 static int azx_resume(struct device *dev)
            ^~~~~~~~~~
sound/pci/hda/hda_intel.c:989:12: warning: 'azx_suspend' defined but not used [-Wunused-function]
 static int azx_suspend(struct device *dev)
            ^~~~~~~~~~~

Silence by updating the #ifdef.  Because the #ifdef block now uses the
same condition as the one immediately succeeding it, the two blocks can
be collapsed together, shaving off another two lines.

Fixes: 07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
Cc: Takashi Iwai <tiwai@suse.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 sound/pci/hda/hda_intel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ec4e6b829ee2..d653c56e9141 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -982,7 +982,7 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 #define azx_del_card_list(chip) /* NOP */
 #endif /* CONFIG_PM */
 
-#if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
+#ifdef CONFIG_PM_SLEEP
 /*
  * power management
  */
@@ -1063,9 +1063,7 @@ static int azx_resume(struct device *dev)
 	trace_azx_resume(chip);
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP || SUPPORT_VGA_SWITCHEROO */
 
-#ifdef CONFIG_PM_SLEEP
 /* put codec down to D3 at hibernation for Intel SKL+;
  * otherwise BIOS may still access the codec and screw up the driver
  */
-- 
2.16.2
