From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/1] ASoC: core: Fix trivial typo
Date: Tue,  8 Jul 2014 14:16:12 +0530
Message-ID: <1404809172-12151-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 75C3D26072A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 10:50:06 +0200 (CEST)
Received: by mail-pa0-f43.google.com with SMTP id lf10so6993996pab.30
 for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2014 01:50:04 -0700 (PDT)
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

Replaced providing with provided.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/soc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c32d8399e770..c5ce67483abc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4396,7 +4396,7 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 
 	ret = of_property_read_string_index(np, propname, 0, &card->name);
 	/*
-	 * EINVAL means the property does not exist. This is fine providing
+	 * EINVAL means the property does not exist. This is fine provided
 	 * card->name was previously set, which is checked later in
 	 * snd_soc_register_card.
 	 */
-- 
1.7.9.5
