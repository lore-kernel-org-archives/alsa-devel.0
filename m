From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 5/7] ASoC: Intel: bytcr_rt5651: Add quirks
	module parameter
Date: Sun, 30 Dec 2018 00:00:23 +0100
Message-ID: <20181229230025.21949-6-hdegoede@redhat.com>
References: <20181229230025.21949-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F3ED267B42
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2018 00:00:40 +0100 (CET)
In-Reply-To: <20181229230025.21949-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add quirks module parameter to allow manually specifying quirks
from the kernel commandline (or modprobe.conf).

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 0ed844f2ad01..6d8ef9dd106e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -98,6 +98,10 @@ struct byt_rt5651_private {
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_MAP;
 
+static unsigned int quirk_override;
+module_param_named(quirk, quirk_override, uint, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
+
 static void log_quirks(struct device *dev)
 {
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_DMIC_MAP)
@@ -973,6 +977,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5651_quirk_table);
 
+	if (quirk_override) {
+		dev_info(&pdev->dev, "Overriding quirk 0x%x => 0x%x\n",
+			 (unsigned int)byt_rt5651_quirk, quirk_override);
+		byt_rt5651_quirk = quirk_override;
+	}
+
 	/* Must be called before register_card, also see declaration comment. */
 	ret_val = byt_rt5651_add_codec_device_props(codec_dev);
 	if (ret_val) {
-- 
2.20.1
