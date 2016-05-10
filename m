From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Do not allow multiple
	streams in one direction" to the asoc tree
Date: Tue, 10 May 2016 19:50:05 +0100
Message-ID: <E1b0CjN-0000Dr-F4@debutante>
References: <1462790354-5627-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2939267520
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 20:50:11 +0200 (CEST)
In-Reply-To: <1462790354-5627-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Do not allow multiple streams in one direction

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

>From 19357366633cfc53532b587180af3655f0e453f3 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 9 May 2016 13:39:14 +0300
Subject: [PATCH] ASoC: davinci-mcasp: Do not allow multiple streams in one
 direction

Make sure that the user can not start multiple streams with the same
direction.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e1324989bd6b..020d8660e4e5 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1230,11 +1230,15 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	int i, dir;
 	int tdm_slots = mcasp->tdm_slots;
 
-	if (mcasp->tdm_mask[substream->stream])
-		tdm_slots = hweight32(mcasp->tdm_mask[substream->stream]);
+	/* Do not allow more then one stream per direction */
+	if (mcasp->substreams[substream->stream])
+		return -EBUSY;
 
 	mcasp->substreams[substream->stream] = substream;
 
+	if (mcasp->tdm_mask[substream->stream])
+		tdm_slots = hweight32(mcasp->tdm_mask[substream->stream]);
+
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
 		return 0;
 
-- 
2.8.1
