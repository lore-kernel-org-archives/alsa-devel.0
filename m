From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: Kconfig: Show knob,
	and depend on MIPS || COMPILE_TEST" to the asoc tree
Date: Thu,  7 Feb 2019 15:22:31 +0000 (GMT)
Message-ID: <20190207152231.68AC11127EF9@debutante.sirena.org.uk>
References: <20190207133143.5232-5-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A30BC2679A1
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 16:22:32 +0100 (CET)
In-Reply-To: <20190207133143.5232-5-paul@crapouillou.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: Kconfig: Show knob, and depend on MIPS || COMPILE_TEST

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From edcd3ed182f804ebec71b063bab32c424ddd8b6a Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 7 Feb 2019 10:31:42 -0300
Subject: [PATCH] ASoC: codecs: Kconfig: Show knob, and depend on MIPS ||
 COMPILE_TEST

Show the knob to enable or disable the jz4740-codec driver, add a
proper description, and add a dependency on MIPS || COMPILE_TEST, as
this driver is only useful on MIPS.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
2.20.1
