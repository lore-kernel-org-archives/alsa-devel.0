From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Fix potential NULL
	dereference" to the asoc tree
Date: Mon, 11 Jul 2016 18:42:02 +0100
Message-ID: <E1bMfDW-0007eo-Rv@debutante>
References: <1464701995-23452-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B27E9265D2B
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 19:42:07 +0200 (CEST)
In-Reply-To: <1464701995-23452-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Fix potential NULL dereference

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

>From 7edf4db15899214867fe60bd31102309f2cc5ede Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 31 May 2016 19:09:55 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Fix potential NULL dereference

Static checker warns:
Pointer 'hlink' returned from call to function 'snd_hdac_ext_bus_get_link'
at line may be NULL and will be dereferenced"

So we should always check the return of snd_hdac_ext_bus_get_link() before
referencing the link pointer

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 181cd3bf0b92..2abb742fc47b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1474,6 +1474,11 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 	 * exit, we call pm_runtime_suspend() so that will do for us
 	 */
 	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdac.dev));
+	if (!hlink) {
+		dev_err(&edev->hdac.dev, "hdac link not found\n");
+		return -EIO;
+	}
+
 	snd_hdac_ext_bus_link_get(edev->ebus, hlink);
 
 	ret = create_fill_widget_route_map(dapm);
@@ -1634,6 +1639,11 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdac.dev));
+	if (!hlink) {
+		dev_err(&edev->hdac.dev, "hdac link not found\n");
+		return -EIO;
+	}
+
 	snd_hdac_ext_bus_link_get(edev->ebus, hlink);
 
 	hdmi_priv = devm_kzalloc(&codec->dev, sizeof(*hdmi_priv), GFP_KERNEL);
@@ -1744,6 +1754,11 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	}
 
 	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
+	if (!hlink) {
+		dev_err(dev, "hdac link not found\n");
+		return -EIO;
+	}
+
 	snd_hdac_ext_bus_link_put(ebus, hlink);
 
 	return 0;
@@ -1765,6 +1780,11 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 		return 0;
 
 	hlink = snd_hdac_ext_bus_get_link(ebus, dev_name(dev));
+	if (!hlink) {
+		dev_err(dev, "hdac link not found\n");
+		return -EIO;
+	}
+
 	snd_hdac_ext_bus_link_get(ebus, hlink);
 
 	err = snd_hdac_display_power(bus, true);
-- 
2.8.1
