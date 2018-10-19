From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Log addresses as 8 digits in wm_adsp_buffer_populate
Date: Fri, 19 Oct 2018 13:25:16 +0100
Message-ID: <20181019122516.26720-2-rf@opensource.cirrus.com>
References: <20181019122516.26720-1-rf@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019122516.26720-1-rf@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

Increase the address value width in the debug log from 4 digits to
8 digits to allow for DSP cores with larger memory address ranges.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7ae10c632614..a53dc174bbf0 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3345,7 +3345,7 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 		region->cumulative_size = offset;
 
 		adsp_dbg(buf->dsp,
-			 "region=%d type=%d base=%04x off=%04x size=%04x\n",
+			 "region=%d type=%d base=%08x off=%08x size=%08x\n",
 			 i, region->mem_type, region->base_addr,
 			 region->offset, region->cumulative_size);
 	}
-- 
2.11.0
