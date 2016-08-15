From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2] ASoC: atmel_ssc_dai: Don't unconditionally
	reset SSC on stream startup
Date: Mon, 15 Aug 2016 18:59:25 +0200
Message-ID: <1471280365-23452-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B64266706
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 18:59:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Christoph Huber <c.huber@bct-electronic.com>, Songjun Wu <songjun.wu@microchip.com>
List-Id: alsa-devel@alsa-project.org

From: Christoph Huber <c.huber@bct-electronic.com>

commit cbaadf0f90d6 ("ASoC: atmel_ssc_dai: refactor the startup and
shutdown") refactored code such that the SSC is reset on every
startup; this breaks duplex audio (e.g. first start audio playback,
then start record, causing the playback to stop/hang)

Signed-off-by: Christoph Huber <c.huber@bct-electronic.com>
Signed-off-by: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>
Cc: Songjun Wu <songjun.wu@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
v2 fixes formatting issues and rephrases the comment

 sound/soc/atmel/atmel_ssc_dai.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 54c09ac..16e459a 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -299,8 +299,9 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	clk_enable(ssc_p->ssc->clk);
 	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
 
-	/* Reset the SSC to keep it at a clean status */
-	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+	/* Reset the SSC unless initialized to keep it in a clean state */
+	if (!ssc_p->initialized)
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dir = 0;
-- 
1.7.10.4
