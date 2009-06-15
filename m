From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Remove odd bit clock ratios for
	WM8903
Date: Mon, 15 Jun 2009 10:32:59 +0100
Message-ID: <1245058382-30813-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090615093223.GA30743@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59BA11037FD
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 11:33:03 +0200 (CEST)
In-Reply-To: <20090615093223.GA30743@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

These are not supported since performance can not be guaranteed
when they are in use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: stable@kernel.org
---
 sound/soc/codecs/wm8903.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index d8a9222..e8d2e3e 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1257,22 +1257,18 @@ static struct {
 	int div;
 } bclk_divs[] = {
 	{  10,  0 },
-	{  15,  1 },
 	{  20,  2 },
 	{  30,  3 },
 	{  40,  4 },
 	{  50,  5 },
-	{  55,  6 },
 	{  60,  7 },
 	{  80,  8 },
 	{ 100,  9 },
-	{ 110, 10 },
 	{ 120, 11 },
 	{ 160, 12 },
 	{ 200, 13 },
 	{ 220, 14 },
 	{ 240, 15 },
-	{ 250, 16 },
 	{ 300, 17 },
 	{ 320, 18 },
 	{ 440, 19 },
-- 
1.6.3.1
