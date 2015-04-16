From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/16] ALSA: hda - Drop azx_sd_read*/write*()
	macros
Date: Thu, 16 Apr 2015 18:14:30 +0200
Message-ID: <1429200870-5288-17-git-send-email-tiwai@suse.de>
References: <1429200870-5288-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EAE52625FF
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 18:14:38 +0200 (CEST)
In-Reply-To: <1429200870-5288-1-git-send-email-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

They are no longer used (only one place which can be replaced with a
proper helper function).  Let's drop.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.h | 13 -------------
 sound/pci/hda/hda_intel.c      |  2 +-
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index e8edb02c12d3..407cba6577b8 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -185,19 +185,6 @@ struct azx {
 #define azx_readb(chip, reg) \
 	snd_hdac_chip_readb(azx_bus(chip), reg)
 
-#define azx_sd_writel(chip, dev, reg, value) \
-	snd_hdac_stream_writel(&(dev)->core, reg, value)
-#define azx_sd_readl(chip, dev, reg) \
-	snd_hdac_stream_readl(&(dev)->core, reg)
-#define azx_sd_writew(chip, dev, reg, value) \
-	snd_hdac_stream_writew(&(dev)->core, reg, value)
-#define azx_sd_readw(chip, dev, reg) \
-	snd_hdac_stream_readw(&(dev)->core, reg)
-#define azx_sd_writeb(chip, dev, reg, value) \
-	snd_hdac_stream_writeb(&(dev)->core, reg, value)
-#define azx_sd_readb(chip, dev, reg) \
-	snd_hdac_stream_readb(&(dev)->core, reg)
-
 #define azx_has_pm_runtime(chip) \
 	(!AZX_DCAPS_PM_RUNTIME || ((chip)->driver_caps & AZX_DCAPS_PM_RUNTIME))
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8a1471851ca7..2b823d4ad888 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -680,7 +680,7 @@ static unsigned int azx_via_get_position(struct azx *chip,
 	unsigned int mod_link_pos, mod_dma_pos, mod_mini_pos;
 	unsigned int fifo_size;
 
-	link_pos = azx_sd_readl(chip, azx_dev, SD_LPIB);
+	link_pos = snd_hdac_stream_get_pos_lpib(azx_stream(azx_dev));
 	if (azx_dev->core.substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* Playback, no problem using link position */
 		return link_pos;
-- 
2.3.5
