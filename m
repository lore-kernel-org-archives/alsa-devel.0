From: pavel.hofman@ivitera.com
Subject: [PATCH 2/7] ak4620 support, codec regs listed in proc
Date: Wed, 16 Sep 2009 22:25:36 +0200
Message-ID: <1253132741-15688-2-git-send-email-pavel.hofman@ivitera.com>
References: <1253132741-15688-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1253132741-15688-1-git-send-email-pavel.hofman@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

* complete support for ak4620
* codec regs listed in proc for all codecs/chips
* adding total regs for each codec
* fixing nb. of steps in input attenuation controls

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/i2c/other/ak4xxx-adda.c b/i2c/other/ak4xxx-adda.c
index ee47aba..1adb8a3 100644
--- a/i2c/other/ak4xxx-adda.c
+++ b/i2c/other/ak4xxx-adda.c
@@ -19,7 +19,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -29,6 +29,7 @@
 #include <sound/control.h>
 #include <sound/tlv.h>
 #include <sound/ak4xxx-adda.h>
+#include <sound/info.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("Routines for control of AK452x / AK43xx  AD/DA converters");
@@ -52,26 +53,21 @@ EXPORT_SYMBOL(snd_akm4xxx_write);
 static void ak4524_reset(struct snd_akm4xxx *ak, int state)
 {
 	unsigned int chip;
-	unsigned char reg, maxreg;
+	unsigned char reg;
 
-	if (ak->type == SND_AK4528)
-		maxreg = 0x06;
-	else
-		maxreg = 0x08;
 	for (chip = 0; chip < ak->num_dacs/2; chip++) {
 		snd_akm4xxx_write(ak, chip, 0x01, state ? 0x00 : 0x03);
 		if (state)
 			continue;
 		/* DAC volumes */
-		for (reg = 0x04; reg < maxreg; reg++)
+		for (reg = 0x04; reg < ak->total_regs; reg++)
 			snd_akm4xxx_write(ak, chip, reg,
 					  snd_akm4xxx_get(ak, chip, reg));
 	}
 }
 
 /* reset procedure for AK4355 and AK4358 */
-static void ak435X_reset(struct snd_akm4xxx *ak, int state,
-		unsigned char total_regs)
+static void ak435X_reset(struct snd_akm4xxx *ak, int state)
 {
 	unsigned char reg;
 
@@ -79,7 +75,7 @@ static void ak435X_reset(struct snd_akm4xxx *ak, int state,
 		snd_akm4xxx_write(ak, 0, 0x01, 0x02); /* reset and soft-mute */
 		return;
 	}
-	for (reg = 0x00; reg < total_regs; reg++)
+	for (reg = 0x00; reg < ak->total_regs; reg++)
 		if (reg != 0x01)
 			snd_akm4xxx_write(ak, 0, reg,
 					  snd_akm4xxx_get(ak, 0, reg));
@@ -91,12 +87,11 @@ static void ak4381_reset(struct snd_akm4xxx *ak, int state)
 {
 	unsigned int chip;
 	unsigned char reg;
-
 	for (chip = 0; chip < ak->num_dacs/2; chip++) {
 		snd_akm4xxx_write(ak, chip, 0x00, state ? 0x0c : 0x0f);
 		if (state)
 			continue;
-		for (reg = 0x01; reg < 0x05; reg++)
+		for (reg = 0x01; reg < ak->total_regs; reg++)
 			snd_akm4xxx_write(ak, chip, reg,
 					  snd_akm4xxx_get(ak, chip, reg));
 	}
@@ -113,16 +108,17 @@ void snd_akm4xxx_reset(struct snd_akm4xxx *ak, int state)
 	switch (ak->type) {
 	case SND_AK4524:
 	case SND_AK4528:
+	case SND_AK4620:
 		ak4524_reset(ak, state);
 		break;
 	case SND_AK4529:
 		/* FIXME: needed for ak4529? */
 		break;
 	case SND_AK4355:
-		ak435X_reset(ak, state, 0x0b);
+		ak435X_reset(ak, state);
 		break;
 	case SND_AK4358:
-		ak435X_reset(ak, state, 0x10);
+		ak435X_reset(ak, state);
 		break;
 	case SND_AK4381:
 		ak4381_reset(ak, state);
@@ -139,7 +135,7 @@ EXPORT_SYMBOL(snd_akm4xxx_reset);
  * Volume conversion table for non-linear volumes
  * from -63.5dB (mute) to 0dB step 0.5dB
  *
- * Used for AK4524 input/ouput attenuation, AK4528, and
+ * Used for AK4524/AK4620 input/ouput attenuation, AK4528, and
  * AK5365 input attenuation
  */
 static const unsigned char vol_cvt_datt[128] = {
@@ -259,8 +255,22 @@ void snd_akm4xxx_init(struct snd_akm4xxx *ak)
 		0x00, 0x0f, /* 0: power-up, un-reset */
 		0xff, 0xff
 	};
+	static const unsigned char inits_ak4620[] = {
+		0x00, 0x07, /* 0: normal */
+		0x01, 0x00, /* 0: reset */
+		0x01, 0x02, /* 1: RSTAD */
+		0x01, 0x03, /* 1: RSTDA */
+		0x01, 0x0f, /* 1: normal */
+		0x02, 0x60, /* 2: 24bit I2S */
+		0x03, 0x01, /* 3: deemphasis off */
+		0x04, 0x00, /* 4: LIN muted */
+		0x05, 0x00, /* 5: RIN muted */
+		0x06, 0x00, /* 6: LOUT muted */
+		0x07, 0x00, /* 7: ROUT muted */
+		0xff, 0xff
+	};
 
-	int chip, num_chips;
+	int chip;
 	const unsigned char *ptr, *inits;
 	unsigned char reg, data;
 
@@ -270,42 +280,64 @@ void snd_akm4xxx_init(struct snd_akm4xxx *ak)
 	switch (ak->type) {
 	case SND_AK4524:
 		inits = inits_ak4524;
-		num_chips = ak->num_dacs / 2;
+		ak->num_chips = ak->num_dacs / 2;
+		ak->name = "ak4524";
+		ak->total_regs = 0x08;
 		break;
 	case SND_AK4528:
 		inits = inits_ak4528;
-		num_chips = ak->num_dacs / 2;
+		ak->num_chips = ak->num_dacs / 2;
+		ak->name = "ak4528";
+		ak->total_regs = 0x06;
 		break;
 	case SND_AK4529:
 		inits = inits_ak4529;
-		num_chips = 1;
+		ak->num_chips = 1;
+		ak->name = "ak4529";
+		ak->total_regs = 0x0d;
 		break;
 	case SND_AK4355:
 		inits = inits_ak4355;
-		num_chips = 1;
+		ak->num_chips = 1;
+		ak->name = "ak4355";
+		ak->total_regs = 0x0b;
 		break;
 	case SND_AK4358:
 		inits = inits_ak4358;
-		num_chips = 1;
+		ak->num_chips = 1;
+		ak->name = "ak4358";
+		ak->total_regs = 0x10;
 		break;
 	case SND_AK4381:
 		inits = inits_ak4381;
-		num_chips = ak->num_dacs / 2;
+		ak->num_chips = ak->num_dacs / 2;
+		ak->name = "ak4381";
+		ak->total_regs = 0x05;
 		break;
 	case SND_AK5365:
 		/* FIXME: any init sequence? */
+		ak->num_chips = 1;
+		ak->name = "ak5365";
+		ak->total_regs = 0x08;
 		return;
+	case SND_AK4620:
+		inits = inits_ak4620;
+		ak->num_chips = ak->num_dacs / 2;
+		ak->name = "ak4620";
+		ak->total_regs = 0x08;
+		break;
 	default:
 		snd_BUG();
 		return;
 	}
 
-	for (chip = 0; chip < num_chips; chip++) {
+	for (chip = 0; chip < ak->num_chips; chip++) {
 		ptr = inits;
 		while (*ptr != 0xff) {
 			reg = *ptr++;
 			data = *ptr++;
 			snd_akm4xxx_write(ak, chip, reg, data);
+			udelay(10);
 		}
 	}
 }
@@ -688,6 +720,12 @@ static int build_dac_controls(struct snd_akm4xxx *ak)
 				AK_COMPOSE(idx/2, (idx%2) + 3, 0, 255);
 			knew.tlv.p = db_scale_linear;
 			break;
+		case SND_AK4620:
+			/* register 6 & 7 */
+			knew.private_value =
+				AK_COMPOSE(idx/2, (idx%2) + 6, 0, 255);
+			knew.tlv.p = db_scale_linear;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -704,10 +742,12 @@ static int build_dac_controls(struct snd_akm4xxx *ak)
 
 static int build_adc_controls(struct snd_akm4xxx *ak)
 {
-	int idx, err, mixer_ch, num_stereo;
+	int idx, err, mixer_ch, num_stereo, max_steps;
 	struct snd_kcontrol_new knew;
 
 	mixer_ch = 0;
+	if (ak->type == SND_AK4528)
+		return 0;	/* no controls */
 	for (idx = 0; idx < ak->num_adcs;) {
 		memset(&knew, 0, sizeof(knew));
 		if (! ak->adc_info || ! ak->adc_info[mixer_ch].name) {
@@ -733,13 +773,12 @@ static int build_adc_controls(struct snd_akm4xxx *ak)
 		}
 		/* register 4 & 5 */
 		if (ak->type == SND_AK5365)
-			knew.private_value =
-				AK_COMPOSE(idx/2, (idx%2) + 4, 0, 151) |
-				AK_VOL_CVT | AK_IPGA;
+			max_steps = 152;
 		else
-			knew.private_value =
-				AK_COMPOSE(idx/2, (idx%2) + 4, 0, 163) |
-				AK_VOL_CVT | AK_IPGA;
+			max_steps = 164;
+		knew.private_value =
+			AK_COMPOSE(idx/2, (idx%2) + 4, 0, max_steps) |
+			AK_VOL_CVT | AK_IPGA;
 		knew.tlv.p = db_scale_vol_datt;
 		err = snd_ctl_add(ak->card, snd_ctl_new1(&knew, ak));
 		if (err < 0)
@@ -808,6 +847,7 @@ static int build_deemphasis(struct snd_akm4xxx *ak, int num_emphs)
 		switch (ak->type) {
 		case SND_AK4524:
 		case SND_AK4528:
+		case SND_AK4620:
 			/* register 3 */
 			knew.private_value = AK_COMPOSE(idx, 3, 0, 0);
 			break;
@@ -834,6 +874,35 @@ static int build_deemphasis(struct snd_akm4xxx *ak, int num_emphs)
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
+static void proc_regs_read(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct snd_akm4xxx *ak = (struct snd_akm4xxx *)entry->private_data;
+	int reg, val, chip;
+	for (chip = 0; chip < ak->num_chips; chip++) {
+		for (reg = 0; reg < ak->total_regs; reg++) {
+			val =  snd_akm4xxx_get(ak, chip, reg);
+			snd_iprintf(buffer, "chip %d: 0x%02x = 0x%02x\n", chip,
+					reg, val);
+		}
+	}
+}
+
+static int proc_init(struct snd_akm4xxx *ak)
+{
+	struct snd_info_entry *entry;
+	int err;
+	err = snd_card_proc_new(ak->card, ak->name, &entry);
+	if (err < 0)
+		return err;
+	snd_info_set_text_ops(entry, ak, proc_regs_read);
+	return 0;
+}
+#else /* !CONFIG_PROC_FS */
+static int proc_init(struct snd_akm4xxx *ak) {}
+#endif
+
 int snd_akm4xxx_build_controls(struct snd_akm4xxx *ak)
 {
 	int err, num_emphs;
@@ -845,18 +914,21 @@ int snd_akm4xxx_build_controls(struct snd_akm4xxx *ak)
 	err = build_adc_controls(ak);
 	if (err < 0)
 		return err;
-
 	if (ak->type == SND_AK4355 || ak->type == SND_AK4358)
 		num_emphs = 1;
+	else if (ak->type == SND_AK4620)
+		num_emphs = 0;
 	else
 		num_emphs = ak->num_dacs / 2;
 	err = build_deemphasis(ak, num_emphs);
 	if (err < 0)
 		return err;
+	err = proc_init(ak);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
-	
 EXPORT_SYMBOL(snd_akm4xxx_build_controls);
 
 static int __init alsa_akm4xxx_module_init(void)
diff --git a/include/ak4xxx-adda.h b/include/ak4xxx-adda.h
index 891cf1a..030b87c 100644
--- a/include/ak4xxx-adda.h
+++ b/include/ak4xxx-adda.h
@@ -68,7 +68,7 @@ struct snd_akm4xxx {
 	enum {
 		SND_AK4524, SND_AK4528, SND_AK4529,
 		SND_AK4355, SND_AK4358, SND_AK4381,
-		SND_AK5365
+		SND_AK5365, SND_AK4620,
 	} type;
 
 	/* (array) information of combined codecs */
@@ -76,6 +76,9 @@ struct snd_akm4xxx {
 	const struct snd_akm4xxx_adc_channel *adc_info;
 
 	struct snd_ak4xxx_ops ops;
+	unsigned int num_chips;
+	unsigned int total_regs;
+	const char *name;
 };
 
 void snd_akm4xxx_write(struct snd_akm4xxx *ak, int chip, unsigned char reg,
diff --git a/pci/ice1712/juli.c b/pci/ice1712/juli.c
index fd948bf..4789e8b 100644
--- a/pci/ice1712/juli.c
+++ b/pci/ice1712/juli.c
@@ -412,25 +412,6 @@ static struct snd_kcontrol_new juli_mute_controls[] __devinitdata = {
 	},
 };
 
-
-static void ak4358_proc_regs_read(struct snd_info_entry *entry,
-		struct snd_info_buffer *buffer)
-{
-	struct snd_ice1712 *ice = (struct snd_ice1712 *)entry->private_data;
-	int reg, val;
-	for (reg = 0; reg <= 0xf; reg++) {
-		val =  snd_akm4xxx_get(ice->akm, 0, reg);
-		snd_iprintf(buffer, "0x%02x = 0x%02x\n", reg, val);
-	}
-}
-
-static void ak4358_proc_init(struct snd_ice1712 *ice)
-{
-	struct snd_info_entry *entry;
-	if (!snd_card_proc_new(ice->card, "ak4358_codec", &entry))
-		snd_info_set_text_ops(entry, ice, ak4358_proc_regs_read);
-}
-
 static char *slave_vols[] __devinitdata = {
 	PCM_VOLUME,
 	MONITOR_AN_IN_VOLUME,
@@ -496,8 +477,6 @@ static int __devinit juli_add_controls(struct snd_ice1712 *ice)
 	/* only capture SPDIF over AK4114 */
 	err = snd_ak4114_build(spec->ak4114, NULL,
 			ice->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream);
-
-	ak4358_proc_init(ice);
 	if (err < 0)
 		return err;
 	return 0;
-- 
1.5.6.3
