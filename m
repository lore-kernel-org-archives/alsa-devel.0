From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Avoid calling
	snd_compr_stop_error from WDT expiry
Date: Thu, 4 Apr 2019 13:56:01 +0100
Message-ID: <20190404125601.11684-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07DA8F8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 14:56:04 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is unsafe to call snd_compr_stop_error from outside of the
compressed ops. Firstly the compressed device lock needs to be held
and secondly it queues error work to issue a trigger stop which
should not happen after the stream has been freed. To avoid these
issues use the same trick used for the IRQ handling, simply send a
snd_compr_fragment_elapsed to cause user-space to wake on the poll,
then report the error when user-space issues the pointer request
after it wakes.

Fixes: 56bc22bd1dac ("ASoC: wm_adsp: Shutdown any compressed streams on DSP watchdog timeout")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c8c49d5b8ac95..a9298bfddd9c7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -4092,7 +4092,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 
 	buf = compr->buf;
 
-	if (!buf || buf->error) {
+	if (dsp->fatal_error || !buf || buf->error) {
 		snd_compr_stop_error(stream, SNDRV_PCM_STATE_XRUN);
 		ret = -EIO;
 		goto out;
@@ -4196,12 +4196,13 @@ static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
 static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
 			      char __user *buf, size_t count)
 {
+	struct wm_adsp *dsp = compr->dsp;
 	int ntotal = 0;
 	int nwords, nbytes;
 
 	compr_dbg(compr, "Requested read of %zu bytes\n", count);
 
-	if (!compr->buf || compr->buf->error) {
+	if (dsp->fatal_error || !compr->buf || compr->buf->error) {
 		snd_compr_stop_error(compr->stream, SNDRV_PCM_STATE_XRUN);
 		return -EIO;
 	}
@@ -4262,11 +4263,8 @@ static void wm_adsp_fatal_error(struct wm_adsp *dsp)
 	dsp->fatal_error = true;
 
 	list_for_each_entry(compr, &dsp->compr_list, list) {
-		if (compr->stream) {
-			snd_compr_stop_error(compr->stream,
-					     SNDRV_PCM_STATE_XRUN);
+		if (compr->stream)
 			snd_compr_fragment_elapsed(compr->stream);
-		}
 	}
 }
 
-- 
2.11.0
