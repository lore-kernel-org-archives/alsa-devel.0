From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 33/53] ALSA: x86: Drop had_get_hwstate()
Date: Thu,  2 Feb 2017 18:02:47 +0100
Message-ID: <20170202170307.24484-35-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 22AC2267591
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:18 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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

The helper function isn't clearer than the plain condition check
"if (drv_status == HDA_DRV_DISCONNECTED)".  By expanding this, the
compiler could even catch the possible uninitialized cases, so we
could fix them, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 835e0f2c4f0b..7c6549a10c1c 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -155,15 +155,6 @@ static const struct snd_pcm_hardware snd_intel_hadstream = {
 };
 
 /* Register access functions */
-static int had_get_hwstate(struct snd_intelhad *intelhaddata)
-{
-	/* Check for device presence -SW state */
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
-		return -ENODEV;
-
-	return 0;
-}
-
 static inline void
 mid_hdmi_audio_read(struct snd_intelhad *ctx, u32 reg, u32 *val)
 {
@@ -179,11 +170,8 @@ mid_hdmi_audio_write(struct snd_intelhad *ctx, u32 reg, u32 val)
 static int had_read_register(struct snd_intelhad *intelhaddata,
 			     u32 offset, u32 *data)
 {
-	int retval;
-
-	retval = had_get_hwstate(intelhaddata);
-	if (retval)
-		return retval;
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+		return -ENODEV;
 
 	mid_hdmi_audio_read(intelhaddata, offset, data);
 	return 0;
@@ -201,11 +189,8 @@ static void fixup_dp_config(struct snd_intelhad *intelhaddata,
 static int had_write_register(struct snd_intelhad *intelhaddata,
 			      u32 offset, u32 data)
 {
-	int retval;
-
-	retval = had_get_hwstate(intelhaddata);
-	if (retval)
-		return retval;
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+		return -ENODEV;
 
 	fixup_dp_config(intelhaddata, offset, &data);
 	mid_hdmi_audio_write(intelhaddata, offset, data);
@@ -216,11 +201,9 @@ static int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
 			   u32 data, u32 mask)
 {
 	u32 val_tmp;
-	int retval;
 
-	retval = had_get_hwstate(intelhaddata);
-	if (retval)
-		return retval;
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+		return -ENODEV;
 
 	mid_hdmi_audio_read(intelhaddata, offset, &val_tmp);
 	val_tmp &= ~mask;
@@ -930,7 +913,7 @@ static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param,
 
 static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 {
-	u32 hdmi_status, i = 0;
+	u32 hdmi_status = 0, i = 0;
 
 	/* Handle Underrun interrupt within Audio Unit */
 	had_write_register(intelhaddata, AUD_CONFIG, 0);
@@ -977,7 +960,7 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 
 	pm_runtime_get(intelhaddata->dev);
 
-	if (had_get_hwstate(intelhaddata)) {
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
 			__func__);
 		retval = -ENODEV;
@@ -1185,7 +1168,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* Disable local INTRs till register prgmng is done */
-		if (had_get_hwstate(intelhaddata)) {
+		if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 			dev_dbg(intelhaddata->dev,
 				"_START: HDMI cable plugged-out\n");
 			retval = -ENODEV;
@@ -1245,7 +1228,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 	had_stream = &intelhaddata->stream_data;
 
-	if (had_get_hwstate(intelhaddata)) {
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
 			__func__);
 		retval = -ENODEV;
@@ -1329,6 +1312,9 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+		return SNDRV_PCM_POS_XRUN;
+
 	if (intelhaddata->flag_underrun) {
 		intelhaddata->flag_underrun = false;
 		return SNDRV_PCM_POS_XRUN;
@@ -1614,7 +1600,7 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 
 	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
 
-	if (had_get_hwstate(intelhaddata)) {
+	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "HDMI cable plugged-out\n");
 		return 0;
 	}
-- 
2.11.0
