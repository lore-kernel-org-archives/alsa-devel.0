From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Set CPU DAI name and enable
	DPCM by default for FE link" to the asoc tree
Date: Wed, 20 Apr 2016 17:21:59 +0100
Message-ID: <E1asut5-0007IJ-Km@debutante>
References: <c80352fa0ae3d1f881ea8ea15f474314ad63e3ae.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EAA922667E2
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 18:22:07 +0200 (CEST)
In-Reply-To: <c80352fa0ae3d1f881ea8ea15f474314ad63e3ae.1461042239.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Set CPU DAI name and enable DPCM by default for FE link

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

>From 67d1c21e37301ca3cea3705951950ce21f2723e1 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Tue, 19 Apr 2016 13:12:50 +0800
Subject: [PATCH] ASoC: topology: Set CPU DAI name and enable DPCM by default
 for FE link

When creating a FE link, the cpu_dai_name will come from topology and
dpcm will be enabled by default.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index bdbfcef4c319..ca5f82885031 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1586,6 +1586,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	return snd_soc_register_dai(tplg->comp, dai_drv);
 }
 
+/* create the FE DAI link */
 static int soc_tplg_link_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
@@ -1600,6 +1601,15 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 	link->stream_name = pcm->pcm_name;
 	link->id = pcm->pcm_id;
 
+	link->cpu_dai_name = pcm->dai_name;
+	link->codec_name = "snd-soc-dummy";
+	link->codec_dai_name = "snd-soc-dummy-dai";
+
+	/* enable DPCM */
+	link->dynamic = 1;
+	link->dpcm_playback = pcm->playback;
+	link->dpcm_capture = pcm->capture;
+
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link);
 	if (ret < 0) {
-- 
2.8.0.rc3
