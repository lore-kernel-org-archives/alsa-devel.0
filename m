From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: x86: Rename had_enable_audio_int()
	to had_ack_irqs()
Date: Tue,  7 Feb 2017 09:45:05 +0100
Message-ID: <20170207084505.18134-2-tiwai@suse.de>
References: <20170207084505.18134-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F4199266F7F
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 09:45:10 +0100 (CET)
In-Reply-To: <20170207084505.18134-1-tiwai@suse.de>
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

had_enable_audio_int() came from the LPE audio shell set_caps
callback with ENABLE_INT and DISABLE_INT caps.  I interpreted as these
correspond to enabling / disabling the audio interface, but the actual
implementation is only to clear (send ACK) to both BUFFER_DONE and
BUFFER_UNDERRUN interrupts unconditionally.  And, there is no
counterpart, DISABLE_INT, code at all.

For avoiding the further misunderstanding, rename the function to the
more fitting one, had_ack_irqs(), and drop the calls with enable=false
in allover places.  There is no functional changes at all.

After this patch, there is only one caller at the PCM trigger start.
Then it's doubtful whether this call is still really needed or not; I
bet it not, but let's stay in the safer side for now and keep it as
was.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 11ee4dddc5dd..8506a3dc0298 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -238,17 +238,15 @@ static void had_enable_audio(struct snd_pcm_substream *substream,
 	had_write_register(intelhaddata, AUD_CONFIG, val);
 }
 
-/* enable / disable the audio interface */
-static void had_enable_audio_int(struct snd_intelhad *ctx, bool enable)
+/* forcibly ACKs to both BUFFER_DONE and BUFFER_UNDERRUN interrupts */
+static void had_ack_irqs(struct snd_intelhad *ctx)
 {
 	u32 status_reg;
 
-	if (enable) {
-		had_read_register(ctx, AUD_HDMI_STATUS, &status_reg);
-		status_reg |= HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
-		had_write_register(ctx, AUD_HDMI_STATUS, status_reg);
-		had_read_register(ctx, AUD_HDMI_STATUS, &status_reg);
-	}
+	had_read_register(ctx, AUD_HDMI_STATUS, &status_reg);
+	status_reg |= HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
+	had_write_register(ctx, AUD_HDMI_STATUS, status_reg);
+	had_read_register(ctx, AUD_HDMI_STATUS, &status_reg);
 }
 
 /* Reset buffer pointers */
@@ -1169,7 +1167,7 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		intelhaddata->stream_info.running = true;
 
 		/* Enable Audio */
-		had_enable_audio_int(intelhaddata, true);
+		had_ack_irqs(intelhaddata); /* FIXME: do we need this? */
 		had_enable_audio(substream, intelhaddata, true);
 		break;
 
@@ -1183,11 +1181,9 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		intelhaddata->stream_info.running = false;
 		spin_unlock(&intelhaddata->had_spinlock);
 		/* Disable Audio */
-		had_enable_audio_int(intelhaddata, false);
 		had_enable_audio(substream, intelhaddata, false);
 		/* Reset buffer pointers */
 		had_reset_audio(intelhaddata);
-		had_enable_audio_int(intelhaddata, false);
 		break;
 
 	default:
@@ -1392,7 +1388,6 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	}
 
 	/* Disable Audio */
-	had_enable_audio_int(intelhaddata, false);
 	had_enable_audio(substream, intelhaddata, false);
 
 	intelhaddata->connected = false;
@@ -1802,8 +1797,6 @@ static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 {
 	struct snd_intelhad *ctx = platform_get_drvdata(pdev);
 
-	if (ctx->connected)
-		had_enable_audio_int(ctx, false);
 	snd_card_free(ctx->card);
 	return 0;
 }
-- 
2.11.0
