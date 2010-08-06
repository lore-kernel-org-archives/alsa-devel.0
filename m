From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 3/5] ASoC: wm8580: Fix Master Mode BCLK rates
	names
Date: Fri,  6 Aug 2010 09:26:07 +0900
Message-ID: <1281054367-4825-1-git-send-email-sw.youn@samsung.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DA32243D0
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 02:39:35 +0200 (CEST)
In-Reply-To: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch fix BCLK rates name from old manual. As a recently
wm8580 manual (Rel. March 2009, Rev 4.7), wm8580 supports 4
BCLK rates, 64, 32, 16 and System Clock per LRCLK. So, this
patch apply to match BCLK rates with manual.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/codecs/wm8580.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index e342da5..d282eb3 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -128,8 +128,8 @@
 
 #define WM8580_AIF_BCLKSEL_MASK   0x18
 #define WM8580_AIF_BCLKSEL_64     0x00
-#define WM8580_AIF_BCLKSEL_128    0x08
-#define WM8580_AIF_BCLKSEL_256    0x10
+#define WM8580_AIF_BCLKSEL_32     0x08
+#define WM8580_AIF_BCLKSEL_16     0x10
 #define WM8580_AIF_BCLKSEL_SYSCLK 0x18
 
 #define WM8580_AIF_MS             0x20
-- 
1.6.2.5
