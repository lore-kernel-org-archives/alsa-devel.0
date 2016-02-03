From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 01/11] ASoC: Intel: Skylake: Fix the memory
	overwrite of tlv buffer
Date: Wed,  3 Feb 2016 17:59:44 +0530
Message-ID: <1454502594-21700-2-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C116D26066D
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:28 +0100 (CET)
In-Reply-To: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
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

TLV buffer can be smaller than the module data, so update the
size of data to be copied before doing the copy.

Also TLV header consists of two unsigned ints, this is also taken
into account here and size modified to reflect this

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 4624556f486d..d1ddfdac22fe 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -916,6 +916,13 @@ static int skl_tplg_tlv_control_get(struct snd_kcontrol *kcontrol,
 		skl_get_module_params(skl->skl_sst, (u32 *)bc->params,
 				      bc->max, bc->param_id, mconfig);
 
+	/* decrement size for TLV header */
+	size -= 2 * sizeof(u32);
+
+	/* check size as we don't want to send kernel data */
+	if (size > bc->max)
+		size = bc->max;
+
 	if (bc->params) {
 		if (copy_to_user(data, &bc->param_id, sizeof(u32)))
 			return -EFAULT;
-- 
1.9.1
