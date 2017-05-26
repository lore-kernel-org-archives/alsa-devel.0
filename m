From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Fix typo in algorithm list warning message
Date: Fri, 26 May 2017 10:47:07 +0100
Message-ID: <1495792027-2290-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The list terminator is 0xbedead but the message warning if it
wasn't found was showing that 0xbeadead was expected.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5aff83b..65c059b5 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1888,7 +1888,7 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	}
 
 	if (be32_to_cpu(val) != 0xbedead)
-		adsp_warn(dsp, "Algorithm list end %x 0x%x != 0xbeadead\n",
+		adsp_warn(dsp, "Algorithm list end %x 0x%x != 0xbedead\n",
 			  pos + len, be32_to_cpu(val));
 
 	alg = kzalloc(len * 2, GFP_KERNEL | GFP_DMA);
-- 
1.9.1
