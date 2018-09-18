From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Fix capture unstable in beginning
	for some runs" to the asoc tree
Date: Tue, 18 Sep 2018 18:45:01 +0100 (BST)
Message-ID: <20180918174501.56D92440078@finisterre.ee.mobilebroadband>
References: <1537255398-25166-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A472926788C
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 19:45:06 +0200 (CEST)
In-Reply-To: <1537255398-25166-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Fix capture unstable in beginning for some runs

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

>From c50535ed6a10fcae1b64ae83c0f6b1eeb5535afc Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Tue, 18 Sep 2018 12:53:13 +0530
Subject: [PATCH] ASoC: AMD: Fix capture unstable in beginning for some runs

alsa_conformance_test -C hw:0,4 -p 1024 --debug
would sometime show:
TIME_DIFF(s)    HW_LEVEL       READ              RATE
0.000095970         1024       1024    10670001.041992
0.042609555         1024       2048       24032.168372
0.021330364         1024       3072       48006.681930
0.021339559         1024       4096       47985.996337
The issue is that in dma pointer function we can have stale value
of the register for current descriptor of channel.
The register retains the number of the last descriptor that
was transferred.

Fix ensures that we report position, 0, till the one period worth of
data is transferred.  After one period of data, in handler of period
completion interrupt we update the config and correct value of descriptor
starts reflecting.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 77b265bd0505..3135e9eafd18 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1036,16 +1036,22 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
-		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
-		if (dscr == rtd->dma_dscr_idx_1)
-			pos = period_bytes;
-		else
-			pos = 0;
 		bytescount = acp_get_byte_count(rtd);
-		if (bytescount > rtd->bytescount)
+		if (bytescount >= rtd->bytescount)
 			bytescount -= rtd->bytescount;
-		delay = do_div(bytescount, period_bytes);
-		runtime->delay = bytes_to_frames(runtime, delay);
+		if (bytescount < period_bytes) {
+			pos = 0;
+		} else {
+			dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+			if (dscr == rtd->dma_dscr_idx_1)
+				pos = period_bytes;
+			else
+				pos = 0;
+		}
+		if (bytescount > 0) {
+			delay = do_div(bytescount, period_bytes);
+			runtime->delay = bytes_to_frames(runtime, delay);
+		}
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
2.19.0
