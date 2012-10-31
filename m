From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs-pcm: Fix fifo size
Date: Wed, 31 Oct 2012 15:02:49 -0200
Message-ID: <1351702969-27793-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f51.google.com (mail-yh0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E1D73261694
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 18:03:01 +0100 (CET)
Received: by mail-yh0-f51.google.com with SMTP id n12so304074yhn.38
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 10:03:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

According to MX28 Reference Manual the SAIF FIFO contains 4-bytes.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index f82d766..6b360d0 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -60,7 +60,7 @@ static struct snd_pcm_hardware snd_mxs_hardware = {
 	.periods_min		= 1,
 	.periods_max		= 52,
 	.buffer_bytes_max	= 64 * 1024,
-	.fifo_size		= 32,
+	.fifo_size		= 4,
 
 };
 
-- 
1.7.9.5
