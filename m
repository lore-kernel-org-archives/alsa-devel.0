From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss: fix capture formats limitations
Date: Sun, 20 Jul 2008 20:14:52 +0200
Message-ID: <20080720201452.d4155736.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id B1C8924492
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 20:10:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix copy-paste error with Interwave instead of ad1848
chip condition.
Limit opti93x cards capture formats to only linear ones.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

Thank you Rene for collecting, testing and reviewing my
patches. I found one mistake in the series and this patch
fixes it.

I have also limited capture formats for opti93x chips because
the opti93x manual states that it supports mu-law, a-law and 
ADPCM decompression. The word "decompression" probably 
suggest that compression (recording) is not possible as its
manufacturer could just state the card supported mu-law, a-law 
and ADPCM.

Regards,
Krzysztof

diff -urp linux-alsa/sound/isa/wss/wss_lib.c linux-mm/sound/isa/wss/wss_lib.c
--- linux-alsa/sound/isa/wss/wss_lib.c	2008-07-18 22:47:02.056943647 +0200
+++ linux-mm/sound/isa/wss/wss_lib.c	2008-07-18 22:56:38.200949874 +0200
@@ -1460,14 +1460,16 @@ static int snd_wss_capture_open(struct s
 	runtime->hw = snd_wss_capture;
 
 	/* hardware limitation of older chipsets */
-	if (chip->hardware == WSS_HW_INTERWAVE && chip->dma1 > 3)
+	if (chip->hardware & WSS_HW_AD1848_MASK)
 		runtime->hw.formats &= ~(SNDRV_PCM_FMTBIT_IMA_ADPCM |
 					 SNDRV_PCM_FMTBIT_S16_BE);
 
 	/* hardware limitation of cheap chips */
 	if (chip->hardware == WSS_HW_CS4235 ||
-	    chip->hardware == WSS_HW_CS4239)
-		runtime->hw.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE;
+	    chip->hardware == WSS_HW_CS4239 ||
+	    chip->hardware == WSS_HW_OPTI93X)
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_U8 |
+				      SNDRV_PCM_FMTBIT_S16_LE;
 
 	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.buffer_bytes_max);
 	snd_pcm_limit_isa_dma_size(chip->dma2, &runtime->hw.period_bytes_max);

----------------------------------------------------------------------
W kosciele tez zdarzaja sie wpadki!
Smieszny filmik >>> http://link.interia.pl/f1e61
