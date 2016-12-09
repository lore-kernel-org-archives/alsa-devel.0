From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: wm_adsp_buf_alloc should use kfree in error path
Date: Fri, 9 Dec 2016 09:57:41 +0000
Message-ID: <1481277461-2132-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

buf was allocated by kzalloc() so it should be passed to kfree()

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ff111a82..593b7d1 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -183,15 +183,15 @@ static struct wm_adsp_buf *wm_adsp_buf_alloc(const void *src, size_t len,
 	struct wm_adsp_buf *buf = kzalloc(sizeof(*buf), GFP_KERNEL);
 
 	if (buf == NULL)
 		return NULL;
 
 	buf->buf = vmalloc(len);
 	if (!buf->buf) {
-		vfree(buf);
+		kfree(buf);
 		return NULL;
 	}
 	memcpy(buf->buf, src, len);
 
 	if (list)
 		list_add_tail(&buf->list, list);
 
-- 
1.9.1
