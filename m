From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/9] ASoC: Intel: Skylake: Remove BE copier
	blob memcpy
Date: Thu, 22 Oct 2015 23:22:35 +0530
Message-ID: <1445536362-26670-3-git-send-email-vinod.koul@intel.com>
References: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BD915260568
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 19:49:32 +0200 (CEST)
In-Reply-To: <1445536362-26670-1-git-send-email-vinod.koul@intel.com>
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

The BE copier private data allowed endpoint configuration blobs, now these
are queried from BIOS, we don't need to copy the blob, but only capability.

Removing the blob from private data will not allocate memory for module
specific config in which case memcpy will fail. Fix is to assign the ptr
queried from the NHLT table for the endpoint configuration.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a5d8420ce69a..7c920857007e 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -926,7 +926,7 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 					params->s_freq, params->stream);
 	if (cfg) {
 		mconfig->formats_config.caps_size = cfg->size;
-		memcpy(mconfig->formats_config.caps, &cfg->caps, cfg->size);
+		mconfig->formats_config.caps = (u32 *) &cfg->caps;
 	} else {
 		dev_err(dai->dev, "Blob NULL for id %x type %d dirn %d\n",
 					mconfig->vbus_id, link_type,
-- 
1.9.1
