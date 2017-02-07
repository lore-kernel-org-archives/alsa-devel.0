From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: x86: Cache AUD_CONFIG register value
Date: Tue,  7 Feb 2017 17:37:59 +0100
Message-ID: <20170207163800.4039-2-tiwai@suse.de>
References: <20170207163800.4039-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CBAE266636
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 17:38:02 +0100 (CET)
In-Reply-To: <20170207163800.4039-1-tiwai@suse.de>
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

At enabling the audio, we modify AUD_CONFIG register bit 0.  So far,
it does read-modify-write procedure with a special hack for the
channel bits due to the silicon bug.  But we can optimize it by
remembering the AUD_CONFIG register value privately.  This simplifies
the things a lot.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 39 ++++++++++++---------------------------
 sound/x86/intel_hdmi_audio.h |  1 +
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 34750c54663a..15147fec1a7e 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -212,30 +212,13 @@ static void had_write_register(struct snd_intelhad *ctx, u32 reg, u32 val)
  * bad audio. The fix is to always write the AUD_CONFIG[6:4] with
  * appropriate value when doing read-modify of AUD_CONFIG register.
  */
-static void had_enable_audio(struct snd_pcm_substream *substream,
-			     struct snd_intelhad *intelhaddata,
+static void had_enable_audio(struct snd_intelhad *intelhaddata,
 			     bool enable)
 {
-	union aud_cfg cfg_val = {.regval = 0};
-	u8 channels;
-	u32 mask, val;
-
-	/*
-	 * If substream is NULL, there is no active stream.
-	 * In this case just set channels to 2
-	 */
-	channels = substream ? substream->runtime->channels : 2;
-	dev_dbg(intelhaddata->dev, "enable %d, ch=%d\n", enable, channels);
-
-	cfg_val.regx.num_ch = channels - 2;
-	if (enable)
-		cfg_val.regx.aud_en = 1;
-	mask = AUD_CONFIG_CH_MASK | 1;
-
-	had_read_register(intelhaddata, AUD_CONFIG, &val);
-	val &= ~mask;
-	val |= cfg_val.regval;
-	had_write_register(intelhaddata, AUD_CONFIG, val);
+	/* update the cached value */
+	intelhaddata->aud_config.regx.aud_en = enable;
+	had_write_register(intelhaddata, AUD_CONFIG,
+			   intelhaddata->aud_config.regval);
 }
 
 /* forcibly ACKs to both BUFFER_DONE and BUFFER_UNDERRUN interrupts */
@@ -360,6 +343,7 @@ static int had_init_audio_ctrl(struct snd_pcm_substream *substream,
 	}
 
 	had_write_register(intelhaddata, AUD_CONFIG, cfg_val.regval);
+	intelhaddata->aud_config = cfg_val;
 	return 0;
 }
 
@@ -1004,6 +988,7 @@ static void had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 
 	/* Handle Underrun interrupt within Audio Unit */
 	had_write_register(intelhaddata, AUD_CONFIG, 0);
+	intelhaddata->aud_config.regval = 0;
 	/* Reset buffer pointers */
 	had_reset_audio(intelhaddata);
 
@@ -1169,7 +1154,7 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 		/* Enable Audio */
 		had_ack_irqs(intelhaddata); /* FIXME: do we need this? */
-		had_enable_audio(substream, intelhaddata, true);
+		had_enable_audio(intelhaddata, true);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -1182,7 +1167,7 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		intelhaddata->stream_info.running = false;
 		spin_unlock(&intelhaddata->had_spinlock);
 		/* Disable Audio */
-		had_enable_audio(substream, intelhaddata, false);
+		had_enable_audio(intelhaddata, false);
 		/* Reset buffer pointers */
 		had_reset_audio(intelhaddata);
 		break;
@@ -1315,7 +1300,7 @@ static int had_process_mode_change(struct snd_intelhad *intelhaddata)
 		return 0;
 
 	/* Disable Audio */
-	had_enable_audio(substream, intelhaddata, false);
+	had_enable_audio(intelhaddata, false);
 
 	/* Update CTS value */
 	disp_samp_freq = intelhaddata->tmds_clock_speed;
@@ -1334,7 +1319,7 @@ static int had_process_mode_change(struct snd_intelhad *intelhaddata)
 		     n_param, intelhaddata);
 
 	/* Enable Audio */
-	had_enable_audio(substream, intelhaddata, true);
+	had_enable_audio(intelhaddata, true);
 
 out:
 	had_substream_put(intelhaddata);
@@ -1389,7 +1374,7 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	}
 
 	/* Disable Audio */
-	had_enable_audio(substream, intelhaddata, false);
+	had_enable_audio(intelhaddata, false);
 
 	intelhaddata->connected = false;
 	dev_dbg(intelhaddata->dev,
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index fe8d99cb839f..a96728a4e7bc 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -127,6 +127,7 @@ struct snd_intelhad {
 	int irq;
 	void __iomem *mmio_start;
 	unsigned int had_config_offset;
+	union aud_cfg aud_config;	/* AUD_CONFIG reg value cache */
 	struct work_struct hdmi_audio_wq;
 	struct mutex mutex; /* for protecting chmap and eld */
 };
-- 
2.11.0
