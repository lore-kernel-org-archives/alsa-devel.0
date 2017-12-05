From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use rtd->codec on intel/skylake"
	to the asoc tree
Date: Tue,  5 Dec 2017 12:46:52 +0000 (GMT)
Message-ID: <20171205124653.024DE44006B@finisterre.ee.mobilebroadband>
References: <874lsnkkl4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D6012674F0
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:46:57 +0100 (CET)
In-Reply-To: <874lsnkkl4.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: don't use rtd->codec on intel/skylake

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

>From 356a383bd978e58b5324284dc21210467968b4ff Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 5 Dec 2017 04:23:35 +0000
Subject: [PATCH] ASoC: don't use rtd->codec on intel/skylake

rtd->codec will be removed soon.
rtd->codec = rtd->codec_dai->codec, thus,
we can use rtd->codec_dai->component instead of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 4380e40c6af0..18138dc872d9 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -536,7 +536,7 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_dai_set_dma_data(dai, substream, (void *)link_dev);
 
-	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
+	link = snd_hdac_ext_bus_get_link(ebus, codec_dai->component->name);
 	if (!link)
 		return -EINVAL;
 
@@ -619,7 +619,7 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 
 	link_dev->link_prepared = 0;
 
-	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
+	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec_dai->component->name);
 	if (!link)
 		return -EINVAL;
 
-- 
2.15.0
