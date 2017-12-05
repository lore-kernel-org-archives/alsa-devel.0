From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use rtd->codec on
	snd_soc_new_compress()" to the asoc tree
Date: Tue,  5 Dec 2017 12:47:37 +0000 (GMT)
Message-ID: <20171205124737.E1DF244006B@finisterre.ee.mobilebroadband>
References: <87609lvmkd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C241267749
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:47:39 +0100 (CET)
In-Reply-To: <87609lvmkd.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: don't use rtd->codec on snd_soc_new_compress()

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

>From e5acfc7d3562ae251cb786b5b52d4345dd16a02c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 5 Dec 2017 04:23:05 +0000
Subject: [PATCH] ASoC: don't use rtd->codec on snd_soc_new_compress()

rtd->codec will be removed soon.
rtd->codec = rtd->codec_dai->codec, thus,
we can use rtd->codec_dai->component instead of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d9b1e6417fb9..81232f4ab614 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -1096,7 +1096,6 @@ static struct snd_compr_ops soc_compr_dyn_ops = {
  */
 int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 {
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
@@ -1199,8 +1198,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	ret = snd_compress_new(rtd->card->snd_card, num, direction,
 				new_name, compr);
 	if (ret < 0) {
+		component = rtd->codec_dai->component;
 		pr_err("compress asoc: can't create compress for codec %s\n",
-			codec->component.name);
+			component->name);
 		goto compr_err;
 	}
 
-- 
2.15.0
