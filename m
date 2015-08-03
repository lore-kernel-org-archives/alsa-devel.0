From: Joe Perches <joe@perches.com>
Subject: [TRIVIAL PATCH V2] ASoC: atmel_ssc_dai: Correct misuse
 of 0x%<decimal>
Date: Mon, 03 Aug 2015 10:49:29 -0700
Message-ID: <1438624169.16753.5.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0097.hostedemail.com
 [216.40.44.97]) by alsa0.perex.cz (Postfix) with ESMTP id 37B982605D6
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 19:49:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Correct misuse of 0x%d in logging message.

Signed-off-by: Joe Perches <joe@perches.com>
---

Resend with later, non-broken version of Evolution email client (3.16 -> 3.16.3)

 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 841d059..ba8def5 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -290,7 +290,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	int dir, dir_mask;
 	int ret;
 
-	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
+	pr_debug("atmel_ssc_startup: SSC_SR=0x%x\n",
 		ssc_readl(ssc_p->ssc->regs, SR));
 
 	/* Enable PMC peripheral clock for this SSC */
