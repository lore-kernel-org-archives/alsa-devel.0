From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 08/16] ASoC: wl1273: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:04 +0530
Message-ID: <1403258352-8210-8-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E8D265007
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:47 +0200 (CEST)
Received: by mail-pd0-f181.google.com with SMTP id v10so2826246pde.40
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:46 -0700 (PDT)
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
 sound/soc/codecs/wl1273.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 4ead0dc02b87..5d8ba779085b 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -461,10 +461,8 @@ static int wl1273_probe(struct snd_soc_codec *codec)
 	}
 
 	wl1273 = kzalloc(sizeof(struct wl1273_priv), GFP_KERNEL);
-	if (wl1273 == NULL) {
-		dev_err(codec->dev, "Cannot allocate memory.\n");
+	if (!wl1273)
 		return -ENOMEM;
-	}
 
 	wl1273->mode = WL1273_MODE_BT;
 	wl1273->core = *core;
-- 
1.7.9.5
