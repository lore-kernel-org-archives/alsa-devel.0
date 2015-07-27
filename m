From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
Subject: [PATCH 2/2] ALSA: hda - Fix race condition between HDA
	driver and runtime PM
Date: Mon, 27 Jul 2015 14:34:54 -0700
Message-ID: <1438032894-8472-2-git-send-email-ullysses.a.eoff@intel.com>
References: <1438032894-8472-1-git-send-email-ullysses.a.eoff@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 756302650C5
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 23:39:02 +0200 (CEST)
In-Reply-To: <1438032894-8472-1-git-send-email-ullysses.a.eoff@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, zhuo-hao.lee@intel.com, "U. Artie Eoff" <ullysses.a.eoff@intel.com>
List-Id: alsa-devel@alsa-project.org

Don't execute runtime suspend if HDA is not finished initializing.
Otherwise, the following errors can occur in hda:

snd_hda_intel 0000:00:1b.0: CORB reset timeout#2, CORBRP = 65535
snd_hda_intel 0000:00:1b.0: no codecs initialized

Debugged and root-cause found by zhuo-hao.lee@intel.com

Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
---
 sound/pci/hda/hda_intel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b729b25a6ad6..062f2400dbc7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1017,17 +1017,20 @@ static int azx_runtime_idle(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
 	struct hda_intel *hda;
+	struct hdac_bus *bus;
 
 	if (!card)
 		return 0;
 
 	chip = card->private_data;
 	hda = container_of(chip, struct hda_intel, chip);
-	if (chip->disabled || hda->init_failed || !chip->running)
+	bus = azx_bus(chip);
+	if (chip->disabled || hda->init_failed ||
+		(bus->chip_init && !chip->running))
 		return 0;
 
 	if (!power_save_controller || !azx_has_pm_runtime(chip) ||
-	    azx_bus(chip)->codec_powered)
+	    bus->codec_powered || !bus->chip_init)
 		return -EBUSY;
 
 	return 0;
-- 
1.9.3
