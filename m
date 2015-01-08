From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Add stream direction for
	pcm-module map
Date: Thu,  8 Jan 2015 14:32:20 +0800
Message-ID: <1420698741-26016-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C3742652F5
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 07:31:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

A DAI may have 2 streams(playback/capture) and different modules
may be needed for them respectively, so we need add a stream
direction here, the combination(dai_id + stream) can tell us
which module we really need here.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 04393e3..f4cdf48 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -83,7 +83,6 @@ static const u32 volume_map[] = {
 #define HSW_PCM_DAI_ID_OFFLOAD0	1
 #define HSW_PCM_DAI_ID_OFFLOAD1	2
 #define HSW_PCM_DAI_ID_LOOPBACK	3
-#define HSW_PCM_DAI_ID_CAPTURE	4
 
 
 static const struct snd_pcm_hardware hsw_pcm_hardware = {
@@ -104,6 +103,7 @@ static const struct snd_pcm_hardware hsw_pcm_hardware = {
 
 struct hsw_pcm_module_map {
 	int dai_id;
+	int stream;
 	enum sst_hsw_module_id mod_id;
 };
 
@@ -751,11 +751,11 @@ static struct snd_pcm_ops hsw_pcm_ops = {
 
 /* static mappings between PCMs and modules - may be dynamic in future */
 static struct hsw_pcm_module_map mod_map[] = {
-	{HSW_PCM_DAI_ID_SYSTEM, SST_HSW_MODULE_PCM_SYSTEM},
-	{HSW_PCM_DAI_ID_OFFLOAD0, SST_HSW_MODULE_PCM},
-	{HSW_PCM_DAI_ID_OFFLOAD1, SST_HSW_MODULE_PCM},
-	{HSW_PCM_DAI_ID_LOOPBACK, SST_HSW_MODULE_PCM_REFERENCE},
-	{HSW_PCM_DAI_ID_CAPTURE, SST_HSW_MODULE_PCM_CAPTURE},
+	{HSW_PCM_DAI_ID_SYSTEM, 0, SST_HSW_MODULE_PCM_SYSTEM},
+	{HSW_PCM_DAI_ID_OFFLOAD0, 0, SST_HSW_MODULE_PCM},
+	{HSW_PCM_DAI_ID_OFFLOAD1, 0, SST_HSW_MODULE_PCM},
+	{HSW_PCM_DAI_ID_LOOPBACK, 1, SST_HSW_MODULE_PCM_REFERENCE},
+	{HSW_PCM_DAI_ID_SYSTEM, 1, SST_HSW_MODULE_PCM_CAPTURE},
 };
 
 static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
@@ -1139,7 +1139,7 @@ static void hsw_pcm_complete(struct device *dev)
 		return;
 	}
 
-	for (i = 0; i < HSW_PCM_DAI_ID_CAPTURE + 1; i++) {
+	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
 		pcm_data = &pdata->pcm[i];
 
 		if (!pcm_data->substream)
@@ -1173,7 +1173,7 @@ static int hsw_pcm_prepare(struct device *dev)
 	if (pdata->pm_state == HSW_PM_STATE_D3)
 		return 0;
 	/* suspend all active streams */
-	for (i = 0; i < HSW_PCM_DAI_ID_CAPTURE + 1; i++) {
+	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
 		pcm_data = &pdata->pcm[i];
 
 		if (!pcm_data->substream)
@@ -1192,7 +1192,7 @@ static int hsw_pcm_prepare(struct device *dev)
 	sst_hsw_dsp_runtime_suspend(hsw);
 
 	/* preserve persistent memory */
-	for (i = 0; i < HSW_PCM_DAI_ID_CAPTURE + 1; i++) {
+	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
 		pcm_data = &pdata->pcm[i];
 
 		if (!pcm_data->substream)
-- 
1.9.1
