From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Treat missing compressed
	buffer as a fatal error" to the asoc tree
Date: Mon, 13 Jun 2016 16:50:35 +0100
Message-ID: <E1bCU8J-0003Gi-UG@finisterre>
References: <1465823832-14718-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D3E3265E22
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 17:50:49 +0200 (CEST)
In-Reply-To: <1465823832-14718-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Treat missing compressed buffer as a fatal error

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

>From 28ee3d73773e2d9ae922f7496723ab5c92cc16de Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 13 Jun 2016 14:17:12 +0100
Subject: [PATCH] ASoC: wm_adsp: Treat missing compressed buffer as a fatal
 error

If the DSP is powered down whilst a compressed stream is being processed
we should treat this as a fatal error, clearly the stream is no longer
valid.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 8ed1cdececf2..7e42474d7ae4 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3037,12 +3037,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 
 	buf = compr->buf;
 
-	if (!compr->buf) {
-		ret = -ENXIO;
-		goto out;
-	}
-
-	if (compr->buf->error) {
+	if (!compr->buf || compr->buf->error) {
 		snd_compr_stop_error(stream, SNDRV_PCM_STATE_XRUN);
 		ret = -EIO;
 		goto out;
@@ -3161,10 +3156,7 @@ static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
 
 	adsp_dbg(dsp, "Requested read of %zu bytes\n", count);
 
-	if (!compr->buf)
-		return -ENXIO;
-
-	if (compr->buf->error) {
+	if (!compr->buf || compr->buf->error) {
 		snd_compr_stop_error(compr->stream, SNDRV_PCM_STATE_XRUN);
 		return -EIO;
 	}
-- 
2.8.1
