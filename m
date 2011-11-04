From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Don't use wm8994->control_data when
	requesting IRQs
Date: Fri,  4 Nov 2011 15:53:48 +0000
Message-ID: <1320422029-31624-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320422029-31624-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E105B248A5
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 16:53:52 +0100 (CET)
In-Reply-To: <1320422029-31624-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Abraham <thomas.abraham@linaro.org>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The field is no longer initialised so this will crash if running on
wm8958.

Reported-by: Thomas Abraham <thomas.abraham@linaro.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 3d2c3d4..9cb16cc 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3180,9 +3180,9 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	wm8994_request_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR,
 			   wm8994_fifo_error, "FIFO error", codec);
-	wm8994_request_irq(wm8994->control_data, WM8994_IRQ_TEMP_WARN,
+	wm8994_request_irq(codec->control_data, WM8994_IRQ_TEMP_WARN,
 			   wm8994_temp_warn, "Thermal warning", codec);
-	wm8994_request_irq(wm8994->control_data, WM8994_IRQ_TEMP_SHUT,
+	wm8994_request_irq(codec->control_data, WM8994_IRQ_TEMP_SHUT,
 			   wm8994_temp_shut, "Thermal shutdown", codec);
 
 	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
-- 
1.7.7.1
