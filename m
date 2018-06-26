From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-utils: Fix unregistration order" to
	the asoc tree
Date: Tue, 26 Jun 2018 16:12:05 +0100 (BST)
Message-ID: <20180626151205.39553440070@finisterre.ee.mobilebroadband>
References: <1530014315-17674-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 683EF267904
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 17:12:06 +0200 (CEST)
In-Reply-To: <1530014315-17674-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-utils: Fix unregistration order

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

>From b66c9b911fe6ca188002b342b05c43deab4491a3 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 26 Jun 2018 08:58:35 -0300
Subject: [PATCH] ASoC: soc-utils: Fix unregistration order

The unregistration should happen in the opposite order of
the registration, so change it accordingly.

No real issue has been noticed, but it is good practice to
keep the correct unregistration order.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 2d9e98bd1530..a863bb3f66c2 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -381,6 +381,6 @@ int __init snd_soc_util_init(void)
 
 void __exit snd_soc_util_exit(void)
 {
-	platform_device_unregister(soc_dummy_dev);
 	platform_driver_unregister(&soc_dummy_driver);
+	platform_device_unregister(soc_dummy_dev);
 }
-- 
2.17.1
