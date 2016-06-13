From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Use new snd_compr_stop_error
	to signal stream failure" to the asoc tree
Date: Mon, 13 Jun 2016 16:50:39 +0100
Message-ID: <E1bCU8N-0003HZ-GA@finisterre>
References: <1460384855-10567-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9EE026609F
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 17:50:51 +0200 (CEST)
In-Reply-To: <1460384855-10567-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Use new snd_compr_stop_error to signal stream failure

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8d280664d26538cd37e7c08b1c2b58fe006cc482 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 13 Jun 2016 14:17:11 +0100
Subject: [PATCH] ASoC: wm_adsp: Use new snd_compr_stop_error to signal stream
 failure

If we encounter a fatal error on the compressed stream call the new
snd_compr_stop_error to shutdown the stream and allow the core to
inform user-space that the stream is no longer valid.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a07bd7c2c587..8ed1cdececf2 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3043,6 +3043,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 	}
 
 	if (compr->buf->error) {
+		snd_compr_stop_error(stream, SNDRV_PCM_STATE_XRUN);
 		ret = -EIO;
 		goto out;
 	}
@@ -3060,8 +3061,12 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 		 */
 		if (buf->avail < wm_adsp_compr_frag_words(compr)) {
 			ret = wm_adsp_buffer_get_error(buf);
-			if (ret < 0)
+			if (ret < 0) {
+				if (compr->buf->error)
+					snd_compr_stop_error(stream,
+							SNDRV_PCM_STATE_XRUN);
 				goto out;
+			}
 
 			ret = wm_adsp_buffer_reenable_irq(buf);
 			if (ret < 0) {
@@ -3159,8 +3164,10 @@ static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
 	if (!compr->buf)
 		return -ENXIO;
 
-	if (compr->buf->error)
+	if (compr->buf->error) {
+		snd_compr_stop_error(compr->stream, SNDRV_PCM_STATE_XRUN);
 		return -EIO;
+	}
 
 	count /= WM_ADSP_DATA_WORD_SIZE;
 
-- 
2.8.1
