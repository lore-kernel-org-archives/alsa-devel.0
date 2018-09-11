From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add missing return value check
	for snd_soc_dapm_new_dai" to the asoc tree
Date: Tue, 11 Sep 2018 12:11:22 +0100 (BST)
Message-ID: <20180911111122.7665C1121AF8@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1B56267795
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 13:11:24 +0200 (CEST)
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
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Add missing return value check for snd_soc_dapm_new_dai

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

>From e36a1d0d249aa09f94d551cadf043a7f9f7fae00 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 10 Sep 2018 15:28:39 +0100
Subject: [PATCH] ASoC: dapm: Add missing return value check for
 snd_soc_dapm_new_dai

snd_soc_dapm_new_dai may return an error pointer and currently this
isn't checked for in dapm_connect_dai_link_widgets. Add code to check
the return value and not add routes in that case.

Fixes: 778ff5bb8689 ("ASoC: dapm: Move connection of CODEC to CODEC DAIs")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0dcdcc23dcfd..43983c69f6aa 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4087,6 +4087,13 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 				playback = snd_soc_dapm_new_dai(card, rtd,
 								playback_cpu,
 								codec);
+				if (IS_ERR(playback)) {
+					dev_err(rtd->dev,
+						"ASoC: Failed to create DAI %s: %ld\n",
+						codec_dai->name,
+						PTR_ERR(playback));
+					continue;
+				}
 
 				snd_soc_dapm_add_path(&card->dapm, playback_cpu,
 						      playback, NULL, NULL);
@@ -4099,7 +4106,9 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 			snd_soc_dapm_add_path(&card->dapm, playback, codec,
 					      NULL, NULL);
 		}
+	}
 
+	for_each_rtd_codec_dai(rtd, i, codec_dai) {
 		/* connect BE DAI capture if widgets are valid */
 		codec = codec_dai->capture_widget;
 
@@ -4108,6 +4117,13 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 				capture = snd_soc_dapm_new_dai(card, rtd,
 							       codec,
 							       capture_cpu);
+				if (IS_ERR(capture)) {
+					dev_err(rtd->dev,
+						"ASoC: Failed to create DAI %s: %ld\n",
+						codec_dai->name,
+						PTR_ERR(capture));
+					continue;
+				}
 
 				snd_soc_dapm_add_path(&card->dapm, capture,
 						      capture_cpu, NULL, NULL);
-- 
2.19.0.rc2
