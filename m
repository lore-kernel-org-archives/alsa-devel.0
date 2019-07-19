From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/6] ALSA: hda: intel-nhlt: remove useless OR
	operation
Date: Fri, 19 Jul 2019 12:06:07 -0500
Message-ID: <20190719170610.17610-4-pierre-louis.bossart@linux.intel.com>
References: <20190719170610.17610-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55301F80363
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

Each assignment is final so there's no point in doing an OR.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/intel-nhlt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index b9d00c1b25d5..7ba871e470f2 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -73,13 +73,13 @@ int intel_nhlt_get_dmic_geo(struct device *dev, struct nhlt_acpi_table *nhlt)
 			switch (cfg->array_type) {
 			case NHLT_MIC_ARRAY_2CH_SMALL:
 			case NHLT_MIC_ARRAY_2CH_BIG:
-				dmic_geo |= MIC_ARRAY_2CH;
+				dmic_geo = MIC_ARRAY_2CH;
 				break;
 
 			case NHLT_MIC_ARRAY_4CH_1ST_GEOM:
 			case NHLT_MIC_ARRAY_4CH_L_SHAPED:
 			case NHLT_MIC_ARRAY_4CH_2ND_GEOM:
-				dmic_geo |= MIC_ARRAY_4CH;
+				dmic_geo = MIC_ARRAY_4CH;
 				break;
 
 			default:
-- 
2.20.1
