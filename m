From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: Fix a NULL vs IS_ERR() check in
	probe" to the asoc tree
Date: Mon, 26 Nov 2018 17:21:05 +0000 (GMT)
Message-ID: <20181126172105.62712112519F@debutante.sirena.org.uk>
References: <20181126081307.qhbpwnlikquep476@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 38EFD267AE4
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 18:21:07 +0100 (CET)
In-Reply-To: <20181126081307.qhbpwnlikquep476@kili.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Sanju R Mehta <sanju.mehta@amd.com>, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: Fix a NULL vs IS_ERR() check in probe

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

>From 83b12c2e1d942459f420490d4219fc1ad38c3620 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 26 Nov 2018 11:13:07 +0300
Subject: [PATCH] ASoC: amd: Fix a NULL vs IS_ERR() check in probe

The platform_device_register_full() function doesn't return NULL, it
returns error pointers.

Fixes: 7894a7e7ea3d ("ASoC: amd: create ACP3x PCM platform device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/pci-acp3x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index c28457fd9b81..facec2472b34 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -97,10 +97,10 @@ static int snd_acp3x_probe(struct pci_dev *pci,
 		pdevinfo.size_data = sizeof(irqflags);
 
 		adata->pdev = platform_device_register_full(&pdevinfo);
-		if (!adata->pdev) {
+		if (IS_ERR(adata->pdev)) {
 			dev_err(&pci->dev, "cannot register %s device\n",
 				pdevinfo.name);
-			ret = -ENODEV;
+			ret = PTR_ERR(adata->pdev);
 			goto unmap_mmio;
 		}
 		break;
-- 
2.19.0.rc2
