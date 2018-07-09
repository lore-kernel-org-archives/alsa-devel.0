From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau171x1: Connect playback DAI to the
	DSP" to the asoc tree
Date: Mon, 09 Jul 2018 12:29:18 +0100
Message-ID: <E1fcUM2-0006QA-MG@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C295626739D
 for <alsa-devel@alsa-project.org>; Mon,  9 Jul 2018 13:29:23 +0200 (CEST)
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau171x1: Connect playback DAI to the DSP

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

>From 5bea327962fa296efd16f2d3369dd339ddd7ce6f Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 6 Jul 2018 16:19:14 +0300
Subject: [PATCH] ASoC: adau171x1: Connect playback DAI to the DSP

The playback DAI is connected to the DSP and the DSP might be sourcing
signals from the playback stream. Add a DAPM route between the two to make
sure that the playback DAI is powered up, when the DSP is active.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau17x1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index ae41edd1c406..57169b8ff14e 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -299,6 +299,7 @@ static const struct snd_soc_dapm_route adau17x1_dsp_dapm_routes[] = {
 
 	{ "DSP", NULL, "Left Decimator" },
 	{ "DSP", NULL, "Right Decimator" },
+	{ "DSP", NULL, "Playback" },
 };
 
 static const struct snd_soc_dapm_route adau17x1_no_dsp_dapm_routes[] = {
-- 
2.18.0.rc2
