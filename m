From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add AU1761 audio codec as selectable
	option" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:12 +0000
Message-ID: <E1coDQ8-00029c-Qf@debutante>
References: <1487970034-6003-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1487970034-6003-1-git-send-email-me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
Cc: patch@alsa-project.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add AU1761 audio codec as selectable option

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e54fde61715df828c2f06883a6eb756bb5d88006 Mon Sep 17 00:00:00 2001
From: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
Date: Mon, 27 Feb 2017 08:17:42 -0600
Subject: [PATCH] ASoC: Add AU1761 audio codec as selectable option

This commit adds the ADI AU1761 audio codec as a selectable option
in the kernel config.  Currently the driver can only be selected
for ADI blackfin devices or if SND_SOC_ALL_CODECS is enabled.

Signed-off-by: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e1718a8cb1c..71039982dae4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -302,12 +302,14 @@ config SND_SOC_ADAU1761
 	select SND_SOC_ADAU17X1
 
 config SND_SOC_ADAU1761_I2C
-	tristate
+	tristate "Analog Devices AU1761 CODEC - I2C"
+	depends on I2C
 	select SND_SOC_ADAU1761
 	select REGMAP_I2C
 
 config SND_SOC_ADAU1761_SPI
-	tristate
+	tristate "Analog Devices AU1761 CODEC - SPI"
+	depends on SPI
 	select SND_SOC_ADAU1761
 	select REGMAP_SPI
 
-- 
2.11.0
