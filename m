From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: dma-sh7760: cleanup a debug printk
Date: Tue, 18 Dec 2018 11:18:10 +0300
Message-ID: <20181218081810.GB32567@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id F2F0226782E
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 09:18:14 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The intent was to print the address as a hexadecimal but there is an
extra "u" in the "0x%08ulx" format specification so it is displayed as
decimal.

Fixes: aef3b06ac697 ("[ALSA] SH7760 ASoC support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/sh/dma-sh7760.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 922fb6aa3ed1..5aee11c94f2a 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -202,7 +202,7 @@ static int camelot_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct camelot_pcm *cam = &cam_pcm_data[rtd->cpu_dai->id];
 
-	pr_debug("PCM data: addr 0x%08ulx len %d\n",
+	pr_debug("PCM data: addr 0x%08lx len %d\n",
 		 (u32)runtime->dma_addr, runtime->dma_bytes);
  
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-- 
2.17.1
