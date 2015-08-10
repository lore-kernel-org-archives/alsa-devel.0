From: mengdong.lin@intel.com
Subject: [PATCH v2 08/10] ASoC: topology: Change pass number of
	DAI smaller than graph
Date: Mon, 10 Aug 2015 22:48:30 +0800
Message-ID: <0d5bb0a4d334109420b24d0ef805feff9bcf6c7f.1439217448.git.mengdong.lin@intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A90265A43
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 16:35:13 +0200 (CEST)
In-Reply-To: <cover.1439217448.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

The PCM DAIs need to be loaded and added to ASoC core ealier than the
graph (route). Otherwise, adding routes will fail for missing DAIs.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 1b6728b..0f8fa0d 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -45,12 +45,12 @@
 #define SOC_TPLG_PASS_VENDOR		1
 #define SOC_TPLG_PASS_MIXER		2
 #define SOC_TPLG_PASS_WIDGET		3
-#define SOC_TPLG_PASS_GRAPH		4
-#define SOC_TPLG_PASS_PINS		5
-#define SOC_TPLG_PASS_PCM_DAI		6
+#define SOC_TPLG_PASS_PCM_DAI		4
+#define SOC_TPLG_PASS_GRAPH		5
+#define SOC_TPLG_PASS_PINS		6
 
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
-#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_PCM_DAI
+#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_PINS
 
 struct soc_tplg {
 	const struct firmware *fw;
-- 
1.9.1
