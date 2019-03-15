From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: create tlv before
	soc_tplg_init_kcontrol" to the asoc tree
Date: Fri, 15 Mar 2019 17:15:10 +0000 (GMT)
Message-ID: <20190315171510.07E2D1126E81@debutante.sirena.org.uk>
References: <20190313134943.29994-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 260A0F89673
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 18:15:18 +0100 (CET)
In-Reply-To: <20190313134943.29994-1-yung-chuan.liao@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Bard liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: create tlv before soc_tplg_init_kcontrol

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

>From 3789debfc379ac84b90e2db32d7a6b66d28a2c7c Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Wed, 13 Mar 2019 21:49:43 +0800
Subject: [PATCH] ASoC: topology: create tlv before soc_tplg_init_kcontrol

Component driver may want to use tlv data. Create tlv before
soc_tplg_init_kcontrol so component driver can use the tlv data
in the control_load ops.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 25fca7055464..fbee4720b834 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -894,19 +894,20 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
 			continue;
 		}
 
+		/* create any TLV data */
+		soc_tplg_create_tlv(tplg, &kc, &mc->hdr);
+
 		/* pass control to driver for optional further init */
 		err = soc_tplg_init_kcontrol(tplg, &kc,
 			(struct snd_soc_tplg_ctl_hdr *) mc);
 		if (err < 0) {
 			dev_err(tplg->dev, "ASoC: failed to init %s\n",
 				mc->hdr.name);
+			soc_tplg_free_tlv(tplg, &kc);
 			kfree(sm);
 			continue;
 		}
 
-		/* create any TLV data */
-		soc_tplg_create_tlv(tplg, &kc, &mc->hdr);
-
 		/* register control here */
 		err = soc_tplg_add_kcontrol(tplg, &kc,
 			&sm->dobj.control.kcontrol);
@@ -1324,18 +1325,19 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 			continue;
 		}
 
+		/* create any TLV data */
+		soc_tplg_create_tlv(tplg, &kc[i], &mc->hdr);
+
 		/* pass control to driver for optional further init */
 		err = soc_tplg_init_kcontrol(tplg, &kc[i],
 			(struct snd_soc_tplg_ctl_hdr *)mc);
 		if (err < 0) {
 			dev_err(tplg->dev, "ASoC: failed to init %s\n",
 				mc->hdr.name);
+			soc_tplg_free_tlv(tplg, &kc[i]);
 			kfree(sm);
 			continue;
 		}
-
-		/* create any TLV data */
-		soc_tplg_create_tlv(tplg, &kc[i], &mc->hdr);
 	}
 	return kc;
 
-- 
2.20.1
