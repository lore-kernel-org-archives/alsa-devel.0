From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH] ASoC: compress - fix code alignment
Date: Tue, 21 Aug 2012 12:15:02 +0530
Message-ID: <1345531502-20050-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 34F5A260311
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 08:43:03 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, wfg@linux.intel.com, Namarta Kohli <namartax.kohli@intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Reported-by: Fengguang Wu <wfg@linux.intel.com>
Signed-off-by: Namarta Kohli <namartax.kohli@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/soc/soc-compress.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 88d85ba..cc0562d 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -104,7 +104,7 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 
 	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
 		platform->driver->compr_ops->free(cstream);
-		cpu_dai->runtime = NULL;
+	cpu_dai->runtime = NULL;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
 		if (!rtd->pmdown_time || codec->ignore_pmdown_time ||
-- 
1.7.0.4
