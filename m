From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Factor out fetching of stream
	errors from the DSP" to the asoc tree
Date: Wed, 06 Apr 2016 10:19:43 -0700
Message-ID: <E1anr7H-0003Md-DY@finisterre>
References: <1459938115-25456-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66BBC26506E
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 19:19:53 +0200 (CEST)
In-Reply-To: <1459938115-25456-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Factor out fetching of stream errors from the DSP

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

>From 9771b18a0b374b6e6ecfa84c8b59d5ef79e969b1 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 6 Apr 2016 11:21:53 +0100
Subject: [PATCH] ASoC: wm_adsp: Factor out fetching of stream errors from the
 DSP

Factor out the reading of the DSP error flag into its own function to
support further improvements to the code.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 953c4278b75e..f70c60914042 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2816,6 +2816,23 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 	return 0;
 }
 
+static int wm_adsp_buffer_get_error(struct wm_adsp_compr_buf *buf)
+{
+	int ret;
+
+	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
+	if (ret < 0) {
+		adsp_err(buf->dsp, "Failed to check buffer error: %d\n", ret);
+		return ret;
+	}
+	if (buf->error != 0) {
+		adsp_err(buf->dsp, "Buffer error occurred: %d\n", buf->error);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr_buf *buf;
@@ -2834,16 +2851,9 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 
 	adsp_dbg(dsp, "Handling buffer IRQ\n");
 
-	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
-	if (ret < 0) {
-		adsp_err(dsp, "Failed to check buffer error: %d\n", ret);
-		goto out;
-	}
-	if (buf->error != 0) {
-		adsp_err(dsp, "Buffer error occurred: %d\n", buf->error);
-		ret = -EIO;
+	ret = wm_adsp_buffer_get_error(buf);
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
 				  &buf->irq_count);
-- 
2.8.0.rc3
