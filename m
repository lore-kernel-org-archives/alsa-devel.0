From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] sound: atmel: trivial code cleanup
Date: Mon,  7 Jun 2010 15:03:40 +0200
Message-ID: <1275915820-17798-1-git-send-email-nicolas.ferre@atmel.com>
References: <AANLkTikXHk_E8-F4OGsuAF6JFhgxjs3genWsY_ko2ohZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B7FA1037F5
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 13:58:16 +0200 (CEST)
In-Reply-To: <AANLkTikXHk_E8-F4OGsuAF6JFhgxjs3genWsY_ko2ohZ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
Cc: mcuos.com@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Wan ZongShun <mcuos.com@gmail.com>

Remove break after return, it is not needed.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0b59806..c85844d 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -549,7 +549,6 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		printk(KERN_WARNING "atmel_ssc_dai: unsupported DAI format 0x%x\n",
 			ssc_p->daifmt);
 		return -EINVAL;
-		break;
 	}
 	pr_debug("atmel_ssc_hw_params: "
 			"RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n",
-- 
1.5.6.5
