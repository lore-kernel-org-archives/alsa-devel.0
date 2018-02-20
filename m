From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: Fix module unloading caused
	kernel crash" to the asoc tree
Date: Tue, 20 Feb 2018 14:25:26 +0000
Message-ID: <E1eo8rG-0000Tm-PS@debutante>
References: <20180220141905.20778-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 35088267502
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 15:25:31 +0100 (CET)
In-Reply-To: <20180220141905.20778-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: Fix module unloading caused kernel crash

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

>From 5e558f8afaec8957932b1dbe5aeff800f9fc6957 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 20 Feb 2018 16:19:05 +0200
Subject: [PATCH] ASoC: hdmi-codec: Fix module unloading caused kernel crash

The hcp->chmap_info must not be freed up in the hdmi_codec_remove()
function as it leads to kernel crash due ALSA core's
pcm_chmap_ctl_private_free() is trying to free it up again when the card
destroyed via snd_card_free.

Commit cd6111b26280a ("ASoC: hdmi-codec: add channel mapping control")
should not have added the kfree(hcp->chmap_info); to the hdmi_codec_remove
function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Tested-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 5672e516bec3..c1830ccd3bb8 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -798,12 +798,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 static int hdmi_codec_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct hdmi_codec_priv *hcp;
-
-	hcp = dev_get_drvdata(dev);
-	kfree(hcp->chmap_info);
-	snd_soc_unregister_codec(dev);
+	snd_soc_unregister_codec(&pdev->dev);
 
 	return 0;
 }
-- 
2.16.1
