From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Update cached error state on
	trigger" to the asoc tree
Date: Wed, 20 Feb 2019 12:13:22 +0000 (GMT)
Message-ID: <20190220121322.966D111274ED@debutante.sirena.org.uk>
References: <20190219173157.14611-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE06AF8961D
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 13:13:24 +0100 (CET)
In-Reply-To: <20190219173157.14611-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, lgirdwood@gmail.com, stuarth@opensource.cirrus.com, broonie@kernel.org, aford@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Update cached error state on trigger

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From f938f3485c385b9b5c796b2e93427c015a7d18fa Mon Sep 17 00:00:00 2001
From: Stuart Henderson <stuarth@opensource.cirrus.com>
Date: Tue, 19 Feb 2019 17:31:57 +0000
Subject: [PATCH] ASoC: wm_adsp: Update cached error state on trigger

If a compressed stream is restarted after getting an error, the cached
error value will still be used on the next pointer request, preventing
the stream from starting.  Resolve this by ensuring the error status is
updated on trigger start.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1dd291cebe67..d15cf6e42adc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3422,6 +3422,23 @@ static int wm_adsp_buffer_free(struct wm_adsp *dsp)
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
 int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 {
 	struct wm_adsp_compr *compr = stream->runtime->private_data;
@@ -3443,6 +3460,10 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 			}
 		}
 
+		ret = wm_adsp_buffer_get_error(compr->buf);
+		if (ret < 0)
+			break;
+
 		wm_adsp_buffer_clear(compr->buf);
 
 		/* Trigger the IRQ at one fragment of data */
@@ -3518,23 +3539,6 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 	return 0;
 }
 
-static int wm_adsp_buffer_get_error(struct wm_adsp_compr_buf *buf)
-{
-	int ret;
-
-	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
-	if (ret < 0) {
-		adsp_err(buf->dsp, "Failed to check buffer error: %d\n", ret);
-		return ret;
-	}
-	if (buf->error != 0) {
-		adsp_err(buf->dsp, "Buffer error occurred: %d\n", buf->error);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr_buf *buf;
-- 
2.20.1
