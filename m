From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 15/16] ALSA: Oxygen: Additional declarations
	for the new mixer implementation
Date: Fri, 17 Jan 2014 19:08:34 +0400
Message-ID: <1389971315-3215-15-git-send-email-v1ron@mail.ru>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
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

The 'dg' struct changed, contains new values for the
mixer controls. Functions declared in the header file
to call them from the mixer.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.h |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index 844a67b..636890a 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -28,13 +28,31 @@ struct dg {
 	unsigned char cs4245_shadow[17];
 	/* Output select: headphone/speakers */
 	unsigned char pcm_output;
-	unsigned int output_sel;
-	s8 input_vol[4][2];
-	unsigned int input_sel;
-	u8 hp_vol_att;
-	u8 cs4245_regs[0x11];
+	/* Input select: Mic, FP Mic, Line, Aux */
+	unsigned char pga_source;
+	/* Independent capture volume control values */
+	char cap_vol[4][2];
+	/* Independent mute control values */
+	bool cap_mute[4];
 };
 
+/* Xonar DG control routines */
+int cs4245_write_spi(struct oxygen *chip, u8 reg);
+int cs4245_read_spi(struct oxygen *chip, u8 reg);
+int cs4245_shadow_control(struct oxygen *chip, enum cs4245_shadow_operation op);
+void dg_init(struct oxygen *chip);
+void set_cs4245_dac_params(struct oxygen *chip,
+				  struct snd_pcm_hw_params *params);
+void set_cs4245_adc_params(struct oxygen *chip,
+				  struct snd_pcm_hw_params *params);
+unsigned int adjust_dg_dac_routing(struct oxygen *chip,
+					  unsigned int play_routing);
+void dump_cs4245_registers(struct oxygen *chip,
+				struct snd_info_buffer *buffer);
+void dg_suspend(struct oxygen *chip);
+void dg_resume(struct oxygen *chip);
+void dg_cleanup(struct oxygen *chip);
+
 extern struct oxygen_model model_xonar_dg;
 
 #endif
-- 
1.7.10.4
