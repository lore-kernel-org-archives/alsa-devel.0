From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix memory leak" to the asoc tree
Date: Mon, 22 Feb 2016 19:51:31 +0900
Message-ID: <E1aXo5T-0005fa-5f@finisterre>
References: <1456130671-12365-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EEB322655B6
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 11:51:42 +0100 (CET)
In-Reply-To: <1456130671-12365-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix memory leak

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

>From 513cb31120fb5a5b02d9e42eb1d0a0bf05e227c5 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 22 Feb 2016 14:14:31 +0530
Subject: [PATCH] ASoC: fix memory leak

If dai_link is already bound then we just returned and leaked rtd and
rtd->codec_dais which were allocated by soc_new_pcm_runtime(). We do not
need this newly allocated rtd to check if dai_link is already binded. Lets
check first if it is already binded before allocating this memory.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 790ee2bf1a47..d2e62b159610 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -986,16 +986,16 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
 
-	rtd = soc_new_pcm_runtime(card, dai_link);
-	if (!rtd)
-		return -ENOMEM;
-
 	if (soc_is_dai_link_bound(card, dai_link)) {
 		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
 			dai_link->name);
 		return 0;
 	}
 
+	rtd = soc_new_pcm_runtime(card, dai_link);
+	if (!rtd)
+		return -ENOMEM;
+
 	cpu_dai_component.name = dai_link->cpu_name;
 	cpu_dai_component.of_node = dai_link->cpu_of_node;
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
-- 
2.7.0
