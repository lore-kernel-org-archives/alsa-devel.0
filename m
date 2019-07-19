From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/6] ALSA: hda: intel-nhlt: handle NHLT
	VENDOR_DEFINED DMIC geometry
Date: Fri, 19 Jul 2019 12:06:08 -0500
Message-ID: <20190719170610.17610-5-pierre-louis.bossart@linux.intel.com>
References: <20190719170610.17610-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FCA8F80228
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 19:06:22 +0200 (CEST)
In-Reply-To: <20190719170610.17610-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The NHLT spec defines a VENDOR_DEFINED geometry, which requires
reading additional information to figure out the number of
microphones.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/intel-nhlt.h | 10 ++++++++--
 sound/hda/intel-nhlt.c     |  6 +++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/sound/intel-nhlt.h b/include/sound/intel-nhlt.h
index 857922f03931..f657fd8fc0ad 100644
--- a/include/sound/intel-nhlt.h
+++ b/include/sound/intel-nhlt.h
@@ -96,16 +96,22 @@ struct nhlt_resource_desc  {
 #define MIC_ARRAY_2CH 2
 #define MIC_ARRAY_4CH 4
 
-struct nhlt_tdm_config {
+struct nhlt_device_specific_config {
 	u8 virtual_slot;
 	u8 config_type;
 } __packed;
 
 struct nhlt_dmic_array_config {
-	struct nhlt_tdm_config tdm_config;
+	struct nhlt_device_specific_config device_config;
 	u8 array_type;
 } __packed;
 
+struct nhlt_vendor_dmic_array_config {
+	struct nhlt_dmic_array_config dmic_config;
+	u8 nb_mics;
+	/* TODO add vendor mic config */
+} __packed;
+
 enum {
 	NHLT_MIC_ARRAY_2CH_SMALL = 0xa,
 	NHLT_MIC_ARRAY_2CH_BIG = 0xb,
diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index 7ba871e470f2..441ee39520a8 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -58,6 +58,7 @@ int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
 {
 	struct nhlt_endpoint *epnt;
 	struct nhlt_dmic_array_config *cfg;
+	struct nhlt_vendor_dmic_array_config *cfg_vendor;
 	unsigned int dmic_geo = 0;
 	u8 j;
 
@@ -81,7 +82,10 @@ int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
 			case NHLT_MIC_ARRAY_4CH_2ND_GEOM:
 				dmic_geo = MIC_ARRAY_4CH;
 				break;
-
+			case NHLT_MIC_ARRAY_VENDOR_DEFINED:
+				cfg_vendor = (struct nhlt_vendor_dmic_array_config *)cfg;
+				dmic_geo = cfg_vendor->nb_mics;
+				break;
 			default:
 				dev_warn(dev, "undefined DMIC array_type 0x%0x\n",
 					 cfg->array_type);
-- 
2.20.1
