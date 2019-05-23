From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 6/6] [HACK] ASoC: Intel: NHLT: handle
	VENDOR_DEFINED DMIC geometry
Date: Thu, 23 May 2019 18:39:51 -0500
Message-ID: <20190523233951.31122-7-pierre-louis.bossart@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAF63F89718
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 01:40:39 +0200 (CEST)
In-Reply-To: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
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

The NHLT spec defines a VENDOR_DEFINED geometry without defining how
many microphones are supported. Fall back to 2ch until we have better
information or experimental evidence on what to do.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/intel-nhlt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/intel-nhlt.c b/sound/soc/intel/common/intel-nhlt.c
index d93ecc32d996..86f8a7f3f059 100644
--- a/sound/soc/intel/common/intel-nhlt.c
+++ b/sound/soc/intel/common/intel-nhlt.c
@@ -81,7 +81,10 @@ int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
 			case NHLT_MIC_ARRAY_4CH_2ND_GEOM:
 				dmic_geo |= MIC_ARRAY_4CH;
 				break;
-
+			case NHLT_MIC_ARRAY_VENDOR_DEFINED:
+				dev_dbg(dev, "VENDOR_DEFINED DMIC array_type, using 2CH_SMALL\n");
+				dmic_geo |= NHLT_MIC_ARRAY_2CH_SMALL;
+				break;
 			default:
 				dev_warn(dev, "undefined DMIC array_type 0x%0x\n",
 					 cfg->array_type);
-- 
2.20.1
