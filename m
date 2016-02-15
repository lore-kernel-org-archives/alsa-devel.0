From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Enable DP1.2 and all
	converters/pins" to the asoc tree
Date: Mon, 15 Feb 2016 20:58:54 +0000
Message-ID: <E1aVQEQ-0007vI-I0@finisterre>
References: <1449176942-3441-7-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7610265522
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:59:01 +0100 (CET)
In-Reply-To: <1449176942-3441-7-git-send-email-subhransu.s.prusty@intel.com>
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

   ASoC: hdac_hdmi: Enable DP1.2 and all converters/pins

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

>From 211caab73b20dcc91ac103db0f68fe2388120d59 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 12 Feb 2016 07:46:03 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Enable DP1.2 and all converters/pins

Skylake supports 3 pin and 3 converter widgets. But by default
only one converter and pin widget are enabled. In skylake
platform the DP port is on a different port which is not enabled
by default. To enable playback on DP port, enable all pin and
converter widget by sending a vendor VERB for a vendor widget to
set required bits.

As we are enabling the DP support enable the DP1.2 feature as well.

Enabling DP1.2 and all widget changes are copied from patch_hdmi.c.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index d22fa6b..b2e5e54 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -629,6 +629,46 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 	return 0;
 }
 
+#define INTEL_VENDOR_NID 0x08
+#define INTEL_GET_VENDOR_VERB 0xf81
+#define INTEL_SET_VENDOR_VERB 0x781
+#define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
+#define INTEL_EN_ALL_PIN_CVTS	0x01 /* enable 2nd & 3rd pins and convertors */
+
+static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdac)
+{
+	unsigned int vendor_param;
+
+	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+				INTEL_GET_VENDOR_VERB, 0);
+	if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
+		return;
+
+	vendor_param |= INTEL_EN_ALL_PIN_CVTS;
+	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+				INTEL_SET_VENDOR_VERB, vendor_param);
+	if (vendor_param == -1)
+		return;
+}
+
+static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdac)
+{
+	unsigned int vendor_param;
+
+	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+				INTEL_GET_VENDOR_VERB, 0);
+	if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
+		return;
+
+	/* enable DP1.2 mode */
+	vendor_param |= INTEL_EN_DP12;
+	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+				INTEL_SET_VENDOR_VERB, vendor_param);
+	if (vendor_param == -1)
+		return;
+
+}
+
 /*
  * Parse all nodes and store the cvt/pin nids in array
  * Add one time initialization for pin and cvt widgets
@@ -641,6 +681,9 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	int ret;
 
+	hdac_hdmi_skl_enable_all_pins(hdac);
+	hdac_hdmi_skl_enable_dp12(hdac);
+
 	num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
 	if (!nid || num_nodes <= 0) {
 		dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
-- 
2.7.0
