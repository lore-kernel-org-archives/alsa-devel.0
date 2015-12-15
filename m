From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] ASoC: Intel: Skylake: Fix a couple
	signedness bugs
Date: Tue, 15 Dec 2015 12:20:14 +0300
Message-ID: <20151215092014.GG5177@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 23F0D261A28
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 10:20:25 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Dharageswari R <dharageswari.r@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

These need to be signed because they hold negative error codes.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Fix a typo in the change log.  s/unsigned/signed/

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 8cd5cdb..e26f474 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -208,7 +208,7 @@ static unsigned int skl_get_errorcode(struct sst_dsp *ctx)
  * since get/set_module are called from DAPM context,
  * we don't need lock for usage count
  */
-static unsigned int skl_get_module(struct sst_dsp *ctx, u16 mod_id)
+static int skl_get_module(struct sst_dsp *ctx, u16 mod_id)
 {
 	struct skl_module_table *module;
 
@@ -220,7 +220,7 @@ static unsigned int skl_get_module(struct sst_dsp *ctx, u16 mod_id)
 	return -EINVAL;
 }
 
-static unsigned int skl_put_module(struct sst_dsp *ctx, u16 mod_id)
+static int skl_put_module(struct sst_dsp *ctx, u16 mod_id)
 {
 	struct skl_module_table *module;
 
@@ -340,7 +340,7 @@ static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, char *guid)
 
 static int skl_unload_module(struct sst_dsp *ctx, u16 mod_id)
 {
-	unsigned int usage_cnt;
+	int usage_cnt;
 	struct skl_sst *skl = ctx->thread_context;
 	int ret = 0;
 
