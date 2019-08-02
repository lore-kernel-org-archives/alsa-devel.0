From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Subject: [PATCH] ALSA: hda: Add support of Zhaoxin controller
Date: Fri, 2 Aug 2019 03:04:08 +0000
Message-ID: <6a423679a72a4acb88233559fae0507b@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
To: "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "hui.wang@canonical.com" <hui.wang@canonical.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: David Wang <DavidWang@zhaoxin.com>, "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>, "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>, "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
List-Id: alsa-devel@alsa-project.org

Add the new PCI ID 0x1d17 0x3288 Zhaoxin controller support

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 sound/pci/hda/hda_intel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 324a4b2..d08da0e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -266,6 +266,7 @@ enum {
 	AZX_DRIVER_CTX,
 	AZX_DRIVER_CTHDA,
 	AZX_DRIVER_CMEDIA,
+	AZX_DRIVER_ZHAOXIN,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -379,6 +380,7 @@ static char *driver_short_names[] = {
 	[AZX_DRIVER_CTX] = "HDA Creative", 
 	[AZX_DRIVER_CTHDA] = "HDA Creative",
 	[AZX_DRIVER_CMEDIA] = "HDA C-Media",
+	[AZX_DRIVER_ZHAOXIN] = "HDA Zhaoxin",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
@@ -2589,6 +2591,8 @@ static const struct pci_device_id azx_ids[] = {
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_HDMI },
+	/* Zhaoxin */
+	{ PCI_DEVICE(0x1d17, 0x3288), .driver_data = AZX_DRIVER_ZHAOXIN },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
-- 
2.7.4
