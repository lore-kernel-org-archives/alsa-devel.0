From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Check name strings of
	physical DAI links" to the asoc tree
Date: Wed, 09 Nov 2016 14:58:52 +0000
Message-ID: <E1c4UKy-0002Zn-Bo@finisterre>
References: <1478306534-23587-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFDC5266B53
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 15:59:11 +0100 (CET)
In-Reply-To: <1478306534-23587-1-git-send-email-mengdong.lin@linux.intel.com>
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

   ASoC: topology: Check name strings of physical DAI links

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

>From dbab1cb88e84813254091d0d02ab83d9929e6a27 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Sat, 5 Nov 2016 08:42:14 +0800
Subject: [PATCH] ASoC: topology: Check name strings of physical DAI links

Check if the name strings are properly terminated, and only use valid
name strings to find existing physical DAI links to configure.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 8772fd994e82..4dfdc656cce6 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1994,10 +1994,24 @@ static int soc_tplg_link_config(struct soc_tplg *tplg,
 {
 	struct snd_soc_dai_link *link;
 	const char *name, *stream_name;
+	size_t len;
 	int ret;
 
-	name = strlen(cfg->name) ? cfg->name : NULL;
-	stream_name = strlen(cfg->stream_name) ? cfg->stream_name : NULL;
+	len = strnlen(cfg->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	if (len == SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
+		return -EINVAL;
+	else if (len)
+		name = cfg->name;
+	else
+		name = NULL;
+
+	len = strnlen(cfg->stream_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	if (len == SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
+		return -EINVAL;
+	else if (len)
+		stream_name = cfg->stream_name;
+	else
+		stream_name = NULL;
 
 	link = snd_soc_find_dai_link(tplg->comp->card, cfg->id,
 				     name, stream_name);
-- 
2.10.2
