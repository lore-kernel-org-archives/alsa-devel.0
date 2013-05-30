From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm0010: Set IRQ as a wake source
Date: Thu, 30 May 2013 10:06:01 +0100
Message-ID: <1369904761-8355-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D60902650D5
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 11:16:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The DSPs IRQ should be a wake source as several of the possible
algorithms may run whilst the AP is asleepi and require to wake the AP
to push or pull more data, such as compressed playback.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 370af0c..b6df319 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -972,6 +972,13 @@ static int wm0010_spi_probe(struct spi_device *spi)
 	}
 	wm0010->irq = irq;
 
+	ret = irq_set_irq_wake(irq, 1);
+	if (ret) {
+		dev_err(wm0010->dev, "Failed to set IRQ %d as wake source: %d\n",
+			irq, ret);
+		return ret;
+	}
+
 	if (spi->max_speed_hz)
 		wm0010->board_max_spi_speed = spi->max_speed_hz;
 	else
-- 
1.7.2.5
