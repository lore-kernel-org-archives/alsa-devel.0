From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Set the link ID when creating
	a FE DAI link" to the asoc tree
Date: Wed, 20 Apr 2016 17:19:47 +0100
Message-ID: <E1asuqx-0006xW-0N@debutante>
References: <363cac6fe4cb2e8c5f839ace62f1641927ac1e0f.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CBD02666DF
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 18:19:52 +0200 (CEST)
In-Reply-To: <363cac6fe4cb2e8c5f839ace62f1641927ac1e0f.1461042239.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Set the link ID when creating a FE DAI link

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

>From b84fff5afb16627a8973256992f3951ac3e90d84 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Tue, 19 Apr 2016 13:12:43 +0800
Subject: [PATCH] ASoC: topology: Set the link ID when creating a FE DAI link

Topology will set the link's generic id when creating a FE link.
Device drivers can check the id for link specific initialization.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 2 +-
 sound/soc/soc-topology.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index db86b447b515..e4701a3c6331 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -423,7 +423,7 @@ struct snd_soc_tplg_pcm {
 	__le32 size;		/* in bytes of this structure */
 	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 pcm_id;		/* unique ID - used to match */
+	__le32 pcm_id;		/* unique ID - used to match with DAI link */
 	__le32 dai_id;		/* unique ID - used to match */
 	__le32 playback;	/* supports playback mode */
 	__le32 capture;		/* supports capture mode */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 1cf94d7fb9f4..bdbfcef4c319 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1598,6 +1598,7 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 
 	link->name = pcm->pcm_name;
 	link->stream_name = pcm->pcm_name;
+	link->id = pcm->pcm_id;
 
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link);
-- 
2.8.0.rc3
