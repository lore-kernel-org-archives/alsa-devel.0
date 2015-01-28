From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC] ASoC: rt5677: fix SPI dependency
Date: Wed, 28 Jan 2015 22:31:30 +0100
Message-ID: <19778554.1IDiTWklUc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id D0D762614D3
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 22:32:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The rt5677 codec has gained code that requires SPI to work correctly,
but there is no provision in Kconfig to prevent the driver from
being used when SPI is disabled or a loadable module, resulting
in this build error:

sound/built-in.o: In function `rt5677_spi_write':
:(.text+0xa7ba0): undefined reference to `spi_sync'
sound/built-in.o: In function `rt5677_spi_driver_init':
:(.init.text+0x253c): undefined reference to `spi_register_driver'

ERROR: "spi_sync" [sound/soc/codecs/snd-soc-rt5677-spi.ko] undefined!
ERROR: "spi_register_driver" [sound/soc/codecs/snd-soc-rt5677-spi.ko] undefined!

This makes the SPI portion of the driver depend on the SPI subsystem,
and disables the function that uses SPI for firmware download if SPI
is disabled. The latter may not be the correct solution, but I could
not come up with a better one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: af48f1d08a54741 ("ASoC: rt5677: Support DSP function for VAD application")

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8349f982a586..ef2c70e77d91 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -525,7 +525,7 @@ config SND_SOC_RT5677
 
 config SND_SOC_RT5677_SPI
 	tristate
-	default SND_SOC_RT5677
+	default SND_SOC_RT5677 && SPI
 
 #Freescale sgtl5000 codec
 config SND_SOC_SGTL5000
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 26fc538f03b1..5d0bb8748dd1 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -702,6 +702,9 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 	static bool activity;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_SND_SOC_RT5677_SPI))
+		return -ENXIO;
+
 	if (on && !activity) {
 		activity = true;
 
