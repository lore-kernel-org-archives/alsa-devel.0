From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau1761: Use the standard fall-through
	annotation" to the asoc tree
Date: Fri,  5 Oct 2018 14:27:24 +0100 (BST)
Message-ID: <20181005132724.3E63C112229A@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E62B2267924
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 15:27:24 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau1761: Use the standard fall-through annotation

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

>From 7e29317928bd79a03a9c35816afa709988b5d31b Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 4 Oct 2018 20:30:02 +0200
Subject: [PATCH] ASoC: adau1761: Use the standard fall-through annotation

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, replace with the standard "fall through" annotation
at the right place.  It has to be put right before the next label.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1761.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index be136e981653..bef3e9e74c26 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -518,7 +518,8 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_component *component)
 			ARRAY_SIZE(adau1761_jack_detect_controls));
 		if (ret)
 			return ret;
-	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE: /* fallthrough */
+		/* fall through */
+	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE:
 		ret = snd_soc_dapm_add_routes(dapm, adau1761_no_dmic_routes,
 			ARRAY_SIZE(adau1761_no_dmic_routes));
 		if (ret)
-- 
2.19.0.rc2
