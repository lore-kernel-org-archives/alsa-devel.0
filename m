From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: make wm8782 codec selectable in
	Kconfig" to the asoc tree
Date: Tue, 22 May 2018 11:58:39 +0100
Message-ID: <E1fL503-0000RR-P8@debutante>
References: <20180521215450.30557-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B1D626767A
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 12:58:41 +0200 (CEST)
In-Reply-To: <20180521215450.30557-2-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: make wm8782 codec selectable in Kconfig

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

>From 2da48013f2c7eabc16dc0ce64a325ad3e9743fee Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Mon, 21 May 2018 23:54:50 +0200
Subject: [PATCH] ASoC: make wm8782 codec selectable in Kconfig

FOr platforms that use the simple-card driver, the codec cannot be selected
through 'select' magic in Kconfig. So turn this into a real config option.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a3e7c44c6586..55a989d15b46 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1131,7 +1131,7 @@ config SND_SOC_WM8776
 	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8782
-	tristate
+	tristate "Wolfson Microelectronics WM8782 ADC"
 
 config SND_SOC_WM8804
 	tristate
-- 
2.17.0
