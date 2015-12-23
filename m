From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Fix Sidetone to work regardless
	of DAI capture" to the asoc tree
Date: Wed, 23 Dec 2015 00:12:20 +0000
Message-ID: <E1aBX2S-0008Nt-4M@debutante>
References: <2ed293aa5fa88ff652f1c6628a09dc6fe36ea112.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66F17265E28
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:12:26 +0100 (CET)
In-Reply-To: <2ed293aa5fa88ff652f1c6628a09dc6fe36ea112.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Fix Sidetone to work regardless of DAI capture

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

>From fdd50a8086422caa456b5f8abb631dda6c551744 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 Dec 2015 18:27:52 +0000
Subject: [PATCH] ASoC: da7219: Fix Sidetone to work regardless of DAI capture

Previously Sidetone would operate only when capture to DAI was in
progress, due to DAPM path configuration. There is no reason why
this should not operate without DAI capture, so this patch updates
the DAPM path accordingly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index e36a7b79b494..319e794d27f6 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -968,10 +968,11 @@ static const struct snd_soc_dapm_route da7219_audio_map[] = {
 	{"Mixin PGA", NULL, "Mic PGA"},
 	{"ADC", NULL, "Mixin PGA"},
 
-	{"Sidetone Filter", NULL, "ADC"},
 	{"Mixer In", NULL, "Mixer In Supply"},
 	{"Mixer In", "Mic Switch", "ADC"},
 
+	{"Sidetone Filter", NULL, "Mixer In"},
+
 	{"Tone Generator", NULL, "TONE"},
 
 	DA7219_OUT_DAI_MUX_ROUTES("Out DAIL Mux"),
-- 
2.6.2
