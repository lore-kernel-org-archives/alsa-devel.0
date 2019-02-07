From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/6] ASoC: codecs: Kconfig: Show knob, and depend on MIPS || COMPILE_TEST
Date: Thu,  7 Feb 2019 10:31:42 -0300
Message-ID: <20190207133143.5232-5-paul@crapouillou.net>
References: <20190207133143.5232-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207133143.5232-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

Show the knob to enable or disable the jz4740-codec driver, add a
proper description, and add a dependency on MIPS || COMPILE_TEST, as
this driver is only useful on MIPS.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: No change

 sound/soc/codecs/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index fec894c725d3..e6ce18c21b98 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -579,8 +579,15 @@ config SND_SOC_CX20442
 	depends on TTY
 
 config SND_SOC_JZ4740_CODEC
+	depends on MIPS || COMPILE_TEST
 	select REGMAP_MMIO
-	tristate
+	tristate "Ingenic JZ4740 internal CODEC"
+	help
+	  Enable support for the internal CODEC found in the JZ4740 SoC
+	  from Ingenic.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called snd-soc-jz4740-codec.
 
 config SND_SOC_JZ4725B_CODEC
 	depends on MIPS || COMPILE_TEST
-- 
2.11.0
