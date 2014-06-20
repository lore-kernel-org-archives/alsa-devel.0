From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 14/16] ASoC: wm8994: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:10 +0530
Message-ID: <1403258352-8210-14-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 4860C261B2D
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:03:07 +0200 (CEST)
Received: by mail-pd0-f178.google.com with SMTP id r10so2847756pdi.9
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:03:06 -0700 (PDT)
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
 sound/soc/codecs/wm8994.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9719d3ca8e47..39d8df040116 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3296,12 +3296,8 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		/* We need an array of texts for the enum API */
 		wm8994->drc_texts = devm_kzalloc(wm8994->hubs.codec->dev,
 			    sizeof(char *) * pdata->num_drc_cfgs, GFP_KERNEL);
-		if (!wm8994->drc_texts) {
-			dev_err(wm8994->hubs.codec->dev,
-				"Failed to allocate %d DRC config texts\n",
-				pdata->num_drc_cfgs);
+		if (!wm8994->drc_texts)
 			return;
-		}
 
 		for (i = 0; i < pdata->num_drc_cfgs; i++)
 			wm8994->drc_texts[i] = pdata->drc_cfgs[i].name;
-- 
1.7.9.5
