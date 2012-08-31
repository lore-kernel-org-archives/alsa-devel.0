From: Prasad Joshi <prasadjoshi.linux@gmail.com>
Subject: [PATCH] ASoC: correct the check for NULL dma_buffer pointer
Date: Fri, 31 Aug 2012 08:55:21 +0530
Message-ID: <1346383521-2990-1-git-send-email-prasadjoshi.linux@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: prasadjoshi.linux@gmail.com
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, rajeev-dlh.kumar@st.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The if condition
	if (!buf && !buf->area)

checks if the buf pointer is NULL and then dereferences it again to
check if the buffer area is NULL, resulting in possible NULL
dereference.

Signed-off-by: Prasad Joshi <prasadjoshi.linux@gmail.com>
---
 sound/soc/spear/spear_pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 97c2cac..8c7f237 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -138,7 +138,7 @@ static void spear_pcm_free(struct snd_pcm *pcm)
 			continue;
 
 		buf = &substream->dma_buffer;
-		if (!buf && !buf->area)
+		if (!buf || !buf->area)
 			continue;
 
 		dma_free_writecombine(pcm->card->dev, buf->bytes,
-- 
1.7.5.4
