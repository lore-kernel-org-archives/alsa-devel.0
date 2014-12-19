From: libin.yang@intel.com
Subject: [PATCH 1/2] ALSA: hda_controller: Separate stream_tag
	for input and output streams.
Date: Fri, 19 Dec 2014 08:44:30 +0800
Message-ID: <1418949871-55413-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 52EA526049E
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 01:49:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, libin.yang@intel.com, jayachandran.b@intel.com, rafal.f.redzimski@intel.com
List-Id: alsa-devel@alsa-project.org

From: Rafal Redzimski <rafal.f.redzimski@intel.com>

Implemented separate stream_tag assignment for input and output streams.
According to hda specification stream tag must be unique throughout the
input streams group, however an output stream might use a stream tag
which is already in use by an input stream. This change is necessary
to support HW which provides a total of more than 15 stream DMA engines
which with legacy implementation causes an overflow on SDxCTL.STRM
field (and the whole SDxCTL register) and as a result usage of
Reserved value 0 in the SDxCTL.STRM field which confuses HDA controller.

Signed-off-by: Rafal Redzimski <rafal.f.redzimski@intel.com>
Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Libin Yang <libin.yang@intel.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_controller.c | 24 ++++++++++++++++++++++--
 sound/pci/hda/hda_priv.h       |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 8337645..dcca1ef 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1922,10 +1922,18 @@ int azx_mixer_create(struct azx *chip)
 EXPORT_SYMBOL_GPL(azx_mixer_create);
 
 
+static bool is_input_stream(struct azx *chip, unsigned char index)
+{
+	return (index >= chip->capture_index_offset &&
+		index < chip->capture_index_offset + chip->capture_streams);
+}
+
 /* initialize SD streams */
 int azx_init_stream(struct azx *chip)
 {
 	int i;
+	int in_stream_tag = 0;
+	int out_stream_tag = 0;
 
 	/* initialize each stream (aka device)
 	 * assign the starting bdl address to each stream (device)
@@ -1938,9 +1946,21 @@ int azx_init_stream(struct azx *chip)
 		azx_dev->sd_addr = chip->remap_addr + (0x20 * i + 0x80);
 		/* int mask: SDI0=0x01, SDI1=0x02, ... SDO3=0x80 */
 		azx_dev->sd_int_sta_mask = 1 << i;
-		/* stream tag: must be non-zero and unique */
 		azx_dev->index = i;
-		azx_dev->stream_tag = i + 1;
+
+		/* stream tag must be unique throughout
+		 * the stream direction group,
+		 * valid values 1...15
+		 * use separate stream tag if the flag
+		 * AZX_DCAPS_SEPARATE_STREAM_TAG is used
+		 */
+		if (chip->driver_caps & AZX_DCAPS_SEPARATE_STREAM_TAG)
+			azx_dev->stream_tag =
+				is_input_stream(chip, i) ?
+				++in_stream_tag :
+				++out_stream_tag;
+		else
+			azx_dev->stream_tag = i + 1;
 	}
 
 	return 0;
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index aa484fd..166e3e8 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -171,6 +171,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_DCAPS_I915_POWERWELL (1 << 27)	/* HSW i915 powerwell support */
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 #define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
+#define AZX_DCAPS_SEPARATE_STREAM_TAG	(1 << 30) /* capture and playback use separate stream tag */
 
 enum {
 	AZX_SNOOP_TYPE_NONE ,
-- 
1.9.1
