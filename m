From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Use i915 component framework
	for PM" to the asoc tree
Date: Sat, 21 Nov 2015 14:00:28 +0000
Message-ID: <E1a08iK-00019P-G3@finisterre>
References: <1445821673-4947-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EFBC22604D8
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 15:01:15 +0100 (CET)
In-Reply-To: <1445821673-4947-7-git-send-email-vinod.koul@intel.com>
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

   ASoC: hdac_hdmi: Use i915 component framework for PM

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

>From 07f083aba92ffdd97df41516de6f80ef27a4a21b Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 10 Nov 2015 18:42:10 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Use i915 component framework for PM

Use the component framework to keep the display on till the
playback in progress.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c02e6d3..d155262 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -25,6 +25,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/hdaudio_ext.h>
+#include <sound/hda_i915.h>
 #include "../../hda/local.h"
 
 #define AMP_OUT_MUTE		0xb080
@@ -559,14 +560,26 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 {
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
+	struct hdac_bus *bus = hdac->bus;
+	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
 
+	/* controller may not have been initialized for the first time */
+	if (!bus)
+		return 0;
+
 	/* Power down afg */
 	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D3))
 		snd_hdac_codec_write(hdac, hdac->afg, 0,
 			AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 
+	err = snd_hdac_display_power(bus, false);
+	if (err < 0) {
+		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+		return err;
+	}
+
 	return 0;
 }
 
@@ -574,9 +587,21 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 {
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
+	struct hdac_bus *bus = hdac->bus;
+	int err;
 
 	dev_dbg(dev, "Enter: %s\n", __func__);
 
+	/* controller may not have been initialized for the first time */
+	if (!bus)
+		return 0;
+
+	err = snd_hdac_display_power(bus, true);
+	if (err < 0) {
+		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+		return err;
+	}
+
 	/* Power up afg */
 	if (!snd_hdac_check_power_state(hdac, hdac->afg, AC_PWRST_D0))
 		snd_hdac_codec_write(hdac, hdac->afg, 0,
-- 
2.6.1
