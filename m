From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: amd: fix spelling mistake: "failer" -> "failure"
Date: Tue,  1 May 2018 09:20:01 +0100
Message-ID: <20180501082001.21904-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/amd/acp-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 9c026c4d26d4..2b9a020e0b3e 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1014,7 +1014,7 @@ static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 	}
 	if (ret < 0)
 		dev_err(component->dev,
-			"buffer preallocation failer error:%d\n", ret);
+			"buffer preallocation failure error:%d\n", ret);
 	return ret;
 }
 
-- 
2.17.0
