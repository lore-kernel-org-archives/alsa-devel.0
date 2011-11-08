From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Disable debounce on some WM8962
	interrupts
Date: Tue,  8 Nov 2011 15:22:38 +0000
Message-ID: <1320765758-16382-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A8541038E8
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 16:22:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow them to work when the device is unclocked.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index aa310a2..5d1704d 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -4059,6 +4059,12 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	/* Stereo control for EQ */
 	snd_soc_update_bits(codec, WM8962_EQ1, WM8962_EQ_SHARED_COEFF, 0);
 
+	/* Don't debouce interrupts so we don't need SYSCLK */
+	snd_soc_update_bits(codec, WM8962_IRQ_DEBOUNCE,
+			    WM8962_FLL_LOCK_DB | WM8962_PLL3_LOCK_DB |
+			    WM8962_PLL2_LOCK_DB | WM8962_TEMP_SHUT_DB,
+			    0);
+
 	wm8962_add_widgets(codec);
 
 	/* Save boards having to disable DMIC when not in use */
-- 
1.7.7.1
