From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-topology: fix modern dai link
	style" to the asoc tree
Date: Thu, 13 Jun 2019 20:06:08 +0100 (BST)
Message-ID: <20190613190608.D1A29440049@finisterre.sirena.org.uk>
References: <20190612163845.10671-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F065F8976B
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:06:09 +0200 (CEST)
In-Reply-To: <20190612163845.10671-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-topology: fix modern dai link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 3e6de89409bf7ad149bfb05dd0dce6c5678ea0a8 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 12 Jun 2019 11:38:45 -0500
Subject: [PATCH] ASoC: soc-topology: fix modern dai link style

The topology code can create a FE DAI link but did not allocate the
memory for a platform component - whose name can be overridden at a
later time.

Fixes: 23b946ce2808b ("ASoC: soc-topology: use modern dai_link style")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f485f7f751a1..b538412e4bcf 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1882,8 +1882,8 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	struct snd_soc_dai_link_component *dlc;
 	int ret;
 
-	/* link + cpu + codec */
-	link = kzalloc(sizeof(*link) + (2 * sizeof(*dlc)), GFP_KERNEL);
+	/* link + cpu + codec + platform */
+	link = kzalloc(sizeof(*link) + (3 * sizeof(*dlc)), GFP_KERNEL);
 	if (link == NULL)
 		return -ENOMEM;
 
@@ -1891,9 +1891,11 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 
 	link->cpus	= &dlc[0];
 	link->codecs	= &dlc[1];
+	link->platforms	= &dlc[2];
 
 	link->num_cpus	 = 1;
 	link->num_codecs = 1;
+	link->num_platforms = 1;
 
 	if (strlen(pcm->pcm_name)) {
 		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
@@ -1907,6 +1909,8 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 	link->codecs->name = "snd-soc-dummy";
 	link->codecs->dai_name = "snd-soc-dummy-dai";
 
+	link->platforms->name = "snd-soc-dummy";
+
 	/* enable DPCM */
 	link->dynamic = 1;
 	link->dpcm_playback = le32_to_cpu(pcm->playback);
-- 
2.20.1
