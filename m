From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98357a: Use DAI input as a dapm
	widget" to the asoc tree
Date: Mon, 13 Jul 2015 19:14:21 +0100
Message-ID: <E1ZEiFB-00033W-Ms@debutante>
References: <1436714061-18618-2-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FBC4261AF7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 20:14:28 +0200 (CEST)
In-Reply-To: <1436714061-18618-2-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98357a: Use DAI input as a dapm widget

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

>From 508e61953f7b2c5c828412e5b46fa99b8a3fbaa1 Mon Sep 17 00:00:00 2001
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Sun, 12 Jul 2015 08:14:20 -0700
Subject: [PATCH] ASoC: max98357a: Use DAI input as a dapm widget

Spec does not say anything about DAC called SDMode.
It makes more sense to use DAI input that created automatically by DAPM
and route it to Speaker output.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index fa1b79302bb3..b9e1131bab74 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -51,12 +51,11 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("SDMode", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("Speaker"),
 };
 
 static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
-	{"Speaker", NULL, "SDMode"},
+	{"Speaker", NULL, "HiFi Playback"},
 };
 
 static int max98357a_codec_probe(struct snd_soc_codec *codec)
-- 
2.1.4
