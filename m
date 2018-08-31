From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4265: SOC_SINGLE register value error
	fix" to the asoc tree
Date: Fri, 31 Aug 2018 16:40:38 +0100 (BST)
Message-ID: <20180831154038.31D1A11226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FF6E267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:40:38 +0200 (CEST)
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
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4265: SOC_SINGLE register value error fix

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

>From 6f18bcdaa24bae39c746b57b95af19ff3c41b17f Mon Sep 17 00:00:00 2001
From: Matt Flax <flatmax@flatmax.org>
Date: Thu, 30 Aug 2018 09:38:00 +1000
Subject: [PATCH] ASoC: cs4265: SOC_SINGLE register value error fix

The cs4265 driver declares the "MMTLR Data Switch" register setting with
a 0 register value rather then the 0x12 register (CS4265_SPDIF_CTL2).
This incorrect value causes alsamixer to fault with the output :
cannot load mixer controls: Input/output error

This patch corrects the register value. alsamixer now runs.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4265.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 275677de669f..15b4ae04870f 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -157,8 +157,7 @@ static const struct snd_kcontrol_new cs4265_snd_controls[] = {
 	SOC_SINGLE("Validity Bit Control Switch", CS4265_SPDIF_CTL2,
 				3, 1, 0),
 	SOC_ENUM("SPDIF Mono/Stereo", spdif_mono_stereo_enum),
-	SOC_SINGLE("MMTLR Data Switch", 0,
-				1, 1, 0),
+	SOC_SINGLE("MMTLR Data Switch", CS4265_SPDIF_CTL2, 0, 1, 0),
 	SOC_ENUM("Mono Channel Select", spdif_mono_select_enum),
 	SND_SOC_BYTES("C Data Buffer", CS4265_C_DATA_BUFF, 24),
 };
-- 
2.19.0.rc1
