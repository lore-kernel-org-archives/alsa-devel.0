From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Allow power_save_controller option
	override DCAPS
Date: Tue, 15 Jan 2013 14:59:42 +0100
Message-ID: <1358258382-6515-3-git-send-email-tiwai@suse.de>
References: <1358258382-6515-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2704126163B
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 14:59:44 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 6898BA51F5
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 14:59:43 +0100 (CET)
In-Reply-To: <1358258382-6515-1-git-send-email-tiwai@suse.de>
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

Change the power_save_controller option to bint from bool so that user
can override the runtime PM capability bit and force to enable or
disable the runtime PM.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/ALSA-Configuration.txt | 5 +++--
 sound/pci/hda/hda_intel.c                       | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index b9cfd33..ce6581c 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -890,8 +890,9 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
     enable_msi	- Enable Message Signaled Interrupt (MSI) (default = off)
     power_save	- Automatic power-saving timeout (in second, 0 =
 		disable)
-    power_save_controller - Reset HD-audio controller in power-saving mode
-		(default = on)
+    power_save_controller - Support runtime D3 of HD-audio controller
+		(-1 = on for supported chip (default), false = off,
+		 true = force to on even for unsupported hardware)
     align_buffer_size - Force rounding of buffer/period sizes to multiples
     		      of 128 bytes. This is more efficient in terms of memory
 		      access but isn't required by the HDA spec and prevents
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cca8727..9883235 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -134,8 +134,8 @@ MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
  * this may give more power-saving, but will take longer time to
  * wake up.
  */
-static bool power_save_controller = 1;
-module_param(power_save_controller, bool, 0644);
+static int power_save_controller = -1;
+module_param(power_save_controller, bint, 0644);
 MODULE_PARM_DESC(power_save_controller, "Reset controller in power save mode.");
 #endif /* CONFIG_PM */
 
@@ -2711,6 +2711,8 @@ static int azx_runtime_idle(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 
+	if (power_save_controller > 0)
+		return 0;
 	if (!power_save_controller ||
 	    !(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
 		return -EBUSY;
-- 
1.8.1
