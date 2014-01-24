From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 06/19] ALSA: Oxygen: Additional definitions
	for the Xonar DG/DGX card
Date: Fri, 24 Jan 2014 16:18:07 +0400
Message-ID: <1390565900-3337-6-git-send-email-v1ron@mail.ru>
References: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Roman Volkov <v1ron@mail.ru>
List-Id: alsa-devel@alsa-project.org

Add additional constants to the xonar_dg.h file:
capture and playback sources. Move GPIO_* constants and the
dg struct to the header file from the xonar_dg.c file.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c |   14 --------------
 sound/pci/oxygen/xonar_dg.h |   23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index b806cc1..2a0ad6e 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -64,20 +64,6 @@
 #include "xonar_dg.h"
 #include "cs4245.h"
 
-#define GPIO_MAGIC		0x0008
-#define GPIO_HP_DETECT		0x0010
-#define GPIO_INPUT_ROUTE	0x0060
-#define GPIO_HP_REAR		0x0080
-#define GPIO_OUTPUT_ENABLE	0x0100
-
-struct dg {
-	unsigned int output_sel;
-	s8 input_vol[4][2];
-	unsigned int input_sel;
-	u8 hp_vol_att;
-	u8 cs4245_regs[0x11];
-};
-
 static void cs4245_write(struct oxygen *chip, unsigned int reg, u8 value)
 {
 	struct dg *data = chip->model_data;
diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index 5688d78..0812692 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -3,6 +3,29 @@
 
 #include "oxygen.h"
 
+#define GPIO_MAGIC		0x0008
+#define GPIO_HP_DETECT		0x0010
+#define GPIO_INPUT_ROUTE	0x0060
+#define GPIO_HP_REAR		0x0080
+#define GPIO_OUTPUT_ENABLE	0x0100
+
+#define CAPTURE_SRC_MIC		0
+#define CAPTURE_SRC_FP_MIC	1
+#define CAPTURE_SRC_LINE	2
+#define CAPTURE_SRC_AUX		3
+
+#define PLAYBACK_DST_HP		0
+#define PLAYBACK_DST_HP_FP	1
+#define PLAYBACK_DST_MULTICH	2
+
+struct dg {
+	unsigned int output_sel;
+	s8 input_vol[4][2];
+	unsigned int input_sel;
+	u8 hp_vol_att;
+	u8 cs4245_regs[0x11];
+};
+
 extern struct oxygen_model model_xonar_dg;
 
 #endif
-- 
1.7.10.4
