From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 14/14] ASoC: Intel: Skylake: Add Resume
	capability in PCM info.
Date: Fri, 11 Dec 2015 12:14:27 +0530
Message-ID: <1449816267-11910-15-git-send-email-vinod.koul@intel.com>
References: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F0A1266528
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 07:42:03 +0100 (CET)
In-Reply-To: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
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

Now that we can restore back the DMA registers and also the link
add this capability in driver for PCM resume

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index f582b06a119d..b8b4b4600e07 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -38,6 +38,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_PAUSE |
+				 SNDRV_PCM_INFO_RESUME |
 				 SNDRV_PCM_INFO_SYNC_START |
 				 SNDRV_PCM_INFO_HAS_WALL_CLOCK | /* legacy */
 				 SNDRV_PCM_INFO_HAS_LINK_ATIME |
-- 
1.9.1
