From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 15/19] ALSA: hda - Pass max_slots and power_save
	to codec_create
Date: Thu, 27 Feb 2014 22:35:58 -0800
Message-ID: <1393569362-27285-16-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f73.google.com (mail-pa0-f73.google.com
 [209.85.220.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E6562650D4
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-pa0-f73.google.com with SMTP id kq14so34219pab.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Passing the max slots and power save arguments to codec_create will
allow for its reuse by an hda_platform driver. It makes the function
independent of the module params in hda_intel and ready to move to
hda_shared in a following commit.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4fa4da1..a42c576 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -124,6 +124,7 @@ static struct kernel_param_ops param_ops_xint = {
 #define param_check_xint param_check_int
 
 static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
+static int *power_save_addr = &power_save;
 module_param(power_save, xint, 0644);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
@@ -135,6 +136,8 @@ MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 static bool power_save_controller = 1;
 module_param(power_save_controller, bool, 0644);
 MODULE_PARM_DESC(power_save_controller, "Reset controller in power save mode.");
+#else
+static int *power_save_addr;
 #endif /* CONFIG_PM */
 
 static int align_buffer_size = -1;
@@ -458,17 +461,12 @@ static int get_jackpoll_interval(struct azx *chip)
  * Codec initialization
  */
 
-/* number of codec slots for each chipset: 0 = default slots (i.e. 4) */
-static unsigned int azx_max_codecs[AZX_NUM_DRIVERS] = {
-	[AZX_DRIVER_NVIDIA] = 8,
-	[AZX_DRIVER_TERA] = 1,
-};
-
-static int azx_codec_create(struct azx *chip, const char *model)
+static int azx_codec_create(struct azx *chip, const char *model,
+			    unsigned int max_slots,
+			    int *power_save_to)
 {
 	struct hda_bus_template bus_temp;
 	int c, codecs, err;
-	int max_slots;
 
 	memset(&bus_temp, 0, sizeof(bus_temp));
 	bus_temp.private_data = chip;
@@ -479,7 +477,7 @@ static int azx_codec_create(struct azx *chip, const char *model)
 	bus_temp.ops.attach_pcm = azx_attach_pcm_stream;
 	bus_temp.ops.bus_reset = azx_bus_reset;
 #ifdef CONFIG_PM
-	bus_temp.power_save = &power_save;
+	bus_temp.power_save = power_save_to;
 	bus_temp.ops.pm_notify = azx_power_notify;
 #endif
 #ifdef CONFIG_SND_HDA_DSP_LOADER
@@ -498,7 +496,6 @@ static int azx_codec_create(struct azx *chip, const char *model)
 	}
 
 	codecs = 0;
-	max_slots = azx_max_codecs[chip->driver_type];
 	if (!max_slots)
 		max_slots = AZX_DEFAULT_CODECS;
 
@@ -1619,6 +1616,12 @@ out_free:
 	return err;
 }
 
+/* number of codec slots for each chipset: 0 = default slots (i.e. 4) */
+static unsigned int azx_max_codecs[AZX_NUM_DRIVERS] = {
+	[AZX_DRIVER_NVIDIA] = 8,
+	[AZX_DRIVER_TERA] = 1,
+};
+
 static int azx_probe_continue(struct azx *chip)
 {
 	struct pci_dev *pci = chip->pci;
@@ -1647,7 +1650,10 @@ static int azx_probe_continue(struct azx *chip)
 #endif
 
 	/* create codec instances */
-	err = azx_codec_create(chip, model[dev]);
+	err = azx_codec_create(chip, model[dev],
+			       azx_max_codecs[chip->driver_type],
+			       power_save_addr);
+
 	if (err < 0)
 		goto out_free;
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
-- 
1.8.1.3.605.g02339dd
