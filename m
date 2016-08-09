From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA - Ext hda: remove
	bus_parse_capabilities" to the asoc tree
Date: Tue, 09 Aug 2016 13:44:15 +0100
Message-ID: <E1bX6OF-0003e6-Ln@debutante>
References: <1470240374-20018-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F34C267D1E
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:44:22 +0200 (CEST)
In-Reply-To: <1470240374-20018-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA - Ext hda: remove bus_parse_capabilities

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 404735c9fd8adff8e5ad11e1f9f8db069d865698 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 4 Aug 2016 15:46:02 +0530
Subject: [PATCH] ALSA - Ext hda: remove bus_parse_capabilities

Remove the unused one as we have moved it up to hdac core.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio_ext.h         | 12 ------
 sound/hda/ext/hdac_ext_controller.c | 75 -------------------------------------
 2 files changed, 87 deletions(-)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index b9593b201599..8660a7f10851 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -8,11 +8,6 @@
  *
  * @bus: hdac bus
  * @num_streams: streams supported
- * @ppcap: pp capabilities pointer
- * @spbcap: SPIB capabilities pointer
- * @mlcap: MultiLink capabilities pointer
- * @gtscap: gts capabilities pointer
- * @drsmcap: dma resume capabilities pointer
  * @hlink_list: link list of HDA links
  * @lock: lock for link mgmt
  * @cmd_dma_state: state of cmd DMAs: CORB and RIRB
@@ -22,12 +17,6 @@ struct hdac_ext_bus {
 	int num_streams;
 	int idx;
 
-	void __iomem *ppcap;
-	void __iomem *spbcap;
-	void __iomem *mlcap;
-	void __iomem *gtscap;
-	void __iomem *drsmcap;
-
 	struct list_head hlink_list;
 
 	struct mutex lock;
@@ -54,7 +43,6 @@ void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus);
 #define HDA_CODEC_EXT_ENTRY(_vid, _revid, _name, _drv_data) \
 	HDA_CODEC_REV_EXT_ENTRY(_vid, _revid, _name, _drv_data)
 
-int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *sbus);
 void snd_hdac_ext_bus_ppcap_enable(struct hdac_ext_bus *chip, bool enable);
 void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_ext_bus *chip, bool enable);
 
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index cd65e007e864..261469188566 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -29,81 +29,6 @@
  */
 #define HDAC_MAX_CAPS 10
 
-/**
- * snd_hdac_ext_bus_parse_capabilities - parse capablity structure
- * @ebus: the pointer to extended bus object
- *
- * Returns 0 if successful, or a negative error code.
- */
-int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *ebus)
-{
-	unsigned int cur_cap;
-	unsigned int offset;
-	struct hdac_bus *bus = &ebus->bus;
-	unsigned int counter = 0;
-
-	offset = snd_hdac_chip_readl(bus, LLCH);
-
-	/* Lets walk the linked capabilities list */
-	do {
-		cur_cap = _snd_hdac_chip_read(l, bus, offset);
-
-		dev_dbg(bus->dev, "Capability version: 0x%x\n",
-				((cur_cap & AZX_CAP_HDR_VER_MASK) >> AZX_CAP_HDR_VER_OFF));
-
-		dev_dbg(bus->dev, "HDA capability ID: 0x%x\n",
-				(cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF);
-
-		switch ((cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF) {
-		case AZX_ML_CAP_ID:
-			dev_dbg(bus->dev, "Found ML capability\n");
-			ebus->mlcap = bus->remap_addr + offset;
-			break;
-
-		case AZX_GTS_CAP_ID:
-			dev_dbg(bus->dev, "Found GTS capability offset=%x\n", offset);
-			ebus->gtscap = bus->remap_addr + offset;
-			break;
-
-		case AZX_PP_CAP_ID:
-			/* PP capability found, the Audio DSP is present */
-			dev_dbg(bus->dev, "Found PP capability offset=%x\n", offset);
-			ebus->ppcap = bus->remap_addr + offset;
-			break;
-
-		case AZX_SPB_CAP_ID:
-			/* SPIB capability found, handler function */
-			dev_dbg(bus->dev, "Found SPB capability\n");
-			ebus->spbcap = bus->remap_addr + offset;
-			break;
-
-		case AZX_DRSM_CAP_ID:
-			/* DMA resume  capability found, handler function */
-			dev_dbg(bus->dev, "Found DRSM capability\n");
-			ebus->drsmcap = bus->remap_addr + offset;
-			break;
-
-		default:
-			dev_dbg(bus->dev, "Unknown capability %d\n", cur_cap);
-			break;
-		}
-
-		counter++;
-
-		if (counter > HDAC_MAX_CAPS) {
-			dev_err(bus->dev, "We exceeded HDAC Ext capablities!!!\n");
-			break;
-		}
-
-		/* read the offset of next capabiity */
-		offset = cur_cap & AZX_CAP_HDR_NXT_PTR_MASK;
-
-	} while (offset);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_parse_capabilities);
-
 /*
  * processing pipe helpers - these helpers are useful for dealing with HDA
  * new capability of processing pipelines
-- 
2.8.1
