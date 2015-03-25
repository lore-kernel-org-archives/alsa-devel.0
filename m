From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC v2 1/3] ALSA: hda: add HDA_MAX_CODECS
Date: Wed, 25 Mar 2015 11:31:37 +0530
Message-ID: <1427263299-14707-2-git-send-email-vinod.koul@intel.com>
References: <1427263299-14707-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2052726166B
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 07:05:45 +0100 (CET)
In-Reply-To: <1427263299-14707-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This moves AZX_MAX_CODECS define to HDA_MAX_CODECS so that common code can
use this as well

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_verbs.h      |    1 +
 sound/pci/hda/hda_controller.c |    4 ++--
 sound/pci/hda/hda_controller.h |    9 ++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/sound/hda_verbs.h b/include/sound/hda_verbs.h
index d0509db6d0ec..42b8415b2254 100644
--- a/include/sound/hda_verbs.h
+++ b/include/sound/hda_verbs.h
@@ -550,5 +550,6 @@ enum {
 
 /* max. codec address */
 #define HDA_MAX_CODEC_ADDRESS	0x0f
+#define HDA_MAX_CODECS		8
 
 #endif /* __SOUND_HDA_VERBS_H */
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 26ce990592a0..abb3822f5488 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1066,7 +1066,7 @@ static unsigned int azx_command_addr(u32 cmd)
 {
 	unsigned int addr = cmd >> 28;
 
-	if (addr >= AZX_MAX_CODECS) {
+	if (addr >= HDA_MAX_CODECS) {
 		snd_BUG();
 		addr = 0;
 	}
@@ -1136,7 +1136,7 @@ static void azx_update_rirb(struct azx *chip)
 		res_ex = le32_to_cpu(chip->rirb.buf[rp + 1]);
 		res = le32_to_cpu(chip->rirb.buf[rp]);
 		addr = res_ex & 0xf;
-		if ((addr >= AZX_MAX_CODECS) || !(chip->codec_mask & (1 << addr))) {
+		if ((addr >= HDA_MAX_CODECS) || !(chip->codec_mask & (1 << addr))) {
 			dev_err(chip->card->dev, "spurious response %#x:%#x, rp = %d, wp = %d",
 				res, res_ex,
 				chip->rirb.rp, wp);
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index be1b7ded8d82..2aa75e34a718 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -119,9 +119,8 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define RIRB_INT_MASK		0x05
 
 /* STATESTS int mask: S3,SD2,SD1,SD0 */
-#define AZX_MAX_CODECS		8
 #define AZX_DEFAULT_CODECS	4
-#define STATESTS_INT_MASK	((1 << AZX_MAX_CODECS) - 1)
+#define STATESTS_INT_MASK	((1 << HDA_MAX_CODECS) - 1)
 
 /* SD_CTL bits */
 #define SD_CTL_STREAM_RESET	0x01	/* stream reset bit */
@@ -245,8 +244,8 @@ struct azx_rb {
 	dma_addr_t addr;	/* physical address of CORB/RIRB buffer */
 	/* for RIRB */
 	unsigned short rp, wp;	/* read/write pointers */
-	int cmds[AZX_MAX_CODECS];	/* number of pending requests */
-	u32 res[AZX_MAX_CODECS];	/* last read value */
+	int cmds[HDA_MAX_CODECS];	/* number of pending requests */
+	u32 res[HDA_MAX_CODECS];	/* last read value */
 };
 
 struct azx;
@@ -360,7 +359,7 @@ struct azx {
 	unsigned int disabled:1; /* disabled by VGA-switcher */
 
 	/* for debugging */
-	unsigned int last_cmd[AZX_MAX_CODECS];
+	unsigned int last_cmd[HDA_MAX_CODECS];
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	struct azx_dev saved_azx_dev;
-- 
1.7.9.5
