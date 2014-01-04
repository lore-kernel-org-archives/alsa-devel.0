From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ALSA: compress: remove the sample rate
	check
Date: Sat,  4 Jan 2014 16:59:11 +0530
Message-ID: <1388834953-3200-2-git-send-email-vinod.koul@intel.com>
References: <1388834953-3200-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EE23D261A86
 for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2014 13:29:38 +0100 (CET)
In-Reply-To: <1388834953-3200-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

commit f0e9c080 - "ALSA: compress: change the way sample rates are sent to
kernel" changed the way sample rates are sent. So now we don't need to check for
PCM_RATE_xxx in kernel

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/core/compress_offload.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 9d518ac..7a20897 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -501,9 +501,6 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 	if (params->codec.ch_in == 0 || params->codec.ch_out == 0)
 		return -EINVAL;
 
-	if (!(params->codec.sample_rate & SNDRV_PCM_RATE_8000_192000))
-		return -EINVAL;
-
 	return 0;
 }
 
-- 
1.7.0.4
