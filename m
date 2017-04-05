From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Set .of_match_table to OF
	device ID table" to the asoc tree
Date: Wed, 05 Apr 2017 18:30:54 +0100
Message-ID: <E1cvoli-0000lu-4r@debutante>
References: <20170404185930.1437-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ADF626716B
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 19:31:04 +0200 (CEST)
In-Reply-To: <20170404185930.1437-1-javier@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Set .of_match_table to OF device ID table

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

>From 13023ff3b3372543e4197b4b57d378350780fe96 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 4 Apr 2017 14:59:30 -0400
Subject: [PATCH] ASoC: cs53l30: Set .of_match_table to OF device ID table

The driver has an OF device ID table but the struct i2c_driver
.of_match_table field is not set.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index cb47fb595ff4..1e0d5973b758 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -1130,6 +1130,7 @@ MODULE_DEVICE_TABLE(i2c, cs53l30_id);
 static struct i2c_driver cs53l30_i2c_driver = {
 	.driver = {
 		.name = "cs53l30",
+		.of_match_table = cs53l30_of_match,
 		.pm = &cs53l30_runtime_pm,
 	},
 	.id_table = cs53l30_id,
-- 
2.11.0
