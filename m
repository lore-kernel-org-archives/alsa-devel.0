From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/5] ASoC: Fix compile error for nuc900-pcm.c
Date: Mon, 29 Nov 2010 17:40:53 +0800
Message-ID: <1291023653.22911.6.camel@mola>
References: <1291023491.22911.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291023491.22911.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wan ZongShun <mcuos.com@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch fixes below error:

  CC      sound/soc/nuc900/nuc900-pcm.o
sound/soc/nuc900/nuc900-pcm.c: In function 'nuc900_dma_open':
sound/soc/nuc900/nuc900-pcm.c:267: error: 'nuc900_ac97_data' undeclared (first use in this function)
sound/soc/nuc900/nuc900-pcm.c:267: error: (Each undeclared identifier is reported only once
sound/soc/nuc900/nuc900-pcm.c:267: error: for each function it appears in.)
sound/soc/nuc900/nuc900-pcm.c: At top level:
sound/soc/nuc900/nuc900-pcm.c:337: error: expected ',' or ';' before 'static'
sound/soc/nuc900/nuc900-pcm.c:354: error: 'nuc900_soc_platform_probe' undeclared here (not in a function)
make[3]: *** [sound/soc/nuc900/nuc900-pcm.o] Error 1
make[2]: *** [sound/soc/nuc900] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/nuc900/nuc900-audio.h |    2 ++
 sound/soc/nuc900/nuc900-pcm.c   |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-audio.h b/sound/soc/nuc900/nuc900-audio.h
index aeed8ea..59f7e8e 100644
--- a/sound/soc/nuc900/nuc900-audio.h
+++ b/sound/soc/nuc900/nuc900-audio.h
@@ -110,4 +110,6 @@ struct nuc900_audio {
 
 };
 
+extern struct nuc900_audio *nuc900_ac97_data;
+
 #endif /*end _NUC900_AUDIO_H */
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 195d1ac..2245f8b 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -332,7 +332,7 @@ static struct snd_soc_platform_driver nuc900_soc_platform = {
 	.ops		= &nuc900_dma_ops,
 	.pcm_new	= nuc900_dma_new,
 	.pcm_free	= nuc900_dma_free_dma_buffers,
-}
+};
 
 static int __devinit nuc900_soc_platform_probe(struct platform_device *pdev)
 {
-- 
1.7.2
