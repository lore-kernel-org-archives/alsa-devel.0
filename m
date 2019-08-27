From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: imx8: Fix an is IS_ERR() vs NULL
	check" to the asoc tree
Date: Tue, 27 Aug 2019 20:58:10 +0100 (BST)
Message-ID: <20190827195810.443E9D02CE8@fitzroy.sirena.org.uk>
References: <20190826131855.GA6840@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79E04F8065B
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2019 21:58:14 +0200 (CEST)
In-Reply-To: <20190826131855.GA6840@mwanda>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: imx8: Fix an is IS_ERR() vs NULL check

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From a325c7bc3a92f1d5ba8cff10d7ab93a989cdeb80 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 26 Aug 2019 16:18:55 +0300
Subject: [PATCH] ASoC: SOF: imx8: Fix an is IS_ERR() vs NULL check

The device_link_add() function only returns NULL on error, it doesn't
return error pointers.

Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20190826131855.GA6840@mwanda
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/imx/imx8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index c9d849ced54a..2a22b18e5ec0 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -227,8 +227,8 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 						DL_FLAG_STATELESS |
 						DL_FLAG_PM_RUNTIME |
 						DL_FLAG_RPM_ACTIVE);
-		if (IS_ERR(priv->link[i])) {
-			ret = PTR_ERR(priv->link[i]);
+		if (!priv->link[i]) {
+			ret = -ENOMEM;
 			dev_pm_domain_detach(priv->pd_dev[i], false);
 			goto exit_unroll_pm;
 		}
-- 
2.20.1
