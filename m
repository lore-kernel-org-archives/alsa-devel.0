From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Use a copy of pdata per
	instance during DT boot" to the asoc tree
Date: Thu, 02 Jun 2016 11:18:51 +0100
Message-ID: <E1b8PiF-0001cM-6d@finisterre>
References: <20160602095524.6967-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E63B9266803
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 12:19:03 +0200 (CEST)
In-Reply-To: <20160602095524.6967-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Use a copy of pdata per instance during DT boot

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

>From 272ee030ebc9da58a5796e6e26f78b77ecce7c21 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 2 Jun 2016 12:55:24 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Use a copy of pdata per instance during
 DT boot

Instead of modifying the static pdata struct per McASP instance we need to
allocate pdata for each McASP.
This way we can avoid configuration leakage from prior McASP to McASP
drivers probed at later time.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 237dc67002ef..05c2d33aa74d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1599,7 +1599,14 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 		pdata = pdev->dev.platform_data;
 		return pdata;
 	} else if (match) {
-		pdata = (struct davinci_mcasp_pdata*) match->data;
+		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
+				     GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev,
+				"Failed to allocate memory for pdata\n");
+			ret = -ENOMEM;
+			return pdata;
+		}
 	} else {
 		/* control shouldn't reach here. something is wrong */
 		ret = -EINVAL;
-- 
2.8.1
