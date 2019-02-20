From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: Fix of-node refcount unbalance in
	fsl_ssi_probe_from_dt()" to the asoc tree
Date: Wed, 20 Feb 2019 12:13:18 +0000 (GMT)
Message-ID: <20190220121318.4D24311274ED@debutante.sirena.org.uk>
References: <20190219154652.13644-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79DBDF8079B
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 13:13:19 +0100 (CET)
In-Reply-To: <20190219154652.13644-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: Fix of-node refcount unbalance in fsl_ssi_probe_from_dt()

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

>From 2757970f6d0d0a112247600b23d38c0c728ceeb3 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 19 Feb 2019 16:46:47 +0100
Subject: [PATCH] ASoC: fsl: Fix of-node refcount unbalance in
 fsl_ssi_probe_from_dt()

The node obtained from of_find_node_by_path() has to be unreferenced
after the use, but we forgot it for the root node.

Fixes: f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support")
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0a648229e643..09b2967befd9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1439,8 +1439,10 @@ static int fsl_ssi_probe_from_dt(struct fsl_ssi *ssi)
 	 * different name to register the device.
 	 */
 	if (!ssi->card_name[0] && of_get_property(np, "codec-handle", NULL)) {
-		sprop = of_get_property(of_find_node_by_path("/"),
-					"compatible", NULL);
+		struct device_node *root = of_find_node_by_path("/");
+
+		sprop = of_get_property(root, "compatible", NULL);
+		of_node_put(root);
 		/* Strip "fsl," in the compatible name if applicable */
 		p = strrchr(sprop, ',');
 		if (p)
-- 
2.20.1
