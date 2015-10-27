From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 05/17] ASoC: Intel: Skylake: Fix to ignore blob
	check if link type is HDA
Date: Tue, 27 Oct 2015 09:22:48 +0900
Message-ID: <1445905380-18167-6-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C0A122650C3
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:23:27 +0100 (CET)
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

If link type is HDA, NHLT blob is null, as NHLT defines non HDA
links only.  So we should ignore blob query for HDA links.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 313a02d8db01..e11a9e44d064 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -921,6 +921,9 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 
 	memcpy(pipe->p_params, params, sizeof(*params));
 
+	if (link_type == NHLT_LINK_HDA)
+		return 0;
+
 	/* update the blob based on virtual bus_id*/
 	cfg = skl_get_ep_blob(skl, mconfig->vbus_id, link_type,
 					params->s_fmt, params->ch,
-- 
2.4.3
