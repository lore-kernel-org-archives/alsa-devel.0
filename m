From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 06/10] ASoC: amd: memory release for rtd
	structure
Date: Tue, 8 May 2018 10:17:49 +0530
Message-ID: <1525754888-14124-6-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0087.outbound.protection.outlook.com [104.47.32.87])
 by alsa0.perex.cz (Postfix) with ESMTP id E1A70267646
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 06:46:44 +0200 (CEST)
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Daniel Kurtz <djkurtz@chromium.org>, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

rtd structure freed early may result in kernel panic in dma close
call back. moved releasing memory for rtd structure to the end of
dma close callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-pcm-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 8236116..ec9cab3 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -998,8 +998,6 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_i2ssp_stream = NULL;
 		/*
@@ -1028,7 +1026,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 */
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
-
+	kfree(rtd);
 	return 0;
 }
 
-- 
2.7.4
