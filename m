From: jeeja.kp@intel.com
Subject: [PATCH 11/12] ASoC: Intel: Skylake: set the resume
	point to LPIB
Date: Fri,  2 Dec 2016 23:11:48 +0530
Message-ID: <1480700509-23380-12-git-send-email-jeeja.kp@intel.com>
References: <1480700509-23380-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 775FC267814
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2016 18:32:23 +0100 (CET)
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

In system suspend, the firmware pipelines will be deleted and there
is no need to save the pipeline context. Driver will save the DPIB and
LPIB pointers in suspend.

In system resume, the firmware pipelines will be created again and the
RD/RW pointers in the Firmware buffer points to the base address. So
need to fetch the non-played data again to firmware buffer. LPIB
indicates the HW rendered position.

Instead of setting DPIB as resume point, set it to LPIB to restore from
the HW render position so that DMA would fetch the non-played data one
more time.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 800fdad..508144b 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -484,7 +484,7 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			snd_hdac_ext_stream_drsm_enable(ebus, true,
 						hdac_stream(stream)->index);
 			snd_hdac_ext_stream_set_dpibr(ebus, stream,
-							stream->dpib);
+							stream->lpib);
 			snd_hdac_ext_stream_set_lpib(stream, stream->lpib);
 		}
 
-- 
2.5.0
