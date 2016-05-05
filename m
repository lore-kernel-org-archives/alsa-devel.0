From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Move compr_attach/attached
	functions" to the asoc tree
Date: Thu, 05 May 2016 16:56:29 +0100
Message-ID: <E1ayLdd-0004lz-HI@debutante>
References: <1462378316-8615-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C8322668CF
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 17:56:34 +0200 (CEST)
In-Reply-To: <1462378316-8615-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Move compr_attach/attached functions

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

>From edd713509ae46ffcf178e3b1431af1ca202be8ba Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 4 May 2016 17:11:55 +0100
Subject: [PATCH] ASoC: wm_adsp: Move compr_attach/attached functions

Move wm_adsp_compr_attach and wm_adsp_compr_attached functions so they
will stay logically grouped with similar functions after some additional
changes.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 630ebcdaf46e..42fc46900400 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2452,6 +2452,25 @@ void wm_adsp2_remove(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_remove);
 
+static inline int wm_adsp_compr_attached(struct wm_adsp_compr *compr)
+{
+	return compr->buf != NULL;
+}
+
+static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
+{
+	/*
+	 * Note this will be more complex once each DSP can support multiple
+	 * streams
+	 */
+	if (!compr->dsp->buffer)
+		return -EINVAL;
+
+	compr->buf = compr->dsp->buffer;
+
+	return 0;
+}
+
 int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 {
 	struct wm_adsp_compr *compr;
@@ -2810,25 +2829,6 @@ static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 	return 0;
 }
 
-static inline int wm_adsp_compr_attached(struct wm_adsp_compr *compr)
-{
-	return compr->buf != NULL;
-}
-
-static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
-{
-	/*
-	 * Note this will be more complex once each DSP can support multiple
-	 * streams
-	 */
-	if (!compr->dsp->buffer)
-		return -EINVAL;
-
-	compr->buf = compr->dsp->buffer;
-
-	return 0;
-}
-
 int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 {
 	struct wm_adsp_compr *compr = stream->runtime->private_data;
-- 
2.8.1
