From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Fix error return code in soc_tplg_dapm_widget_create()" to the asoc tree
Date: Fri, 12 Aug 2016 13:29:52 +0100
Message-ID: <E1bYBay-0002jG-1N@debutante>
References: <1470836592-11679-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470836592-11679-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Fix error return code in soc_tplg_dapm_widget_create()

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

>From 8ae3ea48df0d746b663057cf0b972a18d0777b7b Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Wed, 10 Aug 2016 13:43:12 +0000
Subject: [PATCH] ASoC: topology: Fix error return code in
 soc_tplg_dapm_widget_create()

Fix to return error code -ENOMEM instead of 0 when failed to create
widget, as done elsewhere in this function.

Fixes: 8a9782346dcc ("ASoC: topology: Add topology core")
Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 05a18f68bfd0..a9e83a2dd91c 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1476,6 +1476,7 @@ widget:
 	if (widget == NULL) {
 		dev_err(tplg->dev, "ASoC: failed to create widget %s controls\n",
 			w->name);
+		ret = -ENOMEM;
 		goto hdr_err;
 	}
 
-- 
2.8.1
