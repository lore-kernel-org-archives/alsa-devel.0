From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: check memory allocation
	failure" to the asoc tree
Date: Sun, 27 Aug 2017 14:37:32 +0100 (BST)
Message-ID: <20170827133732.BF3E34400E7@finisterre.ee.mobilebroadband>
References: <20170827064650.7562-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2883426684C
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 15:37:35 +0200 (CEST)
In-Reply-To: <20170827064650.7562-1-christophe.jaillet@wanadoo.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, peter.ujfalusi@ti.com, broonie@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: check memory allocation failure

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4243e0457c9b1fe5e96fba19296469466eb24b1d Mon Sep 17 00:00:00 2001
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Sun, 27 Aug 2017 08:46:50 +0200
Subject: [PATCH] ASoC: davinci-mcasp: check memory allocation failure

Check memory allocation failures and return -ENOMEM in such cases, as
already done above for another memory allocation.

This avoids NULL pointers dereference.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d486908d4e0e..f395bbc7c354 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1851,6 +1851,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	mcasp->context.xrsr_regs = devm_kzalloc(&pdev->dev,
 					sizeof(u32) * mcasp->num_serializer,
 					GFP_KERNEL);
+	if (!mcasp->context.xrsr_regs) {
+		ret = -ENOMEM;
+		goto err;
+	}
 #endif
 	mcasp->serial_dir = pdata->serial_dir;
 	mcasp->version = pdata->version;
-- 
2.13.2
