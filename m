From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: topology: add min/max step for
	volume_table" to the asoc tree
Date: Thu, 13 Jun 2019 20:06:00 +0100 (BST)
Message-ID: <20190613190600.19E58440046@finisterre.sirena.org.uk>
References: <20190612170148.15327-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4046F8975D
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:06:05 +0200 (CEST)
In-Reply-To: <20190612170148.15327-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: topology: add min/max step for volume_table

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

>From aa66fd80e0813fab0146e001b8bef8c4ffe0ba3a Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Wed, 12 Jun 2019 12:01:45 -0500
Subject: [PATCH] ASoC: SOF: topology: add min/max step for volume_table

add two units min_volume_step and max_volume_step to the snd_sof_control
struct, for the min and max step of the volume_table.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/sof-priv.h | 2 ++
 sound/soc/sof/topology.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 17f3d2a5a701..8760a4694d8f 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -297,6 +297,8 @@ struct snd_sof_pcm {
 struct snd_sof_control {
 	struct snd_sof_dev *sdev;
 	int comp_id;
+	int min_volume_step; /* min volume step for volume_table */
+	int max_volume_step; /* max volume step for volume_table */
 	int num_channels;
 	u32 readback_offset; /* offset to mmaped data if used */
 	struct sof_ipc_ctrl_data *control_data;
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index a13233ae6d0e..1c661dec8dd4 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -451,6 +451,8 @@ static int sof_control_load_volume(struct snd_soc_component *scomp,
 		return -ENOMEM;
 
 	scontrol->comp_id = sdev->next_comp_id;
+	scontrol->min_volume_step = le32_to_cpu(mc->min);
+	scontrol->max_volume_step = le32_to_cpu(mc->max);
 	scontrol->num_channels = le32_to_cpu(mc->num_channels);
 
 	/* set cmd for mixer control */
-- 
2.20.1
