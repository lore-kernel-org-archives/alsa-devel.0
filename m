From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Fix a buffer overflow issue
Date: Tue,  7 Apr 2015 20:14:59 +0800
Message-ID: <1428408899-28677-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 99EF6260508
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 14:11:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

0day robot reported a buffer overflow issue:

...
sound/soc/intel/haswell/sst-haswell-pcm.c:1107 hsw_pcm_probe() error: buffer\
overflow 'hsw_dais' 4 <= 4
sound/soc/intel/haswell/sst-haswell-pcm.c:1109 hsw_pcm_probe() error: buffer\
overflow 'hsw_dais' 4 <= 4
...

Fix it by initializing the index(i) to correct value.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 157b3a6..23ae040 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -1103,7 +1103,7 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 	return 0;
 
 err:
-	for (;i >= 0; i--) {
+	for (--i; i >= 0; i--) {
 		if (hsw_dais[i].playback.channels_min)
 			snd_dma_free_pages(&priv_data->dmab[i][0]);
 		if (hsw_dais[i].capture.channels_min)
-- 
1.9.1
