From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] ALSA: hda/tegra: compatible string as shortname
Date: Thu, 29 Nov 2018 09:28:52 +0530
Message-ID: <1543463932-27625-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EEEC267B2C
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 04:59:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

By default HDA sound card is registered with shortname "tegra-hda".
Same driver is used across tegra platforms and it is necessary to
distinguish between platforms to use platform specific settings from
userspace. One such example is, hdmi port on different platforms use
different alsa pcm device ID. For hdmi playback to work it should
open correct pcm device depending on the platform.

This patch applies shortname from first compatible string provided
in root node of device tree. Userspace then can use this card name
to apply specific settings.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index dd7d424..84ea606 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -31,6 +31,7 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/string.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -344,6 +345,8 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	int err;
 	unsigned short gcap;
 	int irq_id = platform_get_irq(pdev, 0);
+	const char *sname;
+	struct device_node *root;
 
 	err = hda_tegra_init_chip(chip, pdev);
 	if (err)
@@ -401,8 +404,23 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* driver name */
 	strcpy(card->driver, "tegra-hda");
-	strcpy(card->shortname, "tegra-hda");
+
+	root = of_find_node_by_path("/");
+	sname = of_get_property(root, "compatible", NULL);
+	of_node_put(root);
+	if (!sname) {
+		dev_err(card->dev,
+			"failed to get compatible property from root node\n");
+		return -ENODEV;
+	}
+	/* shortname for card */
+	if (strlen(sname) > sizeof(card->shortname))
+		dev_info(card->dev, "truncating shortname for card\n");
+	strncpy(card->shortname, sname, sizeof(card->shortname));
+
+	/* longname for card */
 	snprintf(card->longname, sizeof(card->longname),
 		 "%s at 0x%lx irq %i",
 		 card->shortname, bus->addr, bus->irq);
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
