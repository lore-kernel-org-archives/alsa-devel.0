From: sware <microcontrolfreak@gmail.com>
Subject: Subject: [PATCH 1/1] set invalid dma channel to -1
 (and properly check for it) since 0 is not an invalid channel but -1 is.
Date: Wed, 31 Dec 2008 14:39:23 -0800
Message-ID: <495BF49B.1000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 07D0C1037EB
	for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2008 23:39:32 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so5336416rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2008 14:39:30 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA project mailing list <alsa-devel@alsa-project.org>, stephen.ware@eqware.net
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@sirena.org.uk>, Dennis O'Brien <dennis.obrien@eqware.net>
List-Id: alsa-devel@alsa-project.org

Set the invalid dma channel to -1 (and check properly for it) in pxa2xx_pcm_hw_free().
Was assuming 0 is an invalid channel number but 0 is a valid pxa dma channel num.

Signed-off-by: stephen <stephen.ware@eqware.net>
---
 sound/soc/pxa/pxa2xx-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index c670d08..53b9fb1 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -61,9 +61,9 @@ static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	__pxa2xx_pcm_hw_free(substream);
 
-	if (prtd->dma_ch) {
+	if (prtd->dma_ch >= 0) {
 		pxa_free_dma(prtd->dma_ch);
-		prtd->dma_ch = 0;
+		prtd->dma_ch = -1;
 	}
 
 	return 0;
-- 
1.5.4.3
