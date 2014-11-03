From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: mioa701_wm9713: Don't opencode CODEC
	register access
Date: Mon,  3 Nov 2014 19:33:02 +0100
Message-ID: <1415039583-4858-2-git-send-email-lars@metafoo.de>
References: <1415039583-4858-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-249.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id D372B2604F8
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 19:33:06 +0100 (CET)
In-Reply-To: <1415039583-4858-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Properly use snd_soc_update_bits() instead of manually calling the CODEC
driver's read and write callbacks. The later will stop working once the
wm9713 driver has been converted to regmap.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/mioa701_wm9713.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 595eee3..a6b2be2 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -127,15 +127,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int mioa701_wm9713_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	unsigned short reg;
 
 	/* Prepare GPIO8 for rear speaker amplifier */
-	reg = codec->driver->read(codec, AC97_GPIO_CFG);
-	codec->driver->write(codec, AC97_GPIO_CFG, reg | 0x0100);
+	snd_soc_update_bits(codec, AC97_GPIO_CFG, 0x100, 0x100);
 
 	/* Prepare MIC input */
-	reg = codec->driver->read(codec, AC97_3D_CONTROL);
-	codec->driver->write(codec, AC97_3D_CONTROL, reg | 0xc000);
+	snd_soc_update_bits(codec, AC97_3D_CONTROL, 0xc000, 0xc000);
 
 	return 0;
 }
-- 
1.8.0
