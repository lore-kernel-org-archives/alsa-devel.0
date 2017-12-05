From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use rtd->codec on Intel/haswell"
	to the asoc tree
Date: Tue,  5 Dec 2017 12:46:39 +0000 (GMT)
Message-ID: <20171205124639.9299844006B@finisterre.ee.mobilebroadband>
References: <871sk9vmj2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E815026772D
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:46:41 +0100 (CET)
In-Reply-To: <871sk9vmj2.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: don't use rtd->codec on Intel/haswell

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

>From 187c43df88196c0c4b231771a39e4a46f20a4f7a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 5 Dec 2017 04:23:52 +0000
Subject: [PATCH] ASoC: don't use rtd->codec on Intel/haswell

rtd->codec will be removed soon.
rtd->codec = rtd->codec_dai->codec, thus,
we can use rtd->codec_dai->component instead of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/haswell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index 5e1ea0371c90..3c5160779204 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -76,7 +76,7 @@ static int haswell_rt5640_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set correct codec filter for DAI format and clock config */
-	snd_soc_update_bits(rtd->codec, 0x83, 0xffff, 0x8000);
+	snd_soc_component_update_bits(codec_dai->component, 0x83, 0xffff, 0x8000);
 
 	return ret;
 }
-- 
2.15.0
