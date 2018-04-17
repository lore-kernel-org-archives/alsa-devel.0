From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Add name prefix for machines with
	topology rewrites" to the asoc tree
Date: Tue, 17 Apr 2018 18:09:18 +0100
Message-ID: <E1f8U6Y-0001cd-7Y@debutante>
References: <20180314202511.13614-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 73BCA266C99
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 19:09:20 +0200 (CEST)
In-Reply-To: <20180314202511.13614-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Add name prefix for machines with topology rewrites

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

>From f11a5c27f9287cacad74af31cd92d4413eccc05a Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 27 Mar 2018 14:30:41 +0100
Subject: [PATCH] ASoC: core: Add name prefix for machines with topology
 rewrites

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 2 ++
 sound/soc/soc-core.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fac4ff04fb7d..3676d0a8f532 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1015,6 +1015,7 @@ struct snd_soc_platform_driver {
 
 	/* this platform uses topology and ignore machine driver FEs */
 	const char *ignore_machine;
+	const char *topology_name_prefix;
 	int (*be_hw_params_fixup)(struct snd_soc_pcm_runtime *rtd,
 				  struct snd_pcm_hw_params *params);
 	bool use_dai_pcm_id;	/* use the DAI link PCM ID as PCM device number */
@@ -1167,6 +1168,7 @@ struct snd_soc_card {
 	const char *long_name;
 	const char *driver_name;
 	char dmi_longname[80];
+	char topology_shortname[32];
 
 	struct device *dev;
 	struct snd_card *snd_card;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8f01fe8296ff..aa1c33b3cce0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2143,6 +2143,14 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 			if (!dai_link->stream_name)
 				dai_link->stream_name = dai_link->name;
 		}
+
+		/* Inform userspace we are using alternate topology */
+		if (platform->driver->topology_name_prefix) {
+			snprintf(card->topology_shortname, 32, "%s-%s",
+				 platform->driver->topology_name_prefix,
+				 card->name);
+			card->name = card->topology_shortname;
+		}
 	}
 }
 
-- 
2.17.0
