From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Detach compressed stream on
	free" to the asoc tree
Date: Thu, 05 May 2016 16:56:26 +0100
Message-ID: <E1ayLda-0004lB-Hx@debutante>
References: <1462378316-8615-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B87B2668CE
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 17:56:33 +0200 (CEST)
In-Reply-To: <1462378316-8615-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Detach compressed stream on free

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

>From 721be3be2f75c69cf0f2d7826007a6eefee7dac3 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 4 May 2016 17:11:56 +0100
Subject: [PATCH] ASoC: wm_adsp: Detach compressed stream on free

If someone powers down the DSP core (through routing changes
say) whilst a compressed record is in progress we can end up
using a freed pointer to the buffer object. When a compressed
audio stream is triggered we attach it to a buffer on a physical
DSP. This patch adds a detach of the buffer from the stream when
the stream is freed or when the DSP is powered down which avoids
the situation where we use a buffer when it is no longer valid.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 42fc46900400..a07bd7c2c587 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -273,8 +273,11 @@ struct wm_adsp_buffer {
 	__be32 words_written[2];	/* total words written (64 bit) */
 };
 
+struct wm_adsp_compr;
+
 struct wm_adsp_compr_buf {
 	struct wm_adsp *dsp;
+	struct wm_adsp_compr *compr;
 
 	struct wm_adsp_buffer_region *regions;
 	u32 host_buf_ptr;
@@ -2467,10 +2470,26 @@ static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
 		return -EINVAL;
 
 	compr->buf = compr->dsp->buffer;
+	compr->buf->compr = compr;
 
 	return 0;
 }
 
+static void wm_adsp_compr_detach(struct wm_adsp_compr *compr)
+{
+	if (!compr)
+		return;
+
+	/* Wake the poll so it can see buffer is no longer attached */
+	if (compr->stream)
+		snd_compr_fragment_elapsed(compr->stream);
+
+	if (wm_adsp_compr_attached(compr)) {
+		compr->buf->compr = NULL;
+		compr->buf = NULL;
+	}
+}
+
 int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 {
 	struct wm_adsp_compr *compr;
@@ -2524,6 +2543,7 @@ int wm_adsp_compr_free(struct snd_compr_stream *stream)
 
 	mutex_lock(&dsp->pwr_lock);
 
+	wm_adsp_compr_detach(compr);
 	dsp->compr = NULL;
 
 	kfree(compr->raw_buf);
@@ -2820,6 +2840,8 @@ err_buffer:
 static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 {
 	if (dsp->buffer) {
+		wm_adsp_compr_detach(dsp->buffer->compr);
+
 		kfree(dsp->buffer->regions);
 		kfree(dsp->buffer);
 
-- 
2.8.1
