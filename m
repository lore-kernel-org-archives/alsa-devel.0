From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC] ALSA: hda: Add a power_save blacklist
Date: Thu, 22 Feb 2018 11:53:52 +0100
Message-ID: <20180222105352.5408-2-hdegoede@redhat.com>
References: <20180222105352.5408-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 7944D267699
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 11:53:56 +0100 (CET)
In-Reply-To: <20180222105352.5408-1-hdegoede@redhat.com>
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

I've chosen to also apply the blacklist to changes made through
/sys/module/snd_hda_intel/parameters/power_save, since tools such as
powertop and TLP do this automatically.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1533858
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
About the choice to also apply this to changes made through
/sys/module/snd_hda_intel/parameters/power_save, one could argue that this
will get in the way of users who want the power-saving anyways and are
willing to live with the clicks/plops. An alternative approach would be to
only apply this to the value of the module-parameter at boot and then only
when it matches CONFIG_SND_HDA_POWER_SAVE_DEFAULT. I'm open to changing this
for v2.
---
 sound/pci/hda/hda_intel.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c71dcacea807..ea612aeb1663 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -936,6 +936,34 @@ static unsigned int azx_get_pos_skl(struct azx *chip, struct azx_dev *azx_dev)
 	return azx_get_pos_posbuf(chip, azx_dev);
 }
 
+/* On some boards setting power_save to a non 0 value leads to clicking /
+ * popping sounds when ever we enter/leave powersaving mode. Ideally we would
+ * figure out how to avoid these sounds, but that is not always feasible.
+ * So we keep a list of devices where we disable powersaving as its known to
+ * causes problems on these devices.
+ */
+static struct snd_pci_quirk power_save_blacklist[] = {
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1533858 */
+	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	{}
+};
+
+static void check_power_save_blacklist(struct azx *chip)
+{
+	const struct snd_pci_quirk *q;
+
+	q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
+	if (q && power_save) {
+		dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
+			 q->subvendor, q->subdevice);
+		power_save = 0;
+	}
+}
+
 #ifdef CONFIG_PM
 static DEFINE_MUTEX(card_list_lock);
 static LIST_HEAD(card_list);
@@ -972,6 +1000,7 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 		chip = &hda->chip;
 		if (!hda->probe_continued || chip->disabled)
 			continue;
+		check_power_save_blacklist(chip);
 		snd_hda_set_power_save(&chip->bus, power_save * 1000);
 	}
 	mutex_unlock(&card_list_lock);
@@ -2278,6 +2307,7 @@ static int azx_probe_continue(struct azx *chip)
 
 	chip->running = 1;
 	azx_add_card_list(chip);
+	check_power_save_blacklist(chip);
 	snd_hda_set_power_save(&chip->bus, power_save * 1000);
 	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
 		pm_runtime_put_autosuspend(&pci->dev);
-- 
2.14.3
