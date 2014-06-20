From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 16/16] ASoC: wm_hubs: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:12 +0530
Message-ID: <1403258352-8210-16-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id C29D52650BD
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:03:13 +0200 (CEST)
Received: by mail-pd0-f169.google.com with SMTP id g10so2830766pdj.28
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:03:12 -0700 (PDT)
In-Reply-To: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Let memory subsystem handle the error logging.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/wm_hubs.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 916817fe6632..374537d5e179 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -183,10 +183,8 @@ static void wm_hubs_dcs_cache_set(struct snd_soc_codec *codec, u16 dcs_cfg)
 		return;
 
 	cache = devm_kzalloc(codec->dev, sizeof(*cache), GFP_KERNEL);
-	if (!cache) {
-		dev_err(codec->dev, "Failed to allocate DCS cache entry\n");
+	if (!cache)
 		return;
-	}
 
 	cache->left = snd_soc_read(codec, WM8993_LEFT_OUTPUT_VOLUME);
 	cache->left &= WM8993_HPOUT1L_VOL_MASK;
-- 
1.7.9.5
