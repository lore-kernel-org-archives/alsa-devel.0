From: Patrick Waterlander <patrick.waterlander@intel.com>
Subject: [PATCH 1/1] ASoC: Intel: Skylake: change list empty
	check to warning
Date: Thu, 25 Apr 2019 14:57:43 -0700
Message-ID: <20190425215743.88673-1-patrick.waterlander@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Patrick Waterlander <patrick.waterlander@intel.com>
List-Id: alsa-devel@alsa-project.org

NULL is a valid state for the module list when querying unique ID.
Downgrade the empty condition from error to warning.

Signed-off-by: Patrick Waterlander <patrick.waterlander@intel.com>

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 5951bbdf1f1a..95e6a23538cd 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -324,7 +324,7 @@ static struct skl_module_table *skl_module_get_from_id(
 	struct skl_module_table *module;
 
 	if (list_empty(&ctx->module_list)) {
-		dev_err(ctx->dev, "Module list is empty\n");
+		dev_warn(ctx->dev, "Module list is empty\n");
 		return NULL;
 	}
 
-- 
2.17.1
