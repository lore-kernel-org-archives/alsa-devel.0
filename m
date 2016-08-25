From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: nau8810: Fix memory leak in
	nau8810_eq_put error path
Date: Thu, 25 Aug 2016 08:55:27 +0800
Message-ID: <1472086527-14900-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 959572671B3
 for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2016 02:55:48 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id g202so2168520pfb.1
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 17:55:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/nau8810.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index f9bcdc3..e455186 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -221,6 +221,7 @@ static int nau8810_eq_put(struct snd_kcontrol *kcontrol,
 		if (ret) {
 			dev_err(codec->dev, "EQ configuration fail, register: %x ret: %d\n",
 				reg + i, ret);
+			kfree(data);
 			return ret;
 		}
 	}
-- 
2.7.4
