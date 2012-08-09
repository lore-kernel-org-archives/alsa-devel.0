From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH] ALSA: hda - Defer probe when loading patch
	firmware
Date: Thu,  9 Aug 2012 08:45:23 +0200
Message-ID: <1344494723-6827-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 45104265291
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 08:15:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Recent changes to the firmware loading helpers cause drivers to stall
when firmware is loaded during the module_init() call. The snd-hda-intel
module requests firmware if the patch= parameter is used to load a patch
file. This patch works around the problem by deferring the probe in such
cases, which will cause the module to load successfully and the driver
binding to the device outside the module_init() call.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 sound/pci/hda/hda_intel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c8aced1..296616e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -69,6 +69,7 @@ static int probe_only[SNDRV_CARDS];
 static bool single_cmd;
 static int enable_msi = -1;
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
+static bool deferred[SNDRV_CARDS];
 static char *patch[SNDRV_CARDS];
 #endif
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
@@ -3156,6 +3157,16 @@ static int __devinit azx_probe(struct pci_dev *pci,
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
+
+#ifdef CONFIG_SND_HDA_PATCH_LOADER
+	if (patch[dev] && *patch[dev] && !deferred[dev]) {
+		snd_printk(KERN_ERR SFX "deferring probe for patch %s\n",
+			   patch[dev]);
+		deferred[dev] = true;
+		return -EPROBE_DEFER;
+	}
+#endif
+
 	if (!enable[dev]) {
 		dev++;
 		return -ENOENT;
-- 
1.7.11.4
