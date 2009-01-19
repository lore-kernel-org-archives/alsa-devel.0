From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.29] ASoC: fix registration of the SOC card
	in the Freescale MPC8610 drivers
Date: Mon, 19 Jan 2009 17:14:24 -0600
Message-ID: <1232406864-25421-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 89C6E243D4
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 00:14:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The Freescale MPC8610 driver was defining two SOC card (snd_soc_card) structures,
partially initializing each one, but registering only one of them with ASoC.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/mpc8610_hpcd.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index bcec3f6..acf39a6 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -183,16 +183,6 @@ static struct snd_soc_ops mpc8610_hpcd_ops = {
 };
 
 /**
- * mpc8610_hpcd_machine: ASoC machine data
- */
-static struct snd_soc_card mpc8610_hpcd_machine = {
-	.probe = mpc8610_hpcd_machine_probe,
-	.remove = mpc8610_hpcd_machine_remove,
-	.name = "MPC8610 HPCD",
-	.num_links = 1,
-};
-
-/**
  * mpc8610_hpcd_probe: OF probe function for the fabric driver
  *
  * This function gets called when an SSI node is found in the device tree.
@@ -455,7 +445,11 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 	machine_data->dai.codec_dai = &cs4270_dai; /* The codec_dai we want */
 	machine_data->dai.ops = &mpc8610_hpcd_ops;
 
-	mpc8610_hpcd_machine.dai_link = &machine_data->dai;
+	machine_data->machine.probe = mpc8610_hpcd_machine_probe;
+	machine_data->machine.remove = mpc8610_hpcd_machine_remove;
+	machine_data->machine.name = "MPC8610 HPCD";
+	machine_data->machine.num_links = 1;
+	machine_data->machine.dai_link = &machine_data->dai;
 
 	/* Allocate a new audio platform device structure */
 	sound_device = platform_device_alloc("soc-audio", -1);
@@ -465,7 +459,7 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 		goto error;
 	}
 
-	machine_data->sound_devdata.card = &mpc8610_hpcd_machine;
+	machine_data->sound_devdata.card = &machine_data->machine;
 	machine_data->sound_devdata.codec_dev = &soc_codec_device_cs4270;
 	machine_data->machine.platform = &fsl_soc_platform;
 
-- 
1.5.5
