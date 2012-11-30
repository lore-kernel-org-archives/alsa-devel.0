From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3] ALSA: ASoC: cs4271: fix sparse warning
Date: Fri, 30 Nov 2012 11:28:55 +0100
Message-ID: <1354271337-15113-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 74BFA2650FE
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 11:29:14 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make the flag in the pdata of type bool to fix a sparse warning.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 include/sound/cs4271.h    | 2 +-
 sound/soc/codecs/cs4271.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/cs4271.h b/include/sound/cs4271.h
index 6d9e15e..dd8c48d 100644
--- a/include/sound/cs4271.h
+++ b/include/sound/cs4271.h
@@ -19,7 +19,7 @@
 
 struct cs4271_platform_data {
 	int gpio_nreset;	/* GPIO driving Reset pin, if any */
-	int amutec_eq_bmutec:1;	/* flag to enable AMUTEC=BMUTEC */
+	bool amutec_eq_bmutec;	/* flag to enable AMUTEC=BMUTEC */
 };
 
 #endif /* __CS4271_H */
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 6ad3878..70de900 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -474,7 +474,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	struct cs4271_platform_data *cs4271plat = codec->dev->platform_data;
 	int ret;
 	int gpio_nreset = -EINVAL;
-	int amutec_eq_bmutec = 0;
+	bool amutec_eq_bmutec = false;
 
 #ifdef CONFIG_OF
 	if (of_match_device(cs4271_dt_ids, codec->dev)) {
@@ -483,7 +483,7 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 
 		if (!of_get_property(codec->dev->of_node,
 				     "cirrus,amutec-eq-bmutec", NULL))
-			amutec_eq_bmutec = 1;
+			amutec_eq_bmutec = true;
 	}
 #endif
 
-- 
1.7.11.7
