From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: Intel: Skylake: make skl_dsp_fw_ops const
Date: Fri, 11 Aug 2017 21:57:15 +0530
Message-ID: <1502468835-32333-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8046A26768D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 18:27:27 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id u185so3494764pgb.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 09:27:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 2 +-
 sound/soc/intel/skylake/cnl-sst.c | 2 +-
 sound/soc/intel/skylake/skl-sst.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 71042ac..5e1ac99 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -530,7 +530,7 @@ static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 	return 0;
 }
 
-static struct skl_dsp_fw_ops bxt_fw_ops = {
+static const struct skl_dsp_fw_ops bxt_fw_ops = {
 	.set_state_D0 = bxt_set_dsp_D0,
 	.set_state_D3 = bxt_set_dsp_D3,
 	.set_state_D0i3 = bxt_schedule_dsp_D0i3,
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 7dcfe66..48ef04d 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -277,7 +277,7 @@ static unsigned int cnl_get_errno(struct sst_dsp *ctx)
 	return sst_dsp_shim_read(ctx, CNL_ADSP_ERROR_CODE);
 }
 
-static struct skl_dsp_fw_ops cnl_fw_ops = {
+static const struct skl_dsp_fw_ops cnl_fw_ops = {
 	.set_state_D0 = cnl_set_dsp_D0,
 	.set_state_D3 = cnl_set_dsp_D3,
 	.load_fw = cnl_load_base_firmware,
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 6cc586d..a7ad734 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -503,7 +503,7 @@ static void skl_clear_module_table(struct sst_dsp *ctx)
 	}
 }
 
-static struct skl_dsp_fw_ops skl_fw_ops = {
+static const struct skl_dsp_fw_ops skl_fw_ops = {
 	.set_state_D0 = skl_set_dsp_D0,
 	.set_state_D3 = skl_set_dsp_D3,
 	.load_fw = skl_load_base_firmware,
@@ -512,7 +512,7 @@ static void skl_clear_module_table(struct sst_dsp *ctx)
 	.unload_mod = skl_unload_module,
 };
 
-static struct skl_dsp_fw_ops kbl_fw_ops = {
+static const struct skl_dsp_fw_ops kbl_fw_ops = {
 	.set_state_D0 = skl_set_dsp_D0,
 	.set_state_D3 = skl_set_dsp_D3,
 	.load_fw = skl_load_base_firmware,
-- 
1.9.1
