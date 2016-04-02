From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix to use dev_pm ops
	instead soc pm" to the asoc tree
Date: Sat, 02 Apr 2016 09:39:20 -0700
Message-ID: <E1amOa0-0002CP-LZ@finisterre>
References: <1459497987-28979-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A1CD5260524
 for <alsa-devel@alsa-project.org>; Sat,  2 Apr 2016 18:39:25 +0200 (CEST)
In-Reply-To: <1459497987-28979-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Fix to use dev_pm ops instead soc pm

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

>From 0fee1798af81b1428d8d5886ea48116444e635fc Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 1 Apr 2016 13:36:25 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix to use dev_pm ops instead soc pm

Use dev_pm ops feature instead of soc pm as core assumes system
is capable of direct complete. Register with complete callback
instead of resume to synchronize with Jack notification from
display driver. This ensures correct Jack notification to user
space.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 26f9459cb3bc..da3432c9f64d 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1420,9 +1420,9 @@ static int hdmi_codec_remove(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int hdmi_codec_resume(struct snd_soc_codec *codec)
+static void hdmi_codec_complete(struct device *dev)
 {
-	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pin *pin;
 	struct hdac_device *hdac = &edev->hdac;
@@ -1464,19 +1464,15 @@ static int hdmi_codec_resume(struct snd_soc_codec *codec)
 		dev_err(bus->dev,
 			"Cannot turn OFF display power on i915, err: %d\n",
 			err);
-		return err;
 	}
-
-	return 0;
 }
 #else
-#define hdmi_codec_resume NULL
+#define hdmi_codec_complete NULL
 #endif
 
 static struct snd_soc_codec_driver hdmi_hda_codec = {
 	.probe		= hdmi_codec_probe,
 	.remove		= hdmi_codec_remove,
-	.resume		= hdmi_codec_resume,
 	.idle_bias_off	= true,
 };
 
@@ -1629,6 +1625,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops hdac_hdmi_pm = {
 	SET_RUNTIME_PM_OPS(hdac_hdmi_runtime_suspend, hdac_hdmi_runtime_resume, NULL)
+	.complete = hdmi_codec_complete,
 };
 
 static const struct hda_device_id hdmi_list[] = {
-- 
2.8.0.rc3
