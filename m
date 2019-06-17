From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: topology: add cpu_dai_name for
	DAIs" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:28 +0100 (BST)
Message-ID: <20190617152428.27304440046@finisterre.sirena.org.uk>
References: <20190612172347.22338-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9E0DF8973F
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:28 +0200 (CEST)
In-Reply-To: <20190612172347.22338-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: topology: add cpu_dai_name for DAIs

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

>From 1b7e1956860d7566325502651c6bf14f115cd91d Mon Sep 17 00:00:00 2001
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:35 -0500
Subject: [PATCH] ASoC: SOF: topology: add cpu_dai_name for DAIs

Add the cpu_dai_name member to snd_sof_dai and save the
cpu_dai_name while setting the DAI config.

The internal SOF representation will have to change at a later point
as well when we have multiple CPU dais.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/sof-priv.h | 1 +
 sound/soc/sof/topology.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 8760a4694d8f..8c3ac149bbb9 100644
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
