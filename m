From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2200: use
	snd_soc_codec_get_drvdata()" to the asoc tree
Date: Wed, 27 Dec 2017 10:39:41 +0000 (GMT)
Message-ID: <20171227103941.9AD4644006B@finisterre.ee.mobilebroadband>
References: <871sjqyyr3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 68FEE2673B0
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 11:39:42 +0100 (CET)
In-Reply-To: <871sjqyyr3.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2200: use snd_soc_codec_get_drvdata()

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

>From ac769ab17282e4ca1b95fdc22c58975cba8f3619 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Dec 2017 01:37:13 +0000
Subject: [PATCH] ASoC: wm2200: use snd_soc_codec_get_drvdata()

snd_soc_codec_get_drvdata() is common function to get
private data. Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index d83dab57a1d1..2d03db6efb79 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1550,7 +1550,7 @@ static const struct snd_soc_dapm_route wm2200_dapm_routes[] = {
 
 static int wm2200_probe(struct snd_soc_codec *codec)
 {
-	struct wm2200_priv *wm2200 = dev_get_drvdata(codec->dev);
+	struct wm2200_priv *wm2200 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	wm2200->codec = codec;
-- 
2.15.0
