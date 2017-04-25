From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: tas2552: Propagate the error code in
	suspend/resume
Date: Mon, 24 Apr 2017 21:43:49 -0300
Message-ID: <1493081029-23975-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C152226664F
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 02:44:03 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id o85so12710071qkh.0
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 17:44:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

tas2552_suspend() and tas2552_resume() currently always return success,
even though they may fail.

Fix this behaviour by always propagating the error code.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/tas2552.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index fd5251e..8840f72 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -637,7 +637,7 @@ static int tas2552_suspend(struct snd_soc_codec *codec)
 	if (ret != 0)
 		dev_err(codec->dev, "Failed to disable supplies: %d\n",
 			ret);
-	return 0;
+	return ret;
 }
 
 static int tas2552_resume(struct snd_soc_codec *codec)
@@ -653,7 +653,7 @@ static int tas2552_resume(struct snd_soc_codec *codec)
 			ret);
 	}
 
-	return 0;
+	return ret;
 }
 #else
 #define tas2552_suspend NULL
-- 
2.7.4
