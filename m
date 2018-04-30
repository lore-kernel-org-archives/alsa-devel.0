From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v3 3/3] ASoC: tas6424: Allow disabling auto
	diagnostics for faster power-on
Date: Mon, 30 Apr 2018 10:30:18 +0200
Message-ID: <1525077018-15863-4-git-send-email-jjhiblot@ti.com>
References: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 790BB267230
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 10:30:37 +0200 (CEST)
In-Reply-To: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, afd@ti.com, Jean-Jacques Hiblot <jjhiblot@ti.com>, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org

The TAS6424 incorporates both DC-load and AC-load diagnostics which are
used to determine the status of the load. The DC diagnostics runs when any
channel is directed to leave the Hi-Z state and enter the MUTE or PLAY
state.
The DC diagnostics are turned on by default but, if a fast startup without
diagnostics is required, the diagnostics can be disabled using a dedicated
ALSA control.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 sound/soc/codecs/tas6424.c | 13 +++++++++++--
 sound/soc/codecs/tas6424.h |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 89fd0c1..12d1e35 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -64,6 +64,8 @@ static const struct snd_kcontrol_new tas6424_snd_controls[] = {
 		       TAS6424_CH3_VOL_CTRL, 0, 0xff, 0, dac_tlv),
 	SOC_SINGLE_TLV("Speaker Driver CH4 Playback Volume",
 		       TAS6424_CH4_VOL_CTRL, 0, 0xff, 0, dac_tlv),
+	SOC_SINGLE_STROBE("Auto Diagnostics switch", TAS6424_DC_DIAG_CTRL1,
+			  TAS6424_LDGBYPASS_SHIFT, 1),
 };
 
 static int tas6424_dac_event(struct snd_soc_dapm_widget *w,
@@ -297,6 +299,11 @@ static int tas6424_power_on(struct snd_soc_component *component)
 	struct tas6424_data *tas6424 = snd_soc_component_get_drvdata(component);
 	int ret;
 	u8 chan_states;
+	int no_auto_diags = 0;
+	unsigned int reg_val;
+
+	if (!regmap_read(tas6424->regmap, TAS6424_DC_DIAG_CTRL1, &reg_val))
+		no_auto_diags = reg_val & TAS6424_LDGBYPASS_MASK;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(tas6424->supplies),
 				    tas6424->supplies);
@@ -327,9 +334,11 @@ static int tas6424_power_on(struct snd_soc_component *component)
 	snd_soc_component_write(component, TAS6424_CH_STATE_CTRL, chan_states);
 
 	/* any time we come out of HIZ, the output channels automatically run DC
-	 * load diagnostics, wait here until this completes
+	 * load diagnostics if autodiagnotics are enabled. wait here until this
+	 * completes.
 	 */
-	msleep(230);
+	if (!no_auto_diags)
+		msleep(230);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/tas6424.h b/sound/soc/codecs/tas6424.h
index 4305883..b5958c4 100644
--- a/sound/soc/codecs/tas6424.h
+++ b/sound/soc/codecs/tas6424.h
@@ -111,6 +111,10 @@
 					 TAS6424_CH3_STATE_DIAG | \
 					 TAS6424_CH4_STATE_DIAG)
 
+/* TAS6424_DC_DIAG_CTRL1 */
+#define TAS6424_LDGBYPASS_SHIFT		0
+#define TAS6424_LDGBYPASS_MASK		BIT(TAS6424_LDGBYPASS_SHIFT)
+
 /* TAS6424_GLOB_FAULT1_REG */
 #define TAS6424_FAULT_CLOCK		BIT(4)
 #define TAS6424_FAULT_PVDD_OV		BIT(3)
-- 
2.7.4
