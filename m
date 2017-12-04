From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Skylake: Fix descriptions for
	exported function args
Date: Mon,  4 Dec 2017 10:30:12 +0530
Message-ID: <20171204050012.21498-2-guneshwor.o.singh@intel.com>
References: <20171204050012.21498-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E851267544
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 06:00:12 +0100 (CET)
In-Reply-To: <20171204050012.21498-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Fix a few incorrect descriptions for arguments in exported functions.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 8ff89280d9fd..2ae405617876 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -178,7 +178,8 @@ static inline int skl_pvtid_128(struct uuid_module *module)
  * skl_get_pvt_id: generate a private id for use as module id
  *
  * @ctx: driver context
- * @mconfig: module configuration data
+ * @uuid_mod: module's uuid
+ * @instance_id: module's instance id
  *
  * This generates a 128 bit private unique id for a module TYPE so that
  * module instance is unique
@@ -208,7 +209,8 @@ EXPORT_SYMBOL_GPL(skl_get_pvt_id);
  * skl_put_pvt_id: free up the private id allocated
  *
  * @ctx: driver context
- * @mconfig: module configuration data
+ * @uuid_mod: module's uuid
+ * @pvt_id: module pvt id
  *
  * This frees a 128 bit private unique id previously generated
  */
-- 
2.15.1
