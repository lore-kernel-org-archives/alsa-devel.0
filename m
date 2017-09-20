From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Refactor the code in
	snd_soc_dapm_new_pcm" to the asoc tree
Date: Wed, 20 Sep 2017 04:42:09 -0700 (PDT)
Message-ID: <20170920114209.E71AF4400D3@finisterre.ee.mobilebroadband>
References: <20170826082938.35516-1-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CAE3267506
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:42:10 +0200 (CEST)
In-Reply-To: <20170826082938.35516-1-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Refactor the code in snd_soc_dapm_new_pcm

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

>From 38b8e6f092fd71eee56a064487be335226b0a54d Mon Sep 17 00:00:00 2001
From: anish kumar <yesanishhere@gmail.com>
Date: Wed, 20 Sep 2017 01:28:34 -0700
Subject: [PATCH] ASoC: dapm: Refactor the code in snd_soc_dapm_new_pcm

refactor snd_soc_dapm_new_pcm to reduce the size of
this function to facilitate further refactoring.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f51f61340f9c..d55cac655195 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3821,19 +3821,15 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 				devm_kasprintf(card->dev, GFP_KERNEL,
 					       "Anonymous Configuration %d",
 					       count);
-			if (!w_param_text[count]) {
-				ret = -ENOMEM;
-				goto outfree_link_name;
-			}
 		} else {
 			w_param_text[count] = devm_kmemdup(card->dev,
 						config->stream_name,
 						strlen(config->stream_name) + 1,
 						GFP_KERNEL);
-			if (!w_param_text[count]) {
-				ret = -ENOMEM;
-				goto outfree_link_name;
-			}
+		}
+		if (!w_param_text[count]) {
+			ret = -ENOMEM;
+			goto outfree_link_name;
 		}
 		config++;
 	}
-- 
2.13.2
