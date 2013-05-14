From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] ASoC: ep93xx-i2s: Staticize non exported
	struct
Date: Tue, 14 May 2013 22:19:47 +0200
Message-ID: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id E11382607B7
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <ryan@bluewatersys.com>
List-Id: alsa-devel@alsa-project.org

The ep93xx_i2s_dma_data struct is not used outside of ep93xx-i2s.c, so make it
static.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ryan Mallon <ryan@bluewatersys.com>
---
 sound/soc/cirrus/ep93xx-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index ef731e6..17ad70b 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -63,7 +63,7 @@ struct ep93xx_i2s_info {
 	void __iomem			*regs;
 };
 
-struct ep93xx_dma_data ep93xx_i2s_dma_data[] = {
+static struct ep93xx_dma_data ep93xx_i2s_dma_data[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = {
 		.name		= "i2s-pcm-out",
 		.port		= EP93XX_DMA_I2S1,
-- 
1.8.0
