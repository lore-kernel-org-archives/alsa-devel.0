From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Avoid calling
	snd_compr_stop_error from WDT expiry" to the asoc tree
Date: Thu,  4 Apr 2019 20:58:34 +0700 (+07)
Message-ID: <20190404135834.A5851441D3B@finisterre.ee.mobilebroadband>
References: <20190404125601.11684-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13045F8972E
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 15:58:44 +0200 (CEST)
In-Reply-To: <20190404125601.11684-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, stable@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Avoid calling snd_compr_stop_error from WDT expiry

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

>From aa612f2b006aa3552871dabcd6a8e90e33f65e09 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 4 Apr 2019 13:56:01 +0100
Subject: [PATCH] ASoC: wm_adsp: Avoid calling snd_compr_stop_error from WDT
 expiry

It is unsafe to call snd_compr_stop_error from outside of the
compressed ops. Firstly the compressed device lock needs to be held
and secondly it queues error work to issue a trigger stop which
should not happen after the stream has been freed. To avoid these
issues use the same trick used for the IRQ handling, simply send a
snd_compr_fragment_elapsed to cause user-space to wake on the poll,
then report the error when user-space issues the pointer request
after it wakes.

Fixes: a2bcbc1b9ac2f ("ASoC: wm_adsp: Shutdown any compressed streams on DSP watchdog timeout")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@kernel.org
---
 sound/soc/codecs/wm_adsp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c8c49d5b8ac9..a9298bfddd9c 100644
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
2.20.1
