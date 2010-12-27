From: andi@lisas.de
Subject: [patch 4/6] sound azt3328: use a helper variable to
 remove one indirection in hotpath
Date: Mon, 27 Dec 2010 21:17:11 +0100
Message-ID: <20101227201711.GE28432@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id EF30924703
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 21:17:11 +0100 (CET)
Content-Disposition: inline; filename=dma_base_indirection
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andreas Mohr <andi@lisas.de>

Index: linux-2.6/sound/pci/azt3328.c
===================================================================
--- linux-2.6.orig/sound/pci/azt3328.c	2010-12-27 14:29:16.686184335 -0500
+++ linux-2.6/sound/pci/azt3328.c	2010-12-27 14:29:18.816184335 -0500
@@ -294,6 +294,7 @@ MODULE_PARM_DESC(seqtimer_scaling, "Set 
 
 struct snd_azf3328_codec_data {
 	unsigned long io_base;
+	unsigned int dma_base; /* helper to avoid an indirection in hotpath */
 	struct snd_pcm_substream *substream;
 	bool running;
 	const char *name;
@@ -1165,14 +1166,17 @@ snd_azf3328_codec_setdmaa(struct snd_azf
 static int
 snd_azf3328_codec_prepare(struct snd_pcm_substream *substream)
 {
-#if 0
-	struct snd_azf3328 *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_azf3328_codec *codec = runtime->private_data;
+#if 0
         unsigned int size = snd_pcm_lib_buffer_bytes(substream);
 	unsigned int count = snd_pcm_lib_period_bytes(substream);
 #endif
 
 	snd_azf3328_dbgcallenter();
+
+	codec->dma_base = runtime->dma_addr;
+
 #if 0
 	snd_azf3328_codec_setfmt(chip, AZF_CODEC_...,
 		runtime->rate,
@@ -1370,18 +1374,17 @@ snd_azf3328_codec_pointer(struct snd_pcm
 {
 	const struct snd_azf3328 *chip = snd_pcm_substream_chip(substream);
 	const struct snd_azf3328_codec_data *codec = &chip->codecs[codec_type];
-	unsigned long bufptr, result;
+	unsigned long result;
 	snd_pcm_uframes_t frmres;
 
-#ifdef QUERY_HARDWARE
-	bufptr = snd_azf3328_codec_inl(codec, IDX_IO_CODEC_DMA_START_1);
-#else
-	bufptr = substream->runtime->dma_addr;
-#endif
 	result = snd_azf3328_codec_inl(codec, IDX_IO_CODEC_DMA_CURRPOS);
 
 	/* calculate offset */
-	result -= bufptr;
+#ifdef QUERY_HARDWARE
+	result -= snd_azf3328_codec_inl(codec, IDX_IO_CODEC_DMA_START_1);
+#else
+	result -= codec->dma_base;
+#endif
 	frmres = bytes_to_frames( substream->runtime, result);
 	snd_azf3328_dbgcodec("%08li %s @ 0x%8lx, frames %8ld\n",
 				jiffies, codec->name, result, frmres);

-- 
