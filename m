From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ASoC: Remove unused rate selection
	bitmasks from WM8580
Date: Fri, 13 Aug 2010 20:35:03 +0100
Message-ID: <1281728107-25386-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13740103901
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:35:13 +0200 (CEST)
In-Reply-To: <20100813193305.GB3778@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

In the case of the BCLK rate the defines are at best misleading anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 4f41419..9964f02 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -112,19 +112,7 @@
 
 /* AIF control 1 (registers 9h-bh) */
 #define WM8580_AIF_RATE_MASK       0x7
-#define WM8580_AIF_RATE_128        0x0
-#define WM8580_AIF_RATE_192        0x1
-#define WM8580_AIF_RATE_256        0x2
-#define WM8580_AIF_RATE_384        0x3
-#define WM8580_AIF_RATE_512        0x4
-#define WM8580_AIF_RATE_768        0x5
-#define WM8580_AIF_RATE_1152       0x6
-
 #define WM8580_AIF_BCLKSEL_MASK   0x18
-#define WM8580_AIF_BCLKSEL_64     0x00
-#define WM8580_AIF_BCLKSEL_128    0x08
-#define WM8580_AIF_BCLKSEL_256    0x10
-#define WM8580_AIF_BCLKSEL_SYSCLK 0x18
 
 #define WM8580_AIF_MS             0x20
 
-- 
1.7.1
