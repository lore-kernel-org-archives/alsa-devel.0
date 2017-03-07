From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: Remove space before semicolon" to
	the asoc tree
Date: Tue, 07 Mar 2017 14:33:48 +0100
Message-ID: <E1clFFM-0005fX-KS@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD580266F95
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:33:58 +0100 (CET)
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
To: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: Remove space before semicolon

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

>From 3e22e9d702ee719c8106fd44578b12ce27999ae6 Mon Sep 17 00:00:00 2001
From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Date: Sat, 25 Feb 2017 22:33:00 +0200
Subject: [PATCH] ASoC: pxa: Remove space before semicolon

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/spitz.c | 4 ++--
 sound/soc/pxa/z2.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 07d77cddac60..d38a2b519c52 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -230,8 +230,8 @@ static const struct snd_soc_dapm_route spitz_audio_map[] = {
 	{"Headset Jack", NULL, "ROUT1"},
 
 	/* ext speaker connected to LOUT2, ROUT2  */
-	{"Ext Spk", NULL , "ROUT2"},
-	{"Ext Spk", NULL , "LOUT2"},
+	{"Ext Spk", NULL, "ROUT2"},
+	{"Ext Spk", NULL, "LOUT2"},
 
 	/* mic is connected to input 1 - with bias */
 	{"LINPUT1", NULL, "Mic Bias"},
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 990b1aa6d7f6..6d88d9acc666 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -119,8 +119,8 @@ static const struct snd_soc_dapm_route z2_audio_map[] = {
 	{"Headphone Jack", NULL, "ROUT1"},
 
 	/* ext speaker connected to LOUT2, ROUT2  */
-	{"Ext Spk", NULL , "ROUT2"},
-	{"Ext Spk", NULL , "LOUT2"},
+	{"Ext Spk", NULL, "ROUT2"},
+	{"Ext Spk", NULL, "LOUT2"},
 
 	/* mic is connected to R input 2 - with bias */
 	{"RINPUT2", NULL, "Mic Bias"},
-- 
2.11.0
