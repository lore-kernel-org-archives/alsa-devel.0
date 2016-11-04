From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Rename the function to create
	a FE link" to the asoc tree
Date: Fri, 04 Nov 2016 11:38:49 -0600
Message-ID: <E1c2iS1-0007DR-FW@finisterre>
References: <243c7826f847a15e149f0178e8d5d79d2fbcf37d.1476108863.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 576BF2674D5
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:39:05 +0100 (CET)
In-Reply-To: <243c7826f847a15e149f0178e8d5d79d2fbcf37d.1476108863.git.mengdong.lin@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Rename the function to create a FE link

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

>From ab4bc5eed8e9c9fa36d80d58c55300dd1eef29a3 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Thu, 3 Nov 2016 01:04:42 +0800
Subject: [PATCH] ASoC: topology: Rename the function to create a FE link

Just code refactoring. The function soc_tplg_link_create() will
create a front end link, not a physical link. So rename it to
soc_tplg_fe_link_create().

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b15a2049efcf..eea28ade5b32 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1704,7 +1704,7 @@ static void set_link_flags(struct snd_soc_dai_link *link,
 }
 
 /* create the FE DAI link */
-static int soc_tplg_link_create(struct soc_tplg *tplg,
+static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
 	struct snd_soc_dai_link *link;
@@ -1760,7 +1760,7 @@ static int soc_tplg_pcm_create(struct soc_tplg *tplg,
 	if (ret < 0)
 		return ret;
 
-	return  soc_tplg_link_create(tplg, pcm);
+	return  soc_tplg_fe_link_create(tplg, pcm);
 }
 
 /* copy stream caps from the old version 4 of source */
-- 
2.10.1
