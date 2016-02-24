From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9713: fix regmap free path" to the
	asoc tree
Date: Wed, 24 Feb 2016 12:53:35 +0900
Message-ID: <E1aYQW7-0008IW-2x@finisterre>
References: <1456180544-29108-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3A826145E
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 04:53:42 +0100 (CET)
In-Reply-To: <1456180544-29108-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9713: fix regmap free path

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

>From da9b9303ed8d1673a89a4bdd85464e33614775e3 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 22 Feb 2016 23:35:44 +0100
Subject: [PATCH] ASoC: wm9713: fix regmap free path

In the conversion to regmap, I assumed that the devm_() variant could be
used in the soc probe function.

As a mater of fact with the current code the regmap is freed twice
because of the devm_() call:
(mutex_lock) from [<c01f6624>] (debugfs_remove_recursive+0x50/0x1d0)
(debugfs_remove_recursive) from [<c02bf800>] (regmap_debugfs_exit+0x1c/0xd4)
(regmap_debugfs_exit) from [<c02ba1f8>] (regmap_exit+0x28/0xc8)
(regmap_exit) from [<c02aa258>] (release_nodes+0x18c/0x204)
(release_nodes) from [<c02a278c>] (device_release+0x18/0x90)
(device_release) from [<c0239030>] (kobject_release+0x90/0x1bc)
(kobject_release) from [<c0395c94>] (wm9713_soc_remove+0x1c/0x24)
(wm9713_soc_remove) from [<c0384884>] (soc_remove_component+0x50/0x7c)
(soc_remove_component) from [<c0386c28>] (soc_remove_dai_links+0x118/0x228)
(soc_remove_dai_links) from [<c038721c>] (snd_soc_register_card+0x4e4/0xdd4)
(snd_soc_register_card) from [<c0393c54>] (devm_snd_soc_register_card+0x34/0x70)

Fix this by replacing the devm_regmap initialization code with the non
devm_() variant.

Fixes: 700dadfefc3d ASoC: wm9713: convert to regmap
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9713.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 79e143625ac3..9849643ef809 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1212,7 +1212,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	if (IS_ERR(wm9713->ac97))
 		return PTR_ERR(wm9713->ac97);
 
-	regmap = devm_regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
+	regmap = regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
 	if (IS_ERR(regmap)) {
 		snd_soc_free_ac97_codec(wm9713->ac97);
 		return PTR_ERR(regmap);
-- 
2.7.0
