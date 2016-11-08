From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: lpass-platform: initialize dma channel number
Date: Tue,  8 Nov 2016 14:38:52 +0100
Message-ID: <20161108133916.1742379-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kenneth Westfield <kwestfie@codeaurora.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A bugfix accidentally removed the implicit initialization of the
dma channel number, causing undefined behavior when
v->alloc_dma_channel is NULL:

sound/soc/qcom/lpass-platform.c: In function ‘lpass_platform_pcmops_open’:
sound/soc/qcom/lpass-platform.c:83:29: error: ‘dma_ch’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

This adds back an explicit initialization to zero, restoring the
previous behavior for that case.

Fixes: 022d00ee0b55 ("ASoC: lpass-platform: Fix broken pcm data usage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/qcom/lpass-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 07000f53db44..e223bc90b2ef 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -77,6 +77,9 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 
 	if (v->alloc_dma_channel)
 		dma_ch = v->alloc_dma_channel(drvdata, dir);
+	else
+		dma_ch = 0;
+
 	if (dma_ch < 0)
 		return dma_ch;
 
-- 
2.9.0
