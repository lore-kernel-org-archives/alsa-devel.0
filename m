From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: Reporting accurate hw_ptr for
	acp3x dma" to the asoc tree
Date: Mon, 13 May 2019 13:30:29 +0100 (BST)
Message-ID: <20190513123029.B90561129234@debutante.sirena.org.uk>
References: <1557452486-13396-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D775FF89735
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:43 +0200 (CEST)
In-Reply-To: <1557452486-13396-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Cc: SOC@sirena.org.uk, alsa-devel@alsa-project.org, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, "Gustavo A.R.Silva" <gustavo@embeddedor.com>, /@sirena.org.uk, Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>, moderated@sirena.org.uk, "Cc:"@sirena.org.uk, -@sirena.org.uk, Mark Brown <broonie@kernel.org>, DYNAMIC@sirena.org.uk, "list:SOUND"@sirena.org.uk, LAYER@sirena.org.uk, AUDIO@sirena.org.uk, Alexander.Deucher@amd.com, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: Reporting accurate hw_ptr for acp3x dma

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 35a7086eaa057a5ef6eef77af957e46c040be48b Mon Sep 17 00:00:00 2001
From: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Date: Fri, 10 May 2019 07:11:07 +0530
Subject: [PATCH] ASoC: amd: Reporting accurate hw_ptr for acp3x dma

acp3x dma pointer callback has issues in reporting hw_ptr.
Modified logic to use linear position registers to
retrieve accurate hw_ptr.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 43 +++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 9775bda2a4ca..a4ade6bb5beb 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -32,6 +32,7 @@ struct i2s_stream_instance {
 	u16 channels;
 	u32 xfer_resolution;
 	struct page *pg;
+	u64 bytescount;
 	void __iomem *acp3x_base;
 };
 
@@ -317,6 +318,24 @@ static int acp3x_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static u64 acp_get_byte_count(struct i2s_stream_instance *rtd, int direction)
+{
+	u64 byte_count;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		byte_count = rv_readl(rtd->acp3x_base +
+				      mmACP_BT_TX_LINEARPOSITIONCNTR_HIGH);
+		byte_count |= rv_readl(rtd->acp3x_base +
+				       mmACP_BT_TX_LINEARPOSITIONCNTR_LOW);
+	} else {
+		byte_count = rv_readl(rtd->acp3x_base +
+				      mmACP_BT_RX_LINEARPOSITIONCNTR_HIGH);
+		byte_count |= rv_readl(rtd->acp3x_base +
+				       mmACP_BT_RX_LINEARPOSITIONCNTR_LOW);
+	}
+	return byte_count;
+}
+
 static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params)
 {
@@ -350,18 +369,17 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_pcm_substream *substream)
 {
 	u32 pos = 0;
-	struct i2s_stream_instance *rtd = substream->runtime->private_data;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		pos = rv_readl(rtd->acp3x_base +
-			       mmACP_BT_TX_LINKPOSITIONCNTR);
-	else
-		pos = rv_readl(rtd->acp3x_base +
-			       mmACP_BT_RX_LINKPOSITIONCNTR);
-
-	if (pos >= MAX_BUFFER)
-		pos = 0;
-
+	u32 buffersize = 0;
+	u64 bytescount = 0;
+	struct i2s_stream_instance *rtd =
+		substream->runtime->private_data;
+
+	buffersize = frames_to_bytes(substream->runtime,
+				     substream->runtime->buffer_size);
+	bytescount = acp_get_byte_count(rtd, substream->stream);
+	if (bytescount > rtd->bytescount)
+		bytescount -= rtd->bytescount;
+	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(substream->runtime, pos);
 }
 
@@ -521,6 +539,7 @@ static int acp3x_dai_i2s_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		rtd->bytescount = acp_get_byte_count(rtd, substream->stream);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			rv_writel(period_bytes, rtd->acp3x_base +
 				  mmACP_BT_TX_INTR_WATERMARK_SIZE);
-- 
2.20.1
