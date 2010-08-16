From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Fix WM8580 CLKSEL mask selection
Date: Mon, 16 Aug 2010 19:28:32 +0100
Message-ID: <1281983313-4636-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB288103838
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 20:28:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

The RX and TX directions were inverted.

Reported-by: Seungwhan Youn <claude.youn@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index af4517e..42a6699 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -703,12 +703,12 @@ static int wm8580_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	int sel, sel_mask, sel_shift;
 
 	switch (dai->driver->id) {
-	case WM8580_DAI_PAIFTX:
+	case WM8580_DAI_PAIFRX:
 		sel_mask = 0x3;
 		sel_shift = 0;
 		break;
 
-	case WM8580_DAI_PAIFRX:
+	case WM8580_DAI_PAIFTX:
 		sel_mask = 0xc;
 		sel_shift = 2;
 		break;
-- 
1.7.1
