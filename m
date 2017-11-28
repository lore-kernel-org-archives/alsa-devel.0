From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 2/4] ASoC: hdac_hdmi: Refresh sysfs during hdmi
	device probe
Date: Tue, 28 Nov 2017 16:40:19 +0530
Message-ID: <20171128111021.11830-3-guneshwor.o.singh@intel.com>
References: <20171128111021.11830-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 80B09267748
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 12:10:50 +0100 (CET)
In-Reply-To: <20171128111021.11830-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Patches Audio <patches.audio@intel.com>, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Puneeth Prabhu <puneethx.prabhu@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Puneeth Prabhu <puneethx.prabhu@intel.com>

All nodes of hdmi codec widgets are not visible in sysfs interface
(/sys/bus/hdaudio/devices/ehdaudio0D2/widgets) as the vendor
widget is not programmed to enable all the converters and pins.
So, refresh the sysfs widget interface after enabling all pins
and converters during probe.

Signed-off-by: Puneeth Prabhu <puneethx.prabhu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f3b4f4dfae6a..7e689cbc75ae 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2046,6 +2046,7 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 			"Failed in parse and map nid with err: %d\n", ret);
 		return ret;
 	}
+	snd_hdac_refresh_widget_sysfs(codec);
 
 	/* ASoC specific initialization */
 	ret = snd_soc_register_codec(&codec->dev, &hdmi_hda_codec,
-- 
2.15.0
