From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Add CONFIG_SND_SOC_MAX9867 to
	build" to the asoc tree
Date: Sun, 21 Feb 2016 03:10:31 +0900
Message-ID: <E1aXBzD-0001kO-Oz@finisterre>
References: <1455936752.19371.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1861A261B0A
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:10:49 +0100 (CET)
In-Reply-To: <1455936752.19371.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, anish kumar <yesanishhere@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Add CONFIG_SND_SOC_MAX9867 to build

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

>From ee06b6f0675907191656b11a8405a03c6d599ea9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 20 Feb 2016 10:52:32 +0800
Subject: [PATCH] ASoC: max9867: Add CONFIG_SND_SOC_MAX9867 to build

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b84fe9d..f35237d 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -280,6 +280,7 @@ obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX98090)	+= snd-soc-max98090.o
 obj-$(CONFIG_SND_SOC_MAX98095)	+= snd-soc-max98095.o
 obj-$(CONFIG_SND_SOC_MAX98357A)	+= snd-soc-max98357a.o
+obj-$(CONFIG_SND_SOC_MAX9867)	+= snd-soc-max9867.o
 obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX98926)	+= snd-soc-max98926.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
-- 
2.7.0
