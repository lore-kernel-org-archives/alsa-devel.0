From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] sound: soc: atmel: Don't unconditionally reset
	SSC on stream startup
Date: Wed, 10 Aug 2016 12:14:22 +0200
Message-ID: <20160810101422.2086-1-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 08F6B265D63
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 12:18:11 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Songjun Wu <songjun.wu@microchip.com>, Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>, Christoph Huber <c.huber@bct-electronic.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Christoph Huber <c.huber@bct-electronic.com>

commit cbaadf0f90d6 (ASoC: atmel_ssc_dai: refactor the startup and shutdown)
refactored code such that the SSC is reset on every startup;
this breaks duplex audio (e.g. first start audio playback, then start record,
causing the playback to stop/hang)

Signed-off-by: Christoph Huber <c.huber@bct-electronic.com>
Signed-off-by: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>
Cc: Songjun Wu <songjun.wu@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 841d059..b3e9f0c 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -298,8 +298,9 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	clk_enable(ssc_p->ssc->clk);
 	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
 
-	/* Reset the SSC to keep it at a clean status */
-	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+	/* Reset the SSC if it is not initialized to keep it at a clean status */
+	if(!ssc_p->initialized)
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dir = 0;
-- 
2.1.4
