From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: fix error path in
	snd_soc_dapm_new_pcm" to the asoc tree
Date: Wed, 20 Sep 2017 04:42:25 -0700 (PDT)
Message-ID: <20170920114225.C9C3B4400D3@finisterre.ee.mobilebroadband>
References: <1505896116-43310-2-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A17C92674FC
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:42:28 +0200 (CEST)
In-Reply-To: <1505896116-43310-2-git-send-email-yesanishhere@gmail.com>
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
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: fix error path in snd_soc_dapm_new_pcm

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

>From e5af4f9fb3d405e6145f0d019ce11a97a8930915 Mon Sep 17 00:00:00 2001
From: anish kumar <yesanishhere@gmail.com>
Date: Wed, 20 Sep 2017 01:28:33 -0700
Subject: [PATCH] ASoC: dapm: fix error path in snd_soc_dapm_new_pcm

w_param_text[count] is freed in the wrong error path.
Fix it by shifting the outfree_w_param label.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcef67a9bd48..f51f61340f9c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3907,9 +3907,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	devm_kfree(card->dev, (void *)private_value);
 outfree_link_name:
 	devm_kfree(card->dev, link_name);
-outfree_w_param:
 	for (count = 0 ; count < num_params; count++)
 		devm_kfree(card->dev, (void *)w_param_text[count]);
+outfree_w_param:
 	devm_kfree(card->dev, w_param_text);
 
 	return ret;
-- 
2.13.2
