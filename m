From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 5/7] ASoC: Intel: remove GFP_ATOMIC,
	use GFP_KERNEL
Date: Wed, 31 Oct 2018 20:07:16 -0500
Message-ID: <20181101010718.2878-6-pierre-louis.bossart@linux.intel.com>
References: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 06B57267877
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 02:07:27 +0100 (CET)
In-Reply-To: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

GFP_ATOMIC is not required on any Intel drivers, use GFP_KERNEL
instead. A first cleanup was merged in April but missed a number
occurrences and new ones were added by copy/paste inertia.

While we are at it, make checkpatch happy with a sizeof(*msg)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_pvt.c            | 4 ++--
 sound/soc/intel/boards/cht_bsw_rt5672.c       | 2 +-
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 2 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c  | 2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c  | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index af93244b4868..00a37a09dc9b 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -166,11 +166,11 @@ int sst_create_ipc_msg(struct ipc_post **arg, bool large)
 {
 	struct ipc_post *msg;
 
-	msg = kzalloc(sizeof(struct ipc_post), GFP_ATOMIC);
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 	if (large) {
-		msg->mailbox_data = kzalloc(SST_MAILBOX_SIZE, GFP_ATOMIC);
+		msg->mailbox_data = kzalloc(SST_MAILBOX_SIZE, GFP_KERNEL);
 		if (!msg->mailbox_data) {
 			kfree(msg);
 			return -ENOMEM;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 51f0d45d6f8f..9de64f447e7b 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -403,7 +403,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	const char *i2c_name;
 	int i;
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index c4b94e2617c5..c74c4f17316f 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -603,7 +603,7 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 {
 	struct glk_card_private *ctx;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 3bc78e3a91ee..58eb0fe69978 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -935,7 +935,7 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_codec_private *ctx;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index b6f287fa9505..15c502d6774d 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -140,7 +140,7 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "%s: entry\n", __func__);
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-- 
2.17.1
