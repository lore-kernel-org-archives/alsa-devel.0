From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/8] ALSA: x86: Avoid register accesses during
	disconnection
Date: Wed, 15 Feb 2017 22:29:33 +0100
Message-ID: <20170215212936.697-6-tiwai@suse.de>
References: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 380EF266E59
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 22:29:44 +0100 (CET)
In-Reply-To: <20170215212936.697-1-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

It seems that accessing registers during disconnection often leads to
the GPU pipe error.  The original driver had a similar check in the
past, but it was lost through refactoring.  Now put a connection check
in the register access functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 71f01204a590..97362233c326 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -192,12 +192,16 @@ static void had_substream_put(struct snd_intelhad *intelhaddata)
 /* Register access functions */
 static void had_read_register(struct snd_intelhad *ctx, u32 reg, u32 *val)
 {
-	*val = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
+	if (!ctx->connected)
+		*val = 0;
+	else
+		*val = ioread32(ctx->mmio_start + ctx->had_config_offset + reg);
 }
 
 static void had_write_register(struct snd_intelhad *ctx, u32 reg, u32 val)
 {
-	iowrite32(val, ctx->mmio_start + ctx->had_config_offset + reg);
+	if (ctx->connected)
+		iowrite32(val, ctx->mmio_start + ctx->had_config_offset + reg);
 }
 
 /*
@@ -229,6 +233,8 @@ static void had_ack_irqs(struct snd_intelhad *ctx)
 {
 	u32 status_reg;
 
+	if (!ctx->connected)
+		return;
 	had_read_register(ctx, AUD_HDMI_STATUS, &status_reg);
 	status_reg |= HDMI_AUDIO_BUFFER_DONE | HDMI_AUDIO_UNDERRUN;
 	had_write_register(ctx, AUD_HDMI_STATUS, status_reg);
@@ -998,7 +1004,7 @@ static void wait_clear_underrun_bit(struct snd_intelhad *intelhaddata)
  */
 static void had_do_reset(struct snd_intelhad *intelhaddata)
 {
-	if (!intelhaddata->need_reset)
+	if (!intelhaddata->need_reset || !intelhaddata->connected)
 		return;
 
 	/* Reset buffer pointers */
-- 
2.11.1
