From: mengdong.lin@linux.intel.com
Subject: [PATCH] ASoC: snd_soc_set_dmi_name will use
	DMI_SYS_VENDOR if available
Date: Sat, 29 Apr 2017 00:19:47 +0800
Message-ID: <1493396387-15884-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B3EA8266A53
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 18:14:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This fix is based on Daniel Drake's suggestion: most x86 machines have a
meaningfull DMI_SYS_VENDOR rather than DMI_BOARD_VENDOR.

So snd_soc_set_dmi_name will try to get vendor name from DMI_SYS_VENDOR
at first, and if that's null, then use DMI_BOARD_VENDOR.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 525f2f3..45f0a34 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1974,7 +1974,9 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 		return 0; /* long name already set by driver or from DMI */
 
 	/* make up dmi long name as: vendor.product.version.board */
-	vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	if (!vendor)
+		vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
 	if (!vendor) {
 		dev_warn(card->dev, "ASoC: no DMI vendor name!\n");
 		return 0;
-- 
2.5.0
