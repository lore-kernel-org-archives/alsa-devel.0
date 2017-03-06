From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: TLV320AIC23: Unquote NULL from control
	name" to the asoc tree
Date: Mon, 06 Mar 2017 11:46:33 +0100
Message-ID: <E1ckq9x-0002RB-IJ@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4E1E266DBF
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:46:43 +0100 (CET)
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
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: TLV320AIC23: Unquote NULL from control name

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

>From a03faba972cb0f9b3a46d8054e674d5492e06c38 Mon Sep 17 00:00:00 2001
From: Liviu Dudau <liviu@dudau.co.uk>
Date: Wed, 1 Mar 2017 12:26:28 +0000
Subject: [PATCH] ASoC: TLV320AIC23: Unquote NULL from control name

Without this I am getting the following messages at boot on my Trimslice:
   tlv320aic23-codec 2-001a: Control not supported for path LLINEIN -> [NULL] -> Line Input
   tlv320aic23-codec 2-001a: ASoC: no dapm match for LLINEIN --> NULL --> Line Input
   tlv320aic23-codec 2-001a: ASoC: Failed to add route LLINEIN -> NULL -> Line Input
   tlv320aic23-codec 2-001a: Control not supported for path RLINEIN -> [NULL] -> Line Input
   tlv320aic23-codec 2-001a: ASoC: no dapm match for RLINEIN --> NULL --> Line Input
   tlv320aic23-codec 2-001a: ASoC: Failed to add route RLINEIN -> NULL -> Line Input
   tlv320aic23-codec 2-001a: Control not supported for path MICIN -> [NULL] -> Mic Input
   tlv320aic23-codec 2-001a: ASoC: no dapm match for MICIN --> NULL --> Mic Input
   tlv320aic23-codec 2-001a: ASoC: Failed to add route MICIN -> NULL -> Mic Input
   tegra-snd-trimslice sound: tlv320aic23-hifi <-> 70002800.i2s mapping ok

Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic23.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 410cae0f2060..628a8eeaab68 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -174,10 +174,9 @@ static const struct snd_soc_dapm_route tlv320aic23_intercon[] = {
 	{"ROUT", NULL, "Output Mixer"},
 
 	/* Inputs */
-	{"Line Input", "NULL", "LLINEIN"},
-	{"Line Input", "NULL", "RLINEIN"},
-
-	{"Mic Input", "NULL", "MICIN"},
+	{"Line Input", NULL, "LLINEIN"},
+	{"Line Input", NULL, "RLINEIN"},
+	{"Mic Input", NULL, "MICIN"},
 
 	/* input mux */
 	{"Capture Source", "Line", "Line Input"},
-- 
2.11.0
