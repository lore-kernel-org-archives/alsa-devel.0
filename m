From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Skylake: Check for module
	list being NULL
Date: Tue, 14 Jun 2016 21:33:45 +0530
Message-ID: <1465920225-11131-2-git-send-email-vinod.koul@intel.com>
References: <1465920225-11131-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F41E2616C9
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 17:57:12 +0200 (CEST)
In-Reply-To: <1465920225-11131-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

While clearing loaded module count, we should check first to see
if module list is NULL or not. Some distributions can ship with
no modules and thus list can be empty.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index dff1076a5f9e..eaf0c9d19782 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -384,6 +384,9 @@ void skl_clear_module_cnt(struct sst_dsp *ctx)
 {
 	struct skl_module_table *module;
 
+	if (list_empty(&ctx->module_list))
+		return;
+
 	list_for_each_entry(module, &ctx->module_list, list) {
 		module->usage_cnt = 0;
 	}
-- 
1.9.1
