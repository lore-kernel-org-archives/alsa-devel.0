From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 2/6] ASoC: core: Add name prefix for
	machines with topology rewrites
Date: Tue, 27 Mar 2018 14:30:41 +0100
Message-ID: <20180327133045.29351-3-liam.r.girdwood@linux.intel.com>
References: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EB37267194
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 15:31:02 +0200 (CEST)
In-Reply-To: <20180327133045.29351-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
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
2.14.1
