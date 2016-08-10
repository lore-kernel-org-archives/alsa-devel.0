From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: atmel-pdmic: add missing
	clk_disable_unprepare() on error in atmel_pdmic_cpu_dai_startup()
Date: Wed, 10 Aug 2016 13:53:21 +0000
Message-ID: <1470837201-12232-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F1BC265A7F
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 15:53:29 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id g202so2916067pfb.1
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 06:53:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Wei Yongjun <weiyj.lk@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the missing clk_disable_unprepare() before return from
atmel_pdmic_cpu_dai_startup() in the error handling case.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 sound/soc/atmel/atmel-pdmic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 2a3a41f..a67e31b 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -115,8 +115,10 @@ static int atmel_pdmic_cpu_dai_startup(struct snd_pcm_substream *substream,
 		return ret;
 
 	ret =  clk_prepare_enable(dd->pclk);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(dd->gclk);
 		return ret;
+	}
 
 	/* Clear all bits in the Control Register(PDMIC_CR) */
 	regmap_write(dd->regmap, PDMIC_CR, 0);
