From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc-pcm: replace platform to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:29:22 +0000
Message-ID: <E1elDEY-00036D-GR@debutante>
References: <87wp0new8y.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EDAF267444
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:29:26 +0100 (CET)
In-Reply-To: <87wp0new8y.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc-pcm: replace platform to component

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

>From ddce03ceea3c84bbfca6f465853b543b32184ec2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:47:38 +0000
Subject: [PATCH] ASoC: dwc-pcm: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/dwc-pcm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/dwc-pcm.c b/sound/soc/dwc/dwc-pcm.c
index 406fd867117b..2cc9632024fc 100644
--- a/sound/soc/dwc/dwc-pcm.c
+++ b/sound/soc/dwc/dwc-pcm.c
@@ -269,7 +269,7 @@ static const struct snd_pcm_ops dw_pcm_ops = {
 	.pointer = dw_pcm_pointer,
 };
 
-static const struct snd_soc_platform_driver dw_pcm_platform = {
+static const struct snd_soc_component_driver dw_pcm_component = {
 	.pcm_new = dw_pcm_new,
 	.pcm_free = dw_pcm_free,
 	.ops = &dw_pcm_ops,
@@ -277,5 +277,6 @@ static const struct snd_soc_platform_driver dw_pcm_platform = {
 
 int dw_pcm_register(struct platform_device *pdev)
 {
-	return devm_snd_soc_register_platform(&pdev->dev, &dw_pcm_platform);
+	return devm_snd_soc_register_component(&pdev->dev, &dw_pcm_component,
+					       NULL, 0);
 }
-- 
2.16.1
