From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: hda: separate stream tag for playback
	and capture
Date: Tue, 18 Nov 2014 15:56:50 +0530
Message-ID: <1416306410-25073-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 23AF7260470
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 11:26:07 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, Rafal Redzimski <rafal.f.redzimski@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rafal Redzimski <rafal.f.redzimski@intel.com>

According to hda specification stream tag must be unique throughout the
input streams group, however an output stream might use a stream tag which
is already in use by an input stream.

Newer Intel HW has the capability to provides a total of more than
15 stream DMA engines which with the current implementation causes an overflow on
STRM field (and the whole register) which results in usage of
reserved value 0 in the STRM field which confuses HDA controller.
So make stream_tag assignment separate for input and output streams

Signed-off-by: Rafal Redzimski <rafal.f.redzimski@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_controller.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 8337645..703ac6e 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1921,11 +1921,17 @@ int azx_mixer_create(struct azx *chip)
 }
 EXPORT_SYMBOL_GPL(azx_mixer_create);
 
+static bool is_input_stream(struct azx *chip, unsigned char index)
+{
+	return index < chip->playback_index_offset;
+}
 
 /* initialize SD streams */
 int azx_init_stream(struct azx *chip)
 {
 	int i;
+	int in_stream_tag = 0;
+	int out_stream_tag = 0;
 
 	/* initialize each stream (aka device)
 	 * assign the starting bdl address to each stream (device)
@@ -1938,9 +1944,13 @@ int azx_init_stream(struct azx *chip)
 		azx_dev->sd_addr = chip->remap_addr + (0x20 * i + 0x80);
 		/* int mask: SDI0=0x01, SDI1=0x02, ... SDO3=0x80 */
 		azx_dev->sd_int_sta_mask = 1 << i;
-		/* stream tag: must be non-zero and unique */
 		azx_dev->index = i;
-		azx_dev->stream_tag = i + 1;
+
+		/* stream tag must be unique throughout the stream direction
+		 * group, valid values 1...15
+		 */
+		azx_dev->stream_tag = is_input_stream(chip, i) ?
+			++in_stream_tag : ++out_stream_tag;
 	}
 
 	return 0;
-- 
1.7.0.4
