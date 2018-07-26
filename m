From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Fix build warning" to the asoc tree
Date: Thu, 26 Jul 2018 14:09:50 +0100 (BST)
Message-ID: <20180726130950.2C983440078@finisterre.ee.mobilebroadband>
References: <1532585060-26060-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C49D26776E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 15:09:56 +0200 (CEST)
In-Reply-To: <1532585060-26060-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Fix build warning

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

>From 7699676081ded2e149e798f9205f1f089aa3a6bc Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Thu, 26 Jul 2018 14:04:08 +0800
Subject: [PATCH] ASoC: AMD: Fix build warning

Fixes
sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_probe':
sound/soc/amd/acp-da7219-max98357a.c:367:3: warning: 'ret' may
be used uninitialized in this function [-Wmaybe-uninitialized]
   dev_err(&pdev->dev, "Failed to register regulator: %d\n",
ret);

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index cd3cf6e691a9..8e3275a96a82 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -365,7 +365,7 @@ static int cz_probe(struct platform_device *pdev)
 				       &acp_da7219_cfg);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n",
-			ret);
+			(int)PTR_ERR(rdev));
 		return -EINVAL;
 	}
 
-- 
2.18.0
