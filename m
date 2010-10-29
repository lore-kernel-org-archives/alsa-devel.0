From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove volatility from WM8900 POWER1
	register
Date: Fri, 29 Oct 2010 16:08:36 -0700
Message-ID: <1288393716-19903-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E30E6103885
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Oct 2010 01:08:33 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Not all bits can be read back from POWER1 so avoid corruption when using
a read/modify/write cycle by marking it non-volatile - the only thing we
read back from it is the chip revision which has diagnostic value only.
We can re-add later but that's a more invasive change than is suitable
for a bugfix.

Change-Id: I846ac8bba474275dcbda5ff82fc006554a06d21e
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8900.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index b4f1172..aca4b1e 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -186,7 +186,6 @@ static int wm8900_volatile_register(unsigned int reg)
 {
 	switch (reg) {
 	case WM8900_REG_ID:
-	case WM8900_REG_POWER1:
 		return 1;
 	default:
 		return 0;
@@ -1200,11 +1199,6 @@ static int wm8900_probe(struct snd_soc_codec *codec)
 		return -ENODEV;
 	}
 
-	/* Read back from the chip */
-	reg = snd_soc_read(codec, WM8900_REG_POWER1);
-	reg = (reg >> 12) & 0xf;
-	dev_info(codec->dev, "WM8900 revision %d\n", reg);
-
 	wm8900_reset(codec);
 
 	/* Turn the chip on */
-- 
1.7.1
