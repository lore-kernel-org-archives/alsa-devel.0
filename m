From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Do not allow multiple
	streams in one direction
Date: Mon, 9 May 2016 13:39:14 +0300
Message-ID: <1462790354-5627-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id F19842606C7
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 12:39:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Make sure that the user can not start multiple streams with the same
direction.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index c4cd8e4fff9a..50523e744483 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1252,11 +1252,15 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	int i, dir;
 	int tdm_slots = mcasp->tdm_slots;
 
-	if (mcasp->tdm_mask[substream->stream])
-		tdm_slots = hweight32(mcasp->tdm_mask[substream->stream]);
+	/* Do not allow more then one stream per direction */
+	if (mcasp->substreams[substream->stream])
+		return -EBUSY;
 
 	mcasp->substreams[substream->stream] = substream;
 
+	if (mcasp->tdm_mask[substream->stream])
+		tdm_slots = hweight32(mcasp->tdm_mask[substream->stream]);
+
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
 		return 0;
 
-- 
2.8.1
