From: Colin King <colin.king@canonical.com>
Subject: [PATCH 5/5] ASoC: qcom: clean up indentation, remove extraneous tab
Date: Fri, 16 Nov 2018 15:06:36 +0000
Message-ID: <20181116150636.5226-5-colin.king@canonical.com>
References: <20181116150636.5226-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116150636.5226-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The return statement is indented too much by one level, fix this by
removing the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index d07271ea4c45..028bce671cbc 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -91,7 +91,7 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 	if (ret) {
 		dev_err(soc_runtime->dev,
 			"error writing to rdmactl reg: %d\n", ret);
-			return ret;
+		return ret;
 	}
 
 	data->dma_ch = dma_ch;
-- 
2.19.1
