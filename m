From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: compress: Fix leak of a widget list in
	soc_compr_open_fe
Date: Tue, 16 Aug 2016 11:24:46 +0100
Message-ID: <1471343086-11383-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id DA71D265A1E
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 12:24:39 +0200 (CEST)
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

After we have called dpcm_path_get we should make sure to call
dpcm_path_put on all error paths. This was not happening causing the
allocated widget list to be leaked, this patch corrects this by adding a
dpcm_path_put to the error path.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d2df46c..bf7b52f 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -121,7 +121,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 		dpcm_be_disconnect(fe, stream);
 		fe->dpcm[stream].runtime = NULL;
-		goto fe_err;
+		goto path_err;
 	}
 
 	dpcm_clear_pending_state(fe, stream);
@@ -136,6 +136,8 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 	return 0;
 
+path_err:
+	dpcm_path_put(&list);
 fe_err:
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
 		fe->dai_link->compr_ops->shutdown(cstream);
-- 
2.1.4
