From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/15] ASoC: SOF: topology: add cpu_dai_name
	for DAIs
Date: Wed, 12 Jun 2019 12:23:35 -0500
Message-ID: <20190612172347.22338-4-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DFD0F896E3
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:23:56 +0200 (CEST)
In-Reply-To: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add the cpu_dai_name member to snd_sof_dai and save the
cpu_dai_name while setting the DAI config.

The internal SOF representation will have to change at a later point
as well when we have multiple CPU dais.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-priv.h | 1 +
 sound/soc/sof/topology.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index d2dbca7d57d1..10e061a5c39c 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -337,6 +337,7 @@ struct snd_sof_route {
 struct snd_sof_dai {
 	struct snd_sof_dev *sdev;
 	const char *name;
+	const char *cpu_dai_name;
 
 	struct sof_ipc_comp_dai comp_dai;
 	struct sof_ipc_dai_config *dai_config;
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index aaf459af89d0..178256e338b1 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2360,6 +2360,9 @@ static int sof_set_dai_config(struct snd_sof_dev *sdev, u32 size,
 			if (!dai->dai_config)
 				return -ENOMEM;
 
+			/* set cpu_dai_name */
+			dai->cpu_dai_name = link->cpus->dai_name;
+
 			found = 1;
 		}
 	}
@@ -2624,6 +2627,8 @@ static int sof_link_hda_process(struct snd_sof_dev *sdev,
 			if (!sof_dai->dai_config)
 				return -ENOMEM;
 
+			sof_dai->cpu_dai_name = link->cpus->dai_name;
+
 			/* send message to DSP */
 			ret = sof_ipc_tx_message(sdev->ipc,
 						 config->hdr.cmd, config, size,
-- 
2.20.1
