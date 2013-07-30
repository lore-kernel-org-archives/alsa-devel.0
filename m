From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 3/3 V3] ALSA: hda - WAKEEN feature enabling for
	runtime pm
Date: Tue, 30 Jul 2013 03:06:09 -0400
Message-ID: <1375167969-14128-3-git-send-email-xingchao.wang@linux.intel.com>
References: <1375167969-14128-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 32F44265130
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 08:30:40 +0200 (CEST)
In-Reply-To: <1375167969-14128-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

With runtime power save feature enabled, Headphone hotplug
event will not be detected while controller/codec in D3. HDA has
feature WAKEEN to let codec wake up system if controller is in D3 or
system in S3.(HDA Spec 4.5.9.2/3). Codec can send out INT or wake up
controller depending on whether CIE or GIE enabled.(Figure 4, Interupt
structure).

The controller must be in RESET mode after enter runtime-suspend, otherwise
it will not be waken up even if codec send out wake-up event. And STATESTS
will be cleared after controller brought out of RESET mode.

This patch only enable WAKEEN for runtime-suspend(Controller D3) mode,
not for system S3 mode. with tool "evtest", Headphone hotplug events
could be cought and reported successfully.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8860dd5..c848cf1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2971,6 +2971,10 @@ static int azx_runtime_suspend(struct device *dev)
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 
+	/* enable controller wake up event */
+	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
+		  STATESTS_INT_MASK);
+
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
@@ -2983,11 +2987,31 @@ static int azx_runtime_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
+	struct hda_bus *bus;
+	struct hda_codec *codec;
+	int status;
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
 		hda_display_power(true);
+
+	/* Read STATESTS before controller reset */
+	status = azx_readw(chip, STATESTS);
+
 	azx_init_pci(chip);
 	azx_init_chip(chip, 1);
+
+	bus = chip->bus;
+	if (status && bus) {
+		list_for_each_entry(codec, &bus->codec_list, list)
+			if (status & (1 << codec->addr))
+				queue_delayed_work(codec->bus->workq,
+						   &codec->jackpoll_work, codec->jackpoll_interval);
+	}
+
+	/* disable controller Wake Up event*/
+	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
+			~STATESTS_INT_MASK);
+
 	return 0;
 }
 
-- 
1.8.3.2
