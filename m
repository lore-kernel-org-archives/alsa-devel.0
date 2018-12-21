From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm512x: Fix a double unlock in
	pcm512x_digital_mute()" to the asoc tree
Date: Fri, 21 Dec 2018 13:42:37 +0000 (GMT)
Message-ID: <20181221134237.309881121B93@debutante.sirena.org.uk>
References: <20181221091120.GG2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C4810267ADF
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 14:42:44 +0100 (CET)
In-Reply-To: <20181221091120.GG2735@kadam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Dimitris Papavasiliou <dpapavas@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm512x: Fix a double unlock in pcm512x_digital_mute()

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

>From 35c299625b68369518bf45f99b8052ec2394d10e Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 21 Dec 2018 12:11:20 +0300
Subject: [PATCH] ASoC: pcm512x: Fix a double unlock in pcm512x_digital_mute()

We accidentally call mutex_unlock(&pcm512x->mutex); twice in a row.

I re-wrote the error handling to use "goto unlock;" instead of returning
directly.  Hopefully, it makes the code a little simpler.

Fixes: 3500f1c589e9 ("ASoC: pcm512x: Implement the digital_mute interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviwed-by: Dimitris Papavasiliou <dpapavas@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm512x.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 6cb1653be804..4cc24a5d5c31 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1400,24 +1400,20 @@ static int pcm512x_digital_mute(struct snd_soc_dai *dai, int mute)
 		if (ret != 0) {
 			dev_err(component->dev,
 				"Failed to set digital mute: %d\n", ret);
-			mutex_unlock(&pcm512x->mutex);
-			return ret;
+			goto unlock;
 		}
 
 		regmap_read_poll_timeout(pcm512x->regmap,
 					 PCM512x_ANALOG_MUTE_DET,
 					 mute_det, (mute_det & 0x3) == 0,
 					 200, 10000);
-
-		mutex_unlock(&pcm512x->mutex);
 	} else {
 		pcm512x->mute &= ~0x1;
 		ret = pcm512x_update_mute(pcm512x);
 		if (ret != 0) {
 			dev_err(component->dev,
 				"Failed to update digital mute: %d\n", ret);
-			mutex_unlock(&pcm512x->mutex);
-			return ret;
+			goto unlock;
 		}
 
 		regmap_read_poll_timeout(pcm512x->regmap,
@@ -1428,9 +1424,10 @@ static int pcm512x_digital_mute(struct snd_soc_dai *dai, int mute)
 					 200, 10000);
 	}
 
+unlock:
 	mutex_unlock(&pcm512x->mutex);
 
-	return 0;
+	return ret;
 }
 
 static const struct snd_soc_dai_ops pcm512x_dai_ops = {
-- 
2.20.1
