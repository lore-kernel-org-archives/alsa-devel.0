From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 03/16] ASoC: sgtl5000: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:28:59 +0530
Message-ID: <1403258352-8210-3-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 99D15261ADB
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:30 +0200 (CEST)
Received: by mail-pd0-f171.google.com with SMTP id fp1so2820638pdb.30
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:29 -0700 (PDT)
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
 sound/soc/codecs/sgtl5000.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 3d39f0b5b4a8..249fadbdb42e 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -843,10 +843,8 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 
 	ldo = kzalloc(sizeof(struct ldo_regulator), GFP_KERNEL);
 
-	if (!ldo) {
-		dev_err(codec->dev, "failed to allocate ldo_regulator\n");
+	if (!ldo)
 		return -ENOMEM;
-	}
 
 	ldo->desc.name = kstrdup(dev_name(codec->dev), GFP_KERNEL);
 	if (!ldo->desc.name) {
-- 
1.7.9.5
