From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_asrc: protect macro argument" to the asoc tree
Date: Wed, 06 Dec 2017 15:29:09 +0000
Message-ID: <E1eMbdF-0007YZ-Nj@debutante>
References: <20170807063657.12581-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807063657.12581-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, timur@tabi.orgnicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_asrc: protect macro argument

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

>From d1b726a9018e3f684ce190a1cbe012cb64f363d8 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Wed, 6 Dec 2017 16:17:27 +0100
Subject: [PATCH] ASoC: fsl_asrc: protect macro argument

Protect macro argument with parentheses to avoid ambiguity.
This fixes a warning seen with clang:
  warning: logical not is only applied to the left hand side of this comparison

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 0f163abe4ba3..ec33dab4b909 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -57,7 +57,7 @@
 #define REG_ASRDOC			0x74
 #define REG_ASRDI(i)			(REG_ASRDIA + (i << 3))
 #define REG_ASRDO(i)			(REG_ASRDOA + (i << 3))
-#define REG_ASRDx(x, i)			(x == IN ? REG_ASRDI(i) : REG_ASRDO(i))
+#define REG_ASRDx(x, i)			((x) == IN ? REG_ASRDI(i) : REG_ASRDO(i))
 
 #define REG_ASRIDRHA			0x80
 #define REG_ASRIDRLA			0x84
-- 
2.15.0
