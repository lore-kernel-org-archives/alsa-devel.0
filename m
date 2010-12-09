From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH] ASoC: WM8580: Fix R8 initial value
Date: Thu,  9 Dec 2010 18:07:52 +0900
Message-ID: <1291885672-7198-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 47F7E103806
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 10:24:45 +0100 (CET)
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
Cc: sbkim73@samsung.com, kgene.kim@samsung.com, broonie@opensource.wolfsonmicro.com, sw.youn@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Seungwhan Youn <sw.youn@samsung.com>

Acc to WM8580 manual, the default value for R8 is 0x10, not 0x1c.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/codecs/wm8580.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6e95332..6be373d 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -179,7 +179,7 @@
 static const u16 wm8580_reg[] = {
 	0x0121, 0x017e, 0x007d, 0x0014, /*R3*/
 	0x0121, 0x017e, 0x007d, 0x0194, /*R7*/
-	0x001c, 0x0002, 0x0002, 0x00c2, /*R11*/
+	0x0010, 0x0002, 0x0002, 0x00c2, /*R11*/
 	0x0182, 0x0082, 0x000a, 0x0024, /*R15*/
 	0x0009, 0x0000, 0x00ff, 0x0000, /*R19*/
 	0x00ff, 0x00ff, 0x00ff, 0x00ff, /*R23*/
-- 
1.6.2.5
