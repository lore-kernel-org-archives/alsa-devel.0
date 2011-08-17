From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix backport of WM8994 thermal warning
Date: Wed, 17 Aug 2011 15:23:42 +0900
Message-ID: <1313562222-12282-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA0A91038A5
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 08:23:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/codecs/wm8994.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9412491..e537267 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3141,9 +3141,9 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	wm8994_request_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR,
 			   wm8994_fifo_error, "FIFO error", codec);
-	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN,
+	wm8994_request_irq(wm8994->control_data, WM8994_IRQ_TEMP_WARN,
 			   wm8994_temp_warn, "Thermal warning", codec);
-	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT,
+	wm8994_request_irq(wm8994->control_data, WM8994_IRQ_TEMP_SHUT,
 			   wm8994_temp_shut, "Thermal shutdown", codec);
 
 	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
-- 
1.7.5.4
