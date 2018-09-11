From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hda: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Tue, 11 Sep 2018 12:24:49 +0100 (BST)
Message-ID: <20180911112449.DAFC81121AF8@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 820E82676EB
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 13:24:50 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hda: use devm_snd_soc_register_component()

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

>From 10ccaa39d7628470a3de4aae9d2346a55cbee46e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 7 Sep 2018 01:01:19 +0000
Subject: [PATCH] ASoC: hdac_hda: use devm_snd_soc_register_component()

Now we have devm_snd_soc_register_component().
Let's use it instead of snd_soc_register_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 8c25a1332fa7..2aaa83028e55 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -448,7 +448,7 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 		return -ENOMEM;
 
 	/* ASoC specific initialization */
-	ret = snd_soc_register_component(&hdev->dev,
+	ret = devm_snd_soc_register_component(&hdev->dev,
 					 &hdac_hda_codec, hdac_hda_dais,
 					 ARRAY_SIZE(hdac_hda_dais));
 	if (ret < 0) {
@@ -464,7 +464,6 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 
 static int hdac_hda_dev_remove(struct hdac_device *hdev)
 {
-	snd_soc_unregister_component(&hdev->dev);
 	return 0;
 }
 
-- 
2.19.0.rc2
