From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ASoC: sunxi: rename SND_SUNXI_ADDA_PR_REGMAP
	to SND_SUN8I_ADDA_PR_REGMAP
Date: Fri,  2 Nov 2018 21:26:51 -0700
Message-ID: <20181103042651.6641-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 540672678F7
 for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2018 05:27:24 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id k13so1807837pga.8
 for <alsa-devel@alsa-project.org>; Fri, 02 Nov 2018 21:27:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

SND_SUN50I_CODEC_ANALOG selects SND_SUNXI_ADDA_PR_REGMAP which is leftover
of renaming SND_SUNXI_ADDA_PR_REGMAP to SND_SUN8I_ADDA_PR_REGMAP. Replace
it with SND_SUN8I_ADDA_PR_REGMAP to fix possible link errors for some
configurations:

sound/soc/sunxi/sun50i-codec-analog.o: In function `sun50i_codec_analog_probe':
sun50i-codec-analog.c:(.text+0x62): undefined reference to `sun8i_adda_pr_regmap_init'

Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 66aad0d3f9c7..8134c3c94229 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -31,7 +31,7 @@ config SND_SUN8I_CODEC_ANALOG
 config SND_SUN50I_CODEC_ANALOG
 	tristate "Allwinner sun50i Codec Analog Controls Support"
 	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
-	select SND_SUNXI_ADDA_PR_REGMAP
+	select SND_SUN8I_ADDA_PR_REGMAP
 	help
 	  Say Y or M if you want to add support for the analog controls for
 	  the codec embedded in Allwinner A64 SoC.
-- 
2.19.1
