From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Handle MST pin jack
	detection at boot/resume" to the asoc tree
Date: Thu, 16 Feb 2017 19:04:45 +0000
Message-ID: <E1ceRMD-0007f8-63@debutante>
References: <1484589477-7630-16-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D0490267058
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:04:53 +0100 (CET)
In-Reply-To: <1484589477-7630-16-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Handle MST pin jack detection at boot/resume

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

>From a9ce96bcd9c4d0c1ffd3d37c000bcee470b2535b Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 7 Feb 2017 19:09:46 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Handle MST pin jack detection at boot/resume

The ELD notification can be received asynchronously from the graphics
side and this may happen just at the moment the sound driver is
initializing and notification will be missed. Similarly at system
resume, the notification is ignored as the  ELD and connection states
are updated in anyway at the end of the resume.
So check the jack status in boot/resume by querying the port presence
based on pin caps and report the jack status.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 84b7d6cd7c37..c5527e81a490 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1551,15 +1551,38 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 }
 EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
 
+static void hdac_hdmi_present_sense_all_pins(struct hdac_ext_device *edev,
+			struct hdac_hdmi_priv *hdmi, bool detect_pin_caps)
+{
+	int i;
+	struct hdac_hdmi_pin *pin;
+
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		if (detect_pin_caps) {
+
+			if (hdac_hdmi_get_port_len(edev, pin->nid)  == 0)
+				pin->mst_capable = false;
+			else
+				pin->mst_capable = true;
+		}
+
+		for (i = 0; i < pin->num_ports; i++) {
+			if (!pin->mst_capable && i > 0)
+				continue;
+
+			hdac_hdmi_present_sense(pin, &pin->ports[i]);
+		}
+	}
+}
+
 static int hdmi_codec_probe(struct snd_soc_codec *codec)
 {
 	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(&codec->component);
-	struct hdac_hdmi_pin *pin;
 	struct hdac_ext_link *hlink = NULL;
-	int ret, i;
+	int ret;
 
 	edev->scodec = codec;
 
@@ -1587,10 +1610,7 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	list_for_each_entry(pin, &hdmi->pin_list, head)
-		for (i = 0; i < pin->num_ports; i++)
-			hdac_hdmi_present_sense(pin, &pin->ports[i]);
-
+	hdac_hdmi_present_sense_all_pins(edev, hdmi, true);
 	/* Imp: Store the card pointer in hda_codec */
 	edev->card = dapm->card->snd_card;
 
@@ -1638,9 +1658,7 @@ static void hdmi_codec_complete(struct device *dev)
 {
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_pin *pin;
 	struct hdac_device *hdac = &edev->hdac;
-	int i;
 
 	/* Power up afg */
 	snd_hdac_codec_read(hdac, hdac->afg, 0,	AC_VERB_SET_POWER_STATE,
@@ -1652,11 +1670,10 @@ static void hdmi_codec_complete(struct device *dev)
 	/*
 	 * As the ELD notify callback request is not entertained while the
 	 * device is in suspend state. Need to manually check detection of
-	 * all pins here.
+	 * all pins here. pin capablity change is not support, so use the
+	 * already set pin caps.
 	 */
-	list_for_each_entry(pin, &hdmi->pin_list, head)
-		for (i = 0; i < pin->num_ports; i++)
-			hdac_hdmi_present_sense(pin, &pin->ports[i]);
+	hdac_hdmi_present_sense_all_pins(edev, hdmi, false);
 
 	pm_runtime_put_sync(&edev->hdac.dev);
 }
-- 
2.11.0
