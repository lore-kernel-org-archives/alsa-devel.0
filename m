From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: dfsdm: fix debugfs warnings on entry creation"
 to the asoc tree
Date: Wed, 20 Mar 2019 17:29:21 +0000 (GMT)
Message-ID: <20190320172921.6C3991126E4C@debutante.sirena.org.uk>
References: <1551711165-28684-3-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551711165-28684-3-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: dfsdm: fix debugfs warnings on entry creation

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

>From c47255b61129857b74b0d86eaf59335348be05e0 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 4 Mar 2019 15:52:44 +0100
Subject: [PATCH] ASoC: stm32: dfsdm: fix debugfs warnings on entry creation

Register platform component with a prefix, to avoid warnings
on debugfs entries creation, due to component name
redundancy.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index d77f0421e4f0..78bed9734713 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -305,6 +305,7 @@ MODULE_DEVICE_TABLE(of, stm32_adfsdm_of_match);
 static int stm32_adfsdm_probe(struct platform_device *pdev)
 {
 	struct stm32_adfsdm_priv *priv;
+	struct snd_soc_component *component;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -332,9 +333,15 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iio_cb))
 		return PTR_ERR(priv->iio_cb);
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &stm32_adfsdm_soc_platform,
-					      NULL, 0);
+	component = devm_kzalloc(&pdev->dev, sizeof(*component), GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+#ifdef CONFIG_DEBUG_FS
+	component->debugfs_prefix = "pcm";
+#endif
+
+	ret = snd_soc_add_component(&pdev->dev, component,
+				    &stm32_adfsdm_soc_platform, NULL, 0);
 	if (ret < 0)
 		dev_err(&pdev->dev, "%s: Failed to register PCM platform\n",
 			__func__);
@@ -342,12 +349,20 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int stm32_adfsdm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_component(&pdev->dev);
+
+	return 0;
+}
+
 static struct platform_driver stm32_adfsdm_driver = {
 	.driver = {
 		   .name = STM32_ADFSDM_DRV_NAME,
 		   .of_match_table = stm32_adfsdm_of_match,
 		   },
 	.probe = stm32_adfsdm_probe,
+	.remove = stm32_adfsdm_remove,
 };
 
 module_platform_driver(stm32_adfsdm_driver);
-- 
2.20.1
