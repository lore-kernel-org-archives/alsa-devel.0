From: jeeja.kp@intel.com
Subject: [PATCH 10/12] ASoC: Intel: Skylake: Don't reset
	pass-through pipe in BE prepare
Date: Fri,  2 Dec 2016 23:11:47 +0530
Message-ID: <1480700509-23380-11-git-send-email-jeeja.kp@intel.com>
References: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 965CF26782B
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 18:32:19 +0100 (CET)
In-Reply-To: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

When pipe is pass-through, BE and FE modules are defined inside
a pipe, reset of pipe will be done in FE DAI prepare. So don't
reset in the BE prepare.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 688d6f7..800fdad 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -582,8 +582,8 @@ static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 
 	/* In case of XRUN recovery, reset the FW pipe to clean state */
 	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
-	if (mconfig && (substream->runtime->status->state ==
-					SNDRV_PCM_STATE_XRUN))
+	if (mconfig && !mconfig->pipe->passthru &&
+		(substream->runtime->status->state == SNDRV_PCM_STATE_XRUN))
 		skl_reset_pipe(skl->skl_sst, mconfig->pipe);
 
 	return 0;
-- 
2.5.0
