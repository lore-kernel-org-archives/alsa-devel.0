From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Enable COMPILE_TEST for entire Samsung ASoc"
 to the asoc tree
Date: Tue, 22 Nov 2016 17:26:28 +0000
Message-ID: <E1c9Epw-0005mh-9x@debutante>
References: <1479566911-5580-6-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1479566911-5580-6-git-send-email-krzk@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Enable COMPILE_TEST for entire Samsung ASoc

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

>From a41dcdeee5d87cf3852b857cc3a8507832ec8b42 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 20 Nov 2016 21:24:54 +0200
Subject: [PATCH] ASoC: samsung: Enable COMPILE_TEST for entire Samsung ASoc

Instead of build time, Samsung ASoC drivers have rather runtime
dependency on Exynos or other Samsung platforms.  For building they
require Common Clock Framework.  If it is provided they could be compile
tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index ea0fa9971a0c..48dcd3dd9ec7 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,7 @@
 menuconfig SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
+	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
+	depends on COMMON_CLK
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	---help---
 	  Say Y or M if you want to add support for codecs attached to
-- 
2.10.2
