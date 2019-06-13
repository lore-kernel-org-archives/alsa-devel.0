From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: topology: pass volume min/max
	linear value to FW" to the asoc tree
Date: Thu, 13 Jun 2019 20:05:59 +0100 (BST)
Message-ID: <20190613190559.7B02E440046@finisterre.sirena.org.uk>
References: <20190612170148.15327-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0197EF89757
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:06:00 +0200 (CEST)
In-Reply-To: <20190612170148.15327-3-pierre-louis.bossart@linux.intel.com>
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

   ASoC: SOF: topology: pass volume min/max linear value to FW

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

>From 65a18a46b274e64012fcf19d79ac62c8fb2a12e9 Mon Sep 17 00:00:00 2001
From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Date: Wed, 12 Jun 2019 12:01:46 -0500
Subject: [PATCH] ASoC: SOF: topology: pass volume min/max linear value to FW

The driver currently passes the volume ramp type and length
topology tokens to firmware, but the min and max volume are
not set. This patch provides a correction to convert the
information from the topology file and pass the linear volume
min/max value to the firmware to improve transitions.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/topology.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 1c661dec8dd4..bbad8053b1bc 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1552,6 +1552,9 @@ static int sof_widget_load_pga(struct snd_soc_component *scomp, int index,
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
 	struct snd_soc_tplg_private *private = &tw->priv;
 	struct sof_ipc_comp_volume *volume;
+	struct snd_sof_control *scontrol;
+	int min_step;
+	int max_step;
 	int ret;
 
 	volume = kzalloc(sizeof(*volume), GFP_KERNEL);
@@ -1594,6 +1597,17 @@ static int sof_widget_load_pga(struct snd_soc_component *scomp, int index,
 
 	swidget->private = volume;
 
+	list_for_each_entry(scontrol, &sdev->kcontrol_list, list) {
+		if (scontrol->comp_id == swidget->comp_id) {
+			min_step = scontrol->min_volume_step;
+			max_step = scontrol->max_volume_step;
+			volume->min_value = scontrol->volume_table[min_step];
+			volume->max_value = scontrol->volume_table[max_step];
+			volume->channels = scontrol->num_channels;
+			break;
+		}
+	}
+
 	ret = sof_ipc_tx_message(sdev->ipc, volume->comp.hdr.cmd, volume,
 				 sizeof(*volume), r, sizeof(*r));
 	if (ret >= 0)
-- 
2.20.1
