From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: fix oops w/
	for_each_rtd_codec_dai_rollback() macro
Date: Fri, 26 Oct 2018 16:54:43 -0500
Message-ID: <20181026215443.29081-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 829C52679C2
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2018 23:55:02 +0200 (CEST)
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

A kernel oops happens on an error case (usual missing BE mixer
configuration required by Intel SST driver). Git bisect points to this
macro and an operator precedence issue.

	for (; ((i--) >= 0) && ((dai) = rtd->codec_dais[i]);)

The initial code replaced by this macro was
	while (--i >= 0) {
		codec_dai = rtd->codec_dais[i];

Fix the C operator precedence difference by reverting to pre-decrement

Fixes: 0b7990e3897 ('ASoC: add for_each_rtd_codec_dai() macro')
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f1dab1f4b194..70c10a8f3e90 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1192,7 +1192,7 @@ struct snd_soc_pcm_runtime {
 	     ((i) < rtd->num_codecs) && ((dai) = rtd->codec_dais[i]); \
 	     (i)++)
 #define for_each_rtd_codec_dai_rollback(rtd, i, dai)		\
-	for (; ((i--) >= 0) && ((dai) = rtd->codec_dais[i]);)
+	for (; ((--i) >= 0) && ((dai) = rtd->codec_dais[i]);)
 
 
 /* mixer control */
-- 
2.17.1
