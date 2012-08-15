From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCHv2.1-CA0132 HDA Codec 1/1] Draft DSP loader
	update #2
Date: Tue, 14 Aug 2012 22:50:06 -0700
Message-ID: <1345009806-3293-1-git-send-email-ian_minett@creativelabs.com>
References: <s5hobmh9a1f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hobmh9a1f.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Thanks for the recent feedback - based on that we've updated the recent 
draft patch for adding the DSP loader to patch_ca0132.c :

- move DMA buffer management out (to be handled in hda_intel)
- add call to cleanup DMA
- change start/stop flag to boolean

If the changes look acceptable, do we have enough for us to get started on 
adding the DSP loader updates to patch_ca0132 (working with the 'from scratch' 
CA0132 as you suggested)? 

Please let us know if you can think of anything else that needs to be worked
out, or anything we need to provide for the bus op mods.

Thanks very much,
Ian

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 45dce9c..0d07445 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1979,22 +1979,22 @@ static int dma_convert_to_hda_format(
 
 static int dma_set_state(struct dma_engine *dma, enum dma_state state)
 {
-	int cmd;
+	bool cmd;
 
 	CA0132_LOG("dma_set_state state=%d\n", state);
 
 	switch (state) {
 	case DMA_STATE_STOP:
-		cmd = SNDRV_PCM_TRIGGER_STOP;
+		cmd = false;
 		break;
 	case DMA_STATE_RUN:
-		cmd = SNDRV_PCM_TRIGGER_START;
+		cmd = true;
 		break;
 	default:
 		return 0;
 	}
 
-	return load_dsp_trigger(dma->codec->bus, cmd);
+	return snd_hda_codec_load_dsp_trigger(dma->codec, cmd);
 }
 
 static unsigned int dma_get_buffer_size(struct dma_engine *dma)
@@ -2281,10 +2281,8 @@ static int dspxfr_image(struct hda_codec *codec,
 		return -1;
 
 	dma_engine = kzalloc(sizeof(*dma_engine), GFP_KERNEL);
-	if (!dma_engine) {
-		status = -ENOMEM;
-		goto exit;
-	}
+	if (!dma_engine)
+		return -ENOMEM;
 	memset((void*)dma_engine, 0, sizeof(*dma_engine));
 	
 	dma_engine->codec = codec;
@@ -2292,12 +2290,6 @@ static int dspxfr_image(struct hda_codec *codec,
 	dma_engine->m_converter_format = hda_format;
 	dma_engine->m_buffer_size =
 	      ovly ? DSP_DMA_WRITE_BUFLEN_OVLY : DSP_DMA_WRITE_BUFLEN_INIT;
-	dma_engine->m_buffer_addr = kzalloc(dma_engine->m_buffer_size,
-					    GFP_KERNEL);
-	if (!dma_engine->m_buffer_addr) {
-		status = -ENOMEM;
-		goto exit;
-	}
 
 	dma_chan = 0;
 	do {
@@ -2308,11 +2300,11 @@ static int dspxfr_image(struct hda_codec *codec,
 			break;
 		}
 
-		status = load_dsp_prepare(codec->bus, 
-					 dma_engine->m_converter_format,
-					 dma_engine->m_buffer_addr,
-					 dma_engine->m_buffer_size);
-		if (FAILED(status))
+		dma_engine->m_buffer_addr =
+		snd_hda_codec_load_dsp_prepare(codec,
+						dma_engine->m_converter_format,
+						dma_engine->m_buffer_size);
+		if (!dma_engine->m_buffer_addr)
 			break;
 
 		if (ovly) {
@@ -2372,8 +2364,9 @@ static int dspxfr_image(struct hda_codec *codec,
 	if (ovly && (dma_chan != INVALID_DMA_CHANNEL))
 		status = dspio_free_dma_chan(codec, dma_chan);
 
-exit:
-	kfree(dma_engine->m_buffer_addr);
+	snd_hda_codec_load_dsp_cleanup(codec,
+				       dma_engine->m_buffer_addr,
+				       dma_engine->m_buffer_size);
 	kfree(dma_engine);
 
 	return status;
-- 
1.7.4.1
