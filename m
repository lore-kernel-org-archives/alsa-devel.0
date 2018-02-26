From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Support streams which can
	start/stop with DSP active" to the asoc tree
Date: Mon, 26 Feb 2018 11:17:22 +0000
Message-ID: <E1eqGmY-0005Sc-OJ@debutante>
References: <20180226104947.32037-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F57267A57
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 12:17:25 +0100 (CET)
In-Reply-To: <20180226104947.32037-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Support streams which can start/stop with DSP active

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

>From 61fc060c40e6b92350c08a210619fc7d93c61e42 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 26 Feb 2018 10:49:47 +0000
Subject: [PATCH] ASoC: wm_adsp: Support streams which can start/stop with DSP
 active

Clear the buffer data structure on each trigger start such that the
buffer is in a sensible state even if the DSP itself didn't restart.
This is necessary to support voice control streams which can trigger
multiple times without reloading the firmware.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0060aeb63a9f..ab91f1320ad5 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3258,6 +3258,13 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 	return 0;
 }
 
+static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
+{
+	buf->irq_count = 0xFFFFFFFF;
+	buf->read_index = -1;
+	buf->avail = 0;
+}
+
 static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr_buf *buf;
@@ -3268,8 +3275,8 @@ static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	buf->dsp = dsp;
-	buf->read_index = -1;
-	buf->irq_count = 0xFFFFFFFF;
+
+	wm_adsp_buffer_clear(buf);
 
 	ret = wm_adsp_buffer_locate(buf);
 	if (ret < 0) {
@@ -3327,16 +3334,17 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		if (wm_adsp_compr_attached(compr))
-			break;
-
-		ret = wm_adsp_compr_attach(compr);
-		if (ret < 0) {
-			adsp_err(dsp, "Failed to link buffer and stream: %d\n",
-				 ret);
-			break;
+		if (!wm_adsp_compr_attached(compr)) {
+			ret = wm_adsp_compr_attach(compr);
+			if (ret < 0) {
+				adsp_err(dsp, "Failed to link buffer and stream: %d\n",
+					 ret);
+				break;
+			}
 		}
 
+		wm_adsp_buffer_clear(compr->buf);
+
 		/* Trigger the IRQ at one fragment of data */
 		ret = wm_adsp_buffer_write(compr->buf,
 					   HOST_BUFFER_FIELD(high_water_mark),
-- 
2.16.1
