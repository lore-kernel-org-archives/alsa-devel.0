From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: x86: Don't check connection in
	lowlevel accessors
Date: Fri,  3 Feb 2017 17:43:59 +0100
Message-ID: <20170203164400.12983-4-tiwai@suse.de>
References: <20170203164400.12983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B8E25266B49
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 17:44:03 +0100 (CET)
In-Reply-To: <20170203164400.12983-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

The lowlevel register read/write don't have to be careful about the
connection state.  It should be checked in the caller side instead.
By dropping the check, we can simplify the code, and readability.

This patch also refacors the functions slightly: namely,
- drop the useless always-zero return values
- fold the inline functions to the main accessor functions themselves
- move the DP audio hack for AUD_CONFIG to the caller side
- simplify snd_intelhad_eanble_audio() and drop the unused
  had_read_modify()

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 91 ++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 66 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 9e08132fd332..c503f0de3975 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -186,69 +186,20 @@ static void had_substream_put(struct snd_intelhad *intelhaddata)
 }
 
 /* Register access functions */
-static inline void
-mid_hdmi_audio_read(struct snd_intelhad *ctx, u32 reg, u32 *val)
+static void had_read_register(struct snd_intelhad *ctx, u32 reg, u32 *val)
 {
 	*val = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
 }
 
-static inline void
-mid_hdmi_audio_write(struct snd_intelhad *ctx, u32 reg, u32 val)
+static void had_write_register(struct snd_intelhad *ctx, u32 reg, u32 val)
 {
 	iowrite32(val, ctx->mmio_start + ctx->had_config_offset + reg);
 }
 
-static int had_read_register(struct snd_intelhad *intelhaddata,
-			     u32 offset, u32 *data)
-{
-	if (!intelhaddata->connected)
-		return -ENODEV;
-
-	mid_hdmi_audio_read(intelhaddata, offset, data);
-	return 0;
-}
-
-static void fixup_dp_config(struct snd_intelhad *intelhaddata,
-			    u32 offset, u32 *data)
-{
-	if (intelhaddata->dp_output) {
-		if (offset == AUD_CONFIG && (*data & AUD_CONFIG_VALID_BIT))
-			*data |= AUD_CONFIG_DP_MODE | AUD_CONFIG_BLOCK_BIT;
-	}
-}
-
-static int had_write_register(struct snd_intelhad *intelhaddata,
-			      u32 offset, u32 data)
-{
-	if (!intelhaddata->connected)
-		return -ENODEV;
-
-	fixup_dp_config(intelhaddata, offset, &data);
-	mid_hdmi_audio_write(intelhaddata, offset, data);
-	return 0;
-}
-
-static int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
-			   u32 data, u32 mask)
-{
-	u32 val_tmp;
-
-	if (!intelhaddata->connected)
-		return -ENODEV;
-
-	mid_hdmi_audio_read(intelhaddata, offset, &val_tmp);
-	val_tmp &= ~mask;
-	val_tmp |= (data & mask);
-
-	fixup_dp_config(intelhaddata, offset, &val_tmp);
-	mid_hdmi_audio_write(intelhaddata, offset, val_tmp);
-	return 0;
-}
-
 /*
  * enable / disable audio configuration
  *
- * The had_read_modify() function should not directly be used on VLV2 for
+ * The normal read/modify should not directly be used on VLV2 for
  * updating AUD_CONFIG register.
  * This is because:
  * Bit6 of AUD_CONFIG register is writeonly due to a silicon bug on VLV2
@@ -265,24 +216,25 @@ static void snd_intelhad_enable_audio(struct snd_pcm_substream *substream,
 				      bool enable)
 {
 	union aud_cfg cfg_val = {.regval = 0};
-	u8 channels, data, mask;
+	u8 channels;
+	u32 mask, val;
 
 	/*
 	 * If substream is NULL, there is no active stream.
 	 * In this case just set channels to 2
 	 */
 	channels = substream ? substream->runtime->channels : 2;
-	cfg_val.regx.num_ch = channels - 2;
+	dev_dbg(intelhaddata->dev, "enable %d, ch=%d\n", enable, channels);
 
-	data = cfg_val.regval;
+	cfg_val.regx.num_ch = channels - 2;
 	if (enable)
-		data |= 1;
+		cfg_val.regx.aud_en = 1;
 	mask = AUD_CONFIG_CH_MASK | 1;
 
-	dev_dbg(intelhaddata->dev, "%s : data = %x, mask =%x\n",
-		__func__, data, mask);
-
-	had_read_modify(intelhaddata, AUD_CONFIG, data, mask);
+	had_read_register(intelhaddata, AUD_CONFIG, &val);
+	val &= ~mask;
+	val |= cfg_val.regval;
+	had_write_register(intelhaddata, AUD_CONFIG, val);
 }
 
 /* enable / disable the audio interface */
@@ -291,10 +243,10 @@ static void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
 	u32 status_reg;
 
 	if (enable) {
-		mid_hdmi_audio_read(ctx, AUD_HDMI_STATUS, &status_reg);
+		had_read_register(ctx, AUD_HDMI_STATUS, &status_reg);
 		status_reg |= HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
-		mid_hdmi_audio_write(ctx, AUD_HDMI_STATUS, status_reg);
-		mid_hdmi_audio_read(ctx, AUD_HDMI_STATUS, &status_reg);
+		had_write_register(ctx, AUD_HDMI_STATUS, status_reg);
+		had_read_register(ctx, AUD_HDMI_STATUS, &status_reg);
 	}
 }
 
@@ -399,6 +351,13 @@ static int snd_intelhad_audio_ctrl(struct snd_pcm_substream *substream,
 		cfg_val.regx.layout = LAYOUT1;
 
 	cfg_val.regx.val_bit = 1;
+
+	/* fix up the DP bits */
+	if (intelhaddata->dp_output) {
+		cfg_val.regx.dp_modei = 1;
+		cfg_val.regx.set = 1;
+	}
+
 	had_write_register(intelhaddata, AUD_CONFIG, cfg_val.regval);
 	return 0;
 }
@@ -1682,15 +1641,15 @@ static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 	u32 audio_stat, audio_reg;
 
 	audio_reg = AUD_HDMI_STATUS;
-	mid_hdmi_audio_read(ctx, audio_reg, &audio_stat);
+	had_read_register(ctx, audio_reg, &audio_stat);
 
 	if (audio_stat & HDMI_AUDIO_UNDERRUN) {
-		mid_hdmi_audio_write(ctx, audio_reg, HDMI_AUDIO_UNDERRUN);
+		had_write_register(ctx, audio_reg, HDMI_AUDIO_UNDERRUN);
 		had_process_buffer_underrun(ctx);
 	}
 
 	if (audio_stat & HDMI_AUDIO_BUFFER_DONE) {
-		mid_hdmi_audio_write(ctx, audio_reg, HDMI_AUDIO_BUFFER_DONE);
+		had_write_register(ctx, audio_reg, HDMI_AUDIO_BUFFER_DONE);
 		had_process_buffer_done(ctx);
 	}
 
-- 
2.11.0
