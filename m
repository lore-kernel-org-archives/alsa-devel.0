From: han.lu@intel.com
Subject: [PATCH-v2 1/1] HDA: Intel: enable automatic runtime pm
	for HDMI codecs by default
Date: Tue,  9 Jun 2015 16:50:38 +0800
Message-ID: <1433839838-16893-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D7CE52606CD
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 10:52:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, daniel.vetter@intel.com
Cc: "Lu, Han" <han.lu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Enable runtime PM of the HDMI audio codec on the latest Intel platforms.
So the HD-A controller or HDMI codec can suspend when idle timeout by
default and release the GFX power well.
The patch influences HSW/BDW/BYT/BSW/SKL. Eariler platforms and third
party analog codecs will not be influenced.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 54380ed..e9f274b6 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3495,6 +3495,9 @@ static void codec_set_power_save(struct hda_codec *codec, int delay)
 {
 	struct device *dev = hda_codec_dev(codec);
 
+	if (delay == 0 && codec->auto_runtime_pm)
+		delay = 3000;
+
 	if (delay > 0) {
 		pm_runtime_set_autosuspend_delay(dev, delay);
 		pm_runtime_use_autosuspend(dev);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 6c57258..12837ab 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -251,6 +251,7 @@ struct hda_codec {
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
 	unsigned int power_save_node:1; /* advanced PM for each widget */
+	unsigned int auto_runtime_pm:1; /* enable automatic codec runtime pm */
 #ifdef CONFIG_PM
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 407978b..f852734 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2356,6 +2356,10 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		codec->dp_mst = true;
 	}
 
+	/* Enable runtime pm for HDMI audio codec of HSW/BDW/SKL/BYT/BSW */
+	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
+		codec->auto_runtime_pm = 1;
+
 	generic_hdmi_init_per_pins(codec);
 
 	init_channel_allocations();
-- 
1.9.1
