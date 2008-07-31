From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 11/11] wss_lib: fix opti93x capture formats
	limitations
Date: Thu, 31 Jul 2008 21:11:46 +0200
Message-ID: <20080731211146.b9e35266.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 97A2E10381A
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 21:06:29 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Limit opti93x cards capture formats to only linear ones.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

No changes since the last version.

diff -urp linux-ref/sound/isa/wss/wss_lib.c linux-2.6.26/sound/isa/wss/wss_lib.c
--- linux-ref/sound/isa/wss/wss_lib.c	2008-07-31 19:30:47.000000000 +0200
+++ linux-2.6.26/sound/isa/wss/wss_lib.c	2008-07-31 19:30:56.000000000 +0200
@@ -1495,8 +1495,10 @@ static int snd_wss_capture_open(struct s
 
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
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e91
