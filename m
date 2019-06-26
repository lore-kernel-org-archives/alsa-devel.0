From: Rander Wang <rander.wang@linux.intel.com>
Subject: [RFC] ALSA: hda: Fix a headphone detection issue when
	using SOF
Date: Wed, 26 Jun 2019 14:38:24 +0800
Message-ID: <20190626063824.5378-1-rander.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6D53F806F0
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 08:35:32 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

To save power, the hda hdmi driver in ASoC invokes snd_hdac_ext_bus_link_put
to disable CORB/RIRB buffers DMA if there is no user of bus and invokes
snd_hdac_ext_bus_link_get to set up CORB/RIRB buffers when it is used.
Unsolicited responses is disabled in snd_hdac_bus_stop_cmd_io called by
snd_hdac_ext_bus_link_put , but it is not enabled in snd_hdac_bus_init_cmd_io
called by snd_hdac_ext_bus_link_get. So for put-get sequence, Unsolicited
responses is disabled and headphone can't be detected by hda codecs.

Now unsolicited responses is only enabled in snd_hdac_bus_reset_link
which resets controller. The function is only called for setup of
controller. This patch enables Unsolicited responses after RIRB is
initialized in snd_hdac_bus_init_cmd_io which works together with
snd_hdac_bus_reset_link to set up controller.

Tested legacy hda driver and SOF driver on intel whiskeylake.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
---
 sound/hda/hdac_controller.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index d6a91429c058..c24fc8d266a9 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -78,6 +78,8 @@ void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus)
 	snd_hdac_chip_writew(bus, RINTCNT, 1);
 	/* enable rirb dma and response irq */
 	snd_hdac_chip_writeb(bus, RIRBCTL, AZX_RBCTL_DMA_EN | AZX_RBCTL_IRQ_EN);
+	/* Accept unsolicited responses */
+	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, AZX_GCTL_UNSOL);
 	spin_unlock_irq(&bus->reg_lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_init_cmd_io);
@@ -416,9 +418,6 @@ int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset)
 		return -EBUSY;
 	}
 
-	/* Accept unsolicited responses */
-	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, AZX_GCTL_UNSOL);
-
 	/* detect codecs */
 	if (!bus->codec_mask) {
 		bus->codec_mask = snd_hdac_chip_readw(bus, STATESTS);
-- 
2.14.1
