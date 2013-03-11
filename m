From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: wm_adsp: fix possible memory leak in wm_adsp_load_coeff()
Date: Tue, 12 Mar 2013 00:23:15 +0800
Message-ID: <CAPgLHd9K-jMNYXY=sTkANCfzk_fCAF8arZUZHJmvBRAnCx1SUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

'file' is malloced in wm_adsp_load_coeff() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/wm_adsp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f3f7e75..9af1bdd 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -828,7 +828,8 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 						&buf_list);
 			if (!buf) {
 				adsp_err(dsp, "Out of memory\n");
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto out_fw;
 			}
 
 			adsp_dbg(dsp, "%s.%d: Writing %d bytes at %x\n",
@@ -865,7 +866,7 @@ out_fw:
 	wm_adsp_buf_free(&buf_list);
 out:
 	kfree(file);
-	return 0;
+	return ret;
 }
 
 int wm_adsp1_init(struct wm_adsp *adsp)
