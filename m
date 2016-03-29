From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Fix some subtle races on
	compressed stream" to the asoc tree
Date: Tue, 29 Mar 2016 10:13:57 -0700
Message-ID: <E1akxDJ-0001WC-3v@finisterre>
References: <1459171764-29921-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C8427266956
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 19:14:02 +0200 (CEST)
In-Reply-To: <1459171764-29921-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Fix some subtle races on compressed stream

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

>From 612047f0baefe2aeef1bc5ad8c7107a532b7d957 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 28 Mar 2016 14:29:22 +0100
Subject: [PATCH] ASoC: wm_adsp: Fix some subtle races on compressed stream

Firstly, we should be locking the pwr_lock when we initialise the
compressed buffer. Secondly, fixup a couple of places when we should be
pulling pointers only under the pwr_lock as they may be affected by
operations that take that lock.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d3b1cb15e7f0..4839d195c72a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2240,9 +2240,13 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
+		mutex_lock(&dsp->pwr_lock);
+
 		if (wm_adsp_fw[dsp->fw].num_caps != 0)
 			ret = wm_adsp_buffer_init(dsp);
 
+		mutex_unlock(&dsp->pwr_lock);
+
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
@@ -2814,12 +2818,15 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 
 int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 {
-	struct wm_adsp_compr_buf *buf = dsp->buffer;
-	struct wm_adsp_compr *compr = dsp->compr;
+	struct wm_adsp_compr_buf *buf;
+	struct wm_adsp_compr *compr;
 	int ret = 0;
 
 	mutex_lock(&dsp->pwr_lock);
 
+	buf = dsp->buffer;
+	compr = dsp->compr;
+
 	if (!buf) {
 		ret = -ENODEV;
 		goto out;
@@ -2879,14 +2886,16 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 			  struct snd_compr_tstamp *tstamp)
 {
 	struct wm_adsp_compr *compr = stream->runtime->private_data;
-	struct wm_adsp_compr_buf *buf = compr->buf;
 	struct wm_adsp *dsp = compr->dsp;
+	struct wm_adsp_compr_buf *buf;
 	int ret = 0;
 
 	adsp_dbg(dsp, "Pointer request\n");
 
 	mutex_lock(&dsp->pwr_lock);
 
+	buf = compr->buf;
+
 	if (!compr->buf) {
 		ret = -ENXIO;
 		goto out;
-- 
2.8.0.rc3
