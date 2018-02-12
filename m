From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sn95031: remove dead makefile about
	sn95031" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:05 +0000
Message-ID: <E1elDDJ-0002qX-W7@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4616426736B
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:07 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Corentin Labbe <clabbe@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sn95031: remove dead makefile about sn95031

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

>From e0b9f3aa45fcfce1873503e5ff85d919697427cb Mon Sep 17 00:00:00 2001
From: Corentin Labbe <clabbe@baylibre.com>
Date: Mon, 29 Jan 2018 12:28:54 +0000
Subject: [PATCH] ASoC: sn95031: remove dead makefile about sn95031

All sn95031 stuff was removed in commit 987da3fe1759 ("ASoC: sn95031: remove this code")
Since SND_SOC_SN95031 was gone, remove makefile about it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index da1571336f1e..4053c72d852b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -387,7 +387,6 @@ obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
 obj-$(CONFIG_SND_SOC_SIGMADSP_I2C)	+= snd-soc-sigmadsp-i2c.o
 obj-$(CONFIG_SND_SOC_SIGMADSP_REGMAP)	+= snd-soc-sigmadsp-regmap.o
 obj-$(CONFIG_SND_SOC_SI476X)	+= snd-soc-si476x.o
-obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif-rx.o snd-soc-spdif-tx.o
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO_CODEC) += sirf-audio-codec.o
 obj-$(CONFIG_SND_SOC_SSM2518)	+= snd-soc-ssm2518.o
-- 
2.16.1
