From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 3/3] ASoC: stm32: dfsdm: add mmap support
Date: Mon, 4 Mar 2019 15:52:45 +0100
Message-ID: <1551711165-28684-4-git-send-email-olivier.moysan@st.com>
References: <1551711165-28684-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551711165-28684-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Enable direct access (mmap) support.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 24948b95eb19..0d3040aef7f6 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -44,7 +44,7 @@ struct stm32_adfsdm_priv {
 
 static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-	    SNDRV_PCM_INFO_PAUSE,
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_PAUSE,
 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
 
 	.rate_min = 8000,
-- 
2.7.4
