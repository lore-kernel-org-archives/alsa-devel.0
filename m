From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: add link management" to the
	asoc tree
Date: Fri, 13 May 2016 13:26:42 +0100
Message-ID: <E1b1CB0-0007Q3-WC@finisterre>
References: <1462428071-30248-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 852BD2606FE
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:27:08 +0200 (CEST)
In-Reply-To: <1462428071-30248-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: add link management

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

>From b2047e996cd88d36eb0f4e84fe6aedab831a4b31 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 12 May 2016 08:58:55 +0530
Subject: [PATCH] ASoC: hdac_hdmi: add link management

Manage the hda idisp link using shiny new link APIs.  We need to
keep link On while we probe and also hold the reference in runtime
resume and drop in suspend

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index aaa038ffc8a5..13002f33384e 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1378,10 +1378,18 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(&codec->component);
 	struct hdac_hdmi_pin *pin;
+	struct hdac_ext_link *hlink = NULL;
 	int ret;
 
 	edev->scodec = codec;
 
+	/*
+	 * hold the ref while we probe, also no need to drop the ref on
+	 * exit, we call pm_runtime_suspend() so that will do for us
+	 */
+	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdac.dev));
+	snd_hdac_ext_bus_link_get(edev->ebus, hlink);
+
 	ret = create_fill_widget_route_map(dapm);
 	if (ret < 0)
 		return ret;
@@ -1480,9 +1488,14 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	struct hdac_device *codec = &edev->hdac;
 	struct hdac_hdmi_priv *hdmi_priv;
 	struct snd_soc_dai_driver *hdmi_dais = NULL;
+	struct hdac_ext_link *hlink = NULL;
 	int num_dais = 0;
 	int ret = 0;
 
+	/* hold the ref while we probe */
+	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdac.dev));
+	snd_hdac_ext_bus_link_get(edev->ebus, hlink);
+
 	hdmi_priv = devm_kzalloc(&codec->dev, sizeof(*hdmi_priv), GFP_KERNEL);
 	if (hdmi_priv == NULL)
 		return -ENOMEM;
@@ -1516,8 +1529,12 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	}
 
 	/* ASoC specific initialization */
-	return snd_soc_register_codec(&codec->dev, &hdmi_hda_codec,
-			hdmi_dais, num_dais);
+	ret = snd_soc_register_codec(&codec->dev, &hdmi_hda_codec,
+					hdmi_dais, num_dais);
+
+	snd_hdac_ext_bus_link_put(edev->ebus, hlink);
+
+	return ret;
 }
 
 static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
@@ -1556,6 +1573,9 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_bus *bus = hdac->bus;
+	unsigned long timeout;
+	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
+	struct hdac_ext_link *hlink = NULL;
 	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
@@ -1579,6 +1599,9 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 		return err;
 	}
 
+	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
+	snd_hdac_ext_bus_link_put(ebus, hlink);
+
 	return 0;
 }
 
@@ -1587,6 +1610,8 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_bus *bus = hdac->bus;
+	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
+	struct hdac_ext_link *hlink = NULL;
 	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
@@ -1595,6 +1620,9 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	if (!bus)
 		return 0;
 
+	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
+	snd_hdac_ext_bus_link_get(ebus, hlink);
+
 	err = snd_hdac_display_power(bus, true);
 	if (err < 0) {
 		dev_err(bus->dev, "Cannot turn on display power on i915\n");
-- 
2.8.1
