From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: hda - Move SD nums definitions to
	hda_intel.c
Date: Mon, 30 Jun 2014 14:21:00 +0200
Message-ID: <1404130862-3152-6-git-send-email-tiwai@suse.de>
References: <1404130862-3152-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C2E4426559F
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 14:21:05 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9C53FAD62
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:21:05 +0000 (UTC)
In-Reply-To: <1404130862-3152-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The defined numbers of SDs are specific to hda-intel, so move them to
there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 17 +++++++++++++++++
 sound/pci/hda/hda_priv.h  | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1e971e2f1d50..bbf01fcb6893 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -94,6 +94,23 @@ enum {
 /* Define VIA HD Audio Device ID*/
 #define VIA_HDAC_DEVICE_ID		0x3288
 
+/* max number of SDs */
+/* ICH, ATI and VIA have 4 playback and 4 capture */
+#define ICH6_NUM_CAPTURE	4
+#define ICH6_NUM_PLAYBACK	4
+
+/* ULI has 6 playback and 5 capture */
+#define ULI_NUM_CAPTURE		5
+#define ULI_NUM_PLAYBACK	6
+
+/* ATI HDMI may have up to 8 playbacks and 0 capture */
+#define ATIHDMI_NUM_CAPTURE	0
+#define ATIHDMI_NUM_PLAYBACK	8
+
+/* TERA has 4 playback and 3 capture */
+#define TERA_NUM_CAPTURE	3
+#define TERA_NUM_PLAYBACK	4
+
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 30bbbc48d314..0688aaff09f1 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -103,23 +103,6 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
  * other constants
  */
 
-/* max number of SDs */
-/* ICH, ATI and VIA have 4 playback and 4 capture */
-#define ICH6_NUM_CAPTURE	4
-#define ICH6_NUM_PLAYBACK	4
-
-/* ULI has 6 playback and 5 capture */
-#define ULI_NUM_CAPTURE		5
-#define ULI_NUM_PLAYBACK	6
-
-/* ATI HDMI may have up to 8 playbacks and 0 capture */
-#define ATIHDMI_NUM_CAPTURE	0
-#define ATIHDMI_NUM_PLAYBACK	8
-
-/* TERA has 4 playback and 3 capture */
-#define TERA_NUM_CAPTURE	3
-#define TERA_NUM_PLAYBACK	4
-
 /* max number of fragments - we may use more if allocating more pages for BDL */
 #define BDL_SIZE		4096
 #define AZX_MAX_BDL_ENTRIES	(BDL_SIZE / 16)
-- 
2.0.0
