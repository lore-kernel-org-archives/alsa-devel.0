From: han.lu@intel.com
Subject: [PATCH 1/1] Intel: ASoC: Add condition check before
	set param to waves
Date: Thu, 19 Mar 2015 08:38:00 +0800
Message-ID: <1426725480-31645-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 532B3260504
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 01:40:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Check waves state before set parameter through ipc to prevent unexpected
operation. Also remove redundant check.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 43fb5f3..20b629a 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -2055,6 +2055,11 @@ int sst_hsw_launch_param_buf(struct sst_hsw *hsw)
 {
 	int ret, idx;
 
+	if (!sst_hsw_is_module_active(hsw, SST_HSW_MODULE_WAVES)) {
+		dev_dbg(hsw->dev, "module waves is not active\n");
+		return 0;
+	}
+
 	/* put all param lines to DSP through ipc */
 	for (idx = 0; idx < hsw->param_idx_w; idx++) {
 		ret = sst_hsw_module_set_param(hsw,
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index b40ec74..6c6229a 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -399,13 +399,9 @@ static int hsw_waves_param_put(struct snd_kcontrol *kcontrol,
 	if (ret < 0)
 		return ret;
 
-	if (sst_hsw_is_module_loaded(hsw, id)) {
-		if (!sst_hsw_is_module_active(hsw, id))
-			return 0;
-
+	if (sst_hsw_is_module_active(hsw, id))
 		ret = sst_hsw_module_set_param(hsw, id, 0, param_id,
 				param_size, ucontrol->value.bytes.data);
-	}
 	return ret;
 }
 
-- 
1.9.1
