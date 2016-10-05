From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: move mixer volume controls
	from TAS5711 to TAS5717" to the asoc tree
Date: Wed, 05 Oct 2016 17:21:58 +0200
Message-ID: <E1bro18-0004kf-U3@finisterre>
References: <1475505650-8572-6-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A90E52666F4
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 17:22:14 +0200 (CEST)
In-Reply-To: <1475505650-8572-6-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: move mixer volume controls from TAS5711 to TAS5717

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

>From 960695670502afa153c2294e15ca790dbe086f4d Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <brain@jikos.cz>
Date: Mon, 3 Oct 2016 16:40:50 +0200
Subject: [PATCH] ASoC: tas571x: move mixer volume controls from TAS5711 to
 TAS5717

Channel 1 and 2 Mixer Volume controls (registers 0x72/0x73 and 0x76/0x77)
were wrongly assigned to tas5711_controls in commit f252d2346022
("ASoC: tas571x: add input channel mixer for TAS5717/19")

Therefore move them to tas5717_controls.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index de65ecf534af..34e4ce6f23d8 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -401,16 +401,6 @@ static const struct snd_kcontrol_new tas5711_controls[] = {
 		   TAS571X_SOFT_MUTE_REG,
 		   TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
 		   1, 1),
-
-	SOC_DOUBLE_R_RANGE("CH1 Mixer Volume",
-			   TAS5717_CH1_LEFT_CH_MIX_REG,
-			   TAS5717_CH1_RIGHT_CH_MIX_REG,
-			   16, 0, 0x80, 0),
-
-	SOC_DOUBLE_R_RANGE("CH2 Mixer Volume",
-			   TAS5717_CH2_LEFT_CH_MIX_REG,
-			   TAS5717_CH2_RIGHT_CH_MIX_REG,
-			   16, 0, 0x80, 0),
 };
 
 static const struct regmap_range tas571x_readonly_regs_range[] = {
@@ -488,6 +478,16 @@ static const struct snd_kcontrol_new tas5717_controls[] = {
 		   TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
 		   1, 1),
 
+	SOC_DOUBLE_R_RANGE("CH1 Mixer Volume",
+			   TAS5717_CH1_LEFT_CH_MIX_REG,
+			   TAS5717_CH1_RIGHT_CH_MIX_REG,
+			   16, 0, 0x80, 0),
+
+	SOC_DOUBLE_R_RANGE("CH2 Mixer Volume",
+			   TAS5717_CH2_LEFT_CH_MIX_REG,
+			   TAS5717_CH2_RIGHT_CH_MIX_REG,
+			   16, 0, 0x80, 0),
+
 	/*
 	 * The biquads are named according to the register names.
 	 * Please note that TI's TAS57xx Graphical Development Environment
-- 
2.9.3
