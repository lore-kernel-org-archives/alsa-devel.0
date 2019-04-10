From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs43130: fix a NULL pointer dereference" to the asoc tree
Date: Wed, 10 Apr 2019 13:26:31 +0100 (BST)
Message-ID: <20190410122631.8683F1128ED2@debutante.sirena.org.uk>
References: <20190315035120.25913-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315035120.25913-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, pakki001@umn.edu, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs43130: fix a NULL pointer dereference

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

>From 51e3724aec01d30852f61d924ad01ce3ea782a0f Mon Sep 17 00:00:00 2001
From: Kangjie Lu <kjlu@umn.edu>
Date: Thu, 14 Mar 2019 22:51:20 -0500
Subject: [PATCH] ASoC: cs43130: fix a NULL pointer dereference

In case create_singlethread_workqueue fails, the fix returns
-ENOMEM to avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs43130.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 3f7b255587e6..80d672710eae 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2322,6 +2322,8 @@ static int cs43130_probe(struct snd_soc_component *component)
 			return ret;
 
 		cs43130->wq = create_singlethread_workqueue("cs43130_hp");
+		if (!cs43130->wq)
+			return -ENOMEM;
 		INIT_WORK(&cs43130->work, cs43130_imp_meas);
 	}
 
-- 
2.20.1
