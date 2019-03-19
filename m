From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: free stream_name of dai_drv"
	to the asoc tree
Date: Tue, 19 Mar 2019 13:13:28 +0000 (GMT)
Message-ID: <20190319131328.B764F11288DF@debutante.sirena.org.uk>
References: <20190305155753.10362-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3DD4F89718
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:37 +0100 (CET)
In-Reply-To: <20190305155753.10362-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: free stream_name of dai_drv

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

>From 7b6f68a4df4df3a58e854d24da991640bd4d9590 Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Tue, 5 Mar 2019 23:57:52 +0800
Subject: [PATCH] ASoC: topology: free stream_name of dai_drv

The stream_name is allocated by kstrdup. We have to free it when the
dai is removed or return from error.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fbee4720b834..1be60cea2bf5 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -535,6 +535,8 @@ static void remove_dai(struct snd_soc_component *comp,
 		if (dai->driver == dai_drv)
 			dai->driver = NULL;
 
+	kfree(dai_drv->playback.stream_name);
+	kfree(dai_drv->capture.stream_name);
 	kfree(dai_drv->name);
 	list_del(&dobj->list);
 	kfree(dai_drv);
@@ -1808,6 +1810,9 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	ret = soc_tplg_dai_load(tplg, dai_drv, pcm, NULL);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		kfree(dai_drv->playback.stream_name);
+		kfree(dai_drv->capture.stream_name);
+		kfree(dai_drv->name);
 		kfree(dai_drv);
 		return ret;
 	}
-- 
2.20.1
