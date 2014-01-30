From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ASoC: davinci-mcasp: Return value handling
	cleanup for mcasp_common_hw_param()
Date: Thu, 30 Jan 2014 15:15:24 +0200
Message-ID: <1391087725-4088-4-git-send-email-peter.ujfalusi@ti.com>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E815265494
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:15:38 +0100 (CET)
In-Reply-To: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Take the return value from mcasp_common_hw_param() and use that in case of
error.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ae3e40a63e5e..c1c1ac8945d4 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -606,8 +606,10 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 
 	active_serializers = (channels + slots - 1) / slots;
 
-	if (mcasp_common_hw_param(mcasp, substream->stream, channels) == -EINVAL)
-		return -EINVAL;
+	ret = mcasp_common_hw_param(mcasp, substream->stream, channels);
+	if (ret)
+		return ret;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		fifo_level = mcasp->txnumevt * active_serializers;
 	else
-- 
1.8.5.3
