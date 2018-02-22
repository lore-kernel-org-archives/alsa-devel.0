From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC v3] ALSA: hda: Add a power_save blacklist
Date: Thu, 22 Feb 2018 14:20:35 +0100
Message-ID: <20180222132035.1554-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 210E726778C
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 14:20:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On some boards setting power_save to a non 0 value leads to clicking /
popping sounds when ever we enter/leave powersaving mode. Ideally we would
figure out how to avoid these sounds, but that is not always feasible.

This commit adds a blacklist for devices where powersaving is known to
cause problems and disables it on these devices.

Note I tried to put this blacklist in userspace first:
https://github.com/systemd/systemd/pull/8128

But the systemd maintainers rightfully pointed out that it would be
impossible to then later remove entries once we actually find a way to
make power-saving work on listed boards without issues. Having this list
in the kernel will allow removal of the blacklist entry in the same commit
which fixes the clicks / plops.

The blacklist only applies to the default power_save module-option value,
if a user explicitly sets the module-option then the blacklist is not
used.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=198611
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in RFC v2:
-Only use the blacklist if the power_save module-option is not explicitly
 set by the user

Changes in RFC v2:
-Fix logic to work on boards with more then 1 HDA device
---
 sound/pci/hda/hda_intel.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c71dcacea807..9d67b6b0ec95 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -181,7 +181,7 @@ static const struct kernel_param_ops param_ops_xint = {
 };
 #define param_check_xint param_check_int
 
-static int power_save = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
+static int power_save = -1;
 module_param(power_save, xint, 0644);
 MODULE_PARM_DESC(power_save, "Automatic power-saving timeout "
 		 "(in second, 0 = disable).");
@@ -2186,6 +2186,22 @@ static int azx_probe(struct pci_dev *pci,
 	return err;
 }
 
+/* On some boards setting power_save to a non 0 value leads to clicking /
+ * popping sounds when ever we enter/leave powersaving mode. Ideally we would
+ * figure out how to avoid these sounds, but that is not always feasible.
+ * So we keep a list of devices where we disable powersaving as its known
+ * to causes problems on these devices.
+ */
+static struct snd_pci_quirk power_save_blacklist[] = {
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
+	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	{}
+};
+
 /* number of codec slots for each chipset: 0 = default slots (i.e. 4) */
 static unsigned int azx_max_codecs[AZX_NUM_DRIVERS] = {
 	[AZX_DRIVER_NVIDIA] = 8,
@@ -2197,7 +2213,9 @@ static int azx_probe_continue(struct azx *chip)
 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
 	struct hdac_bus *bus = azx_bus(chip);
 	struct pci_dev *pci = chip->pci;
+	const struct snd_pci_quirk *q;
 	int dev = chip->dev_index;
+	int val;
 	int err;
 
 	hda->probe_continued = 1;
@@ -2278,7 +2296,18 @@ static int azx_probe_continue(struct azx *chip)
 
 	chip->running = 1;
 	azx_add_card_list(chip);
-	snd_hda_set_power_save(&chip->bus, power_save * 1000);
+
+	val = power_save;
+	if (val == -1) {
+		val = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
+		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
+		if (q && val) {
+			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
+				 q->subvendor, q->subdevice);
+			val = 0;
+		}
+	}
+	snd_hda_set_power_save(&chip->bus, val * 1000);
 	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
 		pm_runtime_put_autosuspend(&pci->dev);
 
-- 
2.14.3
