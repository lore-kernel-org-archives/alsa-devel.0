From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda - Improved position reporting on
	SKL+
Date: Fri, 31 Mar 2017 10:49:30 +0200
Message-ID: <20170331084930.813-4-tiwai@suse.de>
References: <20170331084930.813-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BC46F2671E8
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 10:49:32 +0200 (CEST)
In-Reply-To: <20170331084930.813-1-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

Apply the same methods to obtain the current stream position as ASoC
Intel SKL driver uses.  It reads the position from DPIB for a playback
stream while it still reads from the position buffer for a capture
stream.  For a capture stream, some ugly workaround is needed to
settle down the inconsistent position.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a48330f4a1a9..64db6698214c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -77,6 +77,7 @@ enum {
 	POS_FIX_POSBUF,
 	POS_FIX_VIACOMBO,
 	POS_FIX_COMBO,
+	POS_FIX_SKL,
 };
 
 /* Defines for ATI HD Audio support in SB450 south bridge */
@@ -148,7 +149,7 @@ module_param_array(model, charp, NULL, 0444);
 MODULE_PARM_DESC(model, "Use the given board model.");
 module_param_array(position_fix, int, NULL, 0444);
 MODULE_PARM_DESC(position_fix, "DMA pointer read method."
-		 "(-1 = system default, 0 = auto, 1 = LPIB, 2 = POSBUF, 3 = VIACOMBO, 4 = COMBO).");
+		 "(-1 = system default, 0 = auto, 1 = LPIB, 2 = POSBUF, 3 = VIACOMBO, 4 = COMBO, 5 = SKL+).");
 module_param_array(bdl_pos_adj, int, NULL, 0644);
 MODULE_PARM_DESC(bdl_pos_adj, "BDL position adjustment offset.");
 module_param_array(probe_mask, int, NULL, 0444);
@@ -815,6 +816,31 @@ static unsigned int azx_via_get_position(struct azx *chip,
 	return bound_pos + mod_dma_pos;
 }
 
+static unsigned int azx_skl_get_dpib_pos(struct azx *chip,
+					 struct azx_dev *azx_dev)
+{
+	return _snd_hdac_chip_readl(azx_bus(chip),
+				    AZX_REG_VS_SDXDPIB_XBASE +
+				    (AZX_REG_VS_SDXDPIB_XINTERVAL *
+				     azx_dev->core.index));
+}
+
+/* get the current DMA position with correction on SKL+ chips */
+static unsigned int azx_get_pos_skl(struct azx *chip, struct azx_dev *azx_dev)
+{
+	/* DPIB register gives a more accurate position for playback */
+	if (azx_dev->core.substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return azx_skl_get_dpib_pos(chip, azx_dev);
+
+	/* For capture, we need to read posbuf, but it requires a delay
+	 * for the possible boundary overlap; the read of DPIB fetches the
+	 * actual posbuf
+	 */
+	udelay(20);
+	azx_skl_get_dpib_pos(chip, azx_dev);
+	return azx_get_pos_posbuf(chip, azx_dev);
+}
+
 #ifdef CONFIG_PM
 static DEFINE_MUTEX(card_list_lock);
 static LIST_HEAD(card_list);
@@ -1351,6 +1377,7 @@ static int check_position_fix(struct azx *chip, int fix)
 	case POS_FIX_POSBUF:
 	case POS_FIX_VIACOMBO:
 	case POS_FIX_COMBO:
+	case POS_FIX_SKL:
 		return fix;
 	}
 
@@ -1371,6 +1398,10 @@ static int check_position_fix(struct azx *chip, int fix)
 		dev_dbg(chip->card->dev, "Using LPIB position fix\n");
 		return POS_FIX_LPIB;
 	}
+	if (IS_SKL_PLUS(chip->pci)) {
+		dev_dbg(chip->card->dev, "Using SKL position fix\n");
+		return POS_FIX_SKL;
+	}
 	return POS_FIX_AUTO;
 }
 
@@ -1382,6 +1413,7 @@ static void assign_position_fix(struct azx *chip, int fix)
 		[POS_FIX_POSBUF] = azx_get_pos_posbuf,
 		[POS_FIX_VIACOMBO] = azx_via_get_position,
 		[POS_FIX_COMBO] = azx_get_pos_lpib,
+		[POS_FIX_SKL] = azx_get_pos_skl,
 	};
 
 	chip->get_position[0] = chip->get_position[1] = callbacks[fix];
@@ -1390,7 +1422,7 @@ static void assign_position_fix(struct azx *chip, int fix)
 	if (fix == POS_FIX_COMBO)
 		chip->get_position[1] = NULL;
 
-	if (fix == POS_FIX_POSBUF &&
+	if ((fix == POS_FIX_POSBUF || fix == POS_FIX_SKL) &&
 	    (chip->driver_caps & AZX_DCAPS_COUNT_LPIB_DELAY)) {
 		chip->get_delay[0] = chip->get_delay[1] =
 			azx_get_delay_from_lpib;
-- 
2.11.1
