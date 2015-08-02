From: Joe Perches <joe@perches.com>
Subject: [TRIVIAL PATCH] ASoC: atmel_ssc_dai: Correct misuse of 0x%<decimal>
Date: Sun, 02 Aug 2015 13:22:29 -0700
Message-ID: <1438546949.29569.2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Correct misuse of 0x%d in logging message.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 841d059..ba8def5 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -290,7 +290,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
        int dir, dir_mask;
        int ret;
 
-       pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
+       pr_debug("atmel_ssc_startup: SSC_SR=0x%x\n",
                ssc_readl(ssc_p->ssc->regs, SR));
 
        /* Enable PMC peripheral clock for this SSC */
