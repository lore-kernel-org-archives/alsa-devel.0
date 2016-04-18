From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5102: Free compressed IRQ in CODEC
	remove" to the asoc tree
Date: Mon, 18 Apr 2016 14:10:02 +0100
Message-ID: <E1as8wE-0001tj-Gm@debutante>
References: <1460722317-31486-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9010726154C
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 15:10:11 +0200 (CEST)
In-Reply-To: <1460722317-31486-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5102: Free compressed IRQ in CODEC remove

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

>From ab9f87c413c297cb9e7d544e0e634aaadc7fb87d Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 15 Apr 2016 13:11:57 +0100
Subject: [PATCH] ASoC: wm5102: Free compressed IRQ in CODEC remove

We request one of the DSP IRQs during CODEC probe, as such we should
free it during CODEC remove, this patch does so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5102.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 59fd3e8bf899..1bae17ee8817 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1955,11 +1955,14 @@ err_adsp2_codec_probe:
 static int wm5102_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->core.arizona;
 
 	wm_adsp2_codec_remove(&priv->core.adsp[0], codec);
 
 	priv->core.arizona->dapm = NULL;
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
+
 	arizona_free_spk(codec);
 
 	return 0;
-- 
2.8.0.rc3
