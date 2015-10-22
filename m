From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Constify rate constraints" to
	the asoc tree
Date: Fri, 23 Oct 2015 08:57:02 +0900
Message-ID: <E1ZpPjC-0002mq-HH@finisterre>
References: <1445503403-22934-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D136266B08
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:57:14 +0200 (CEST)
In-Reply-To: <1445503403-22934-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Constify rate constraints

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

>From 444c37aeee46db70ce01199863dc046fa68e88b7 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 22 Oct 2015 10:43:23 +0200
Subject: [PATCH] ASoC: fsl_sai: Constify rate constraints

The rate constraints in this driver are shared between all device
instances. It should not be (and is not) modified at runtime, so make them
const.

While we are at it also change the type of the rates array from u32 to
unsigned int. While both resolve to the same type, u32 is usually used to
empathize that the value is for a 32-bit hardware register or similar which
makes it slightly confusing in this context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9366b5a..2150f5a 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -27,13 +27,13 @@
 #define FSL_SAI_FLAGS (FSL_SAI_CSR_SEIE |\
 		       FSL_SAI_CSR_FEIE)
 
-static u32 fsl_sai_rates[] = {
+static const unsigned int fsl_sai_rates[] = {
 	8000, 11025, 12000, 16000, 22050,
 	24000, 32000, 44100, 48000, 64000,
 	88200, 96000, 176400, 192000
 };
 
-static struct snd_pcm_hw_constraint_list fsl_sai_rate_constraints = {
+static const struct snd_pcm_hw_constraint_list fsl_sai_rate_constraints = {
 	.count = ARRAY_SIZE(fsl_sai_rates),
 	.list = fsl_sai_rates,
 };
-- 
2.6.1
