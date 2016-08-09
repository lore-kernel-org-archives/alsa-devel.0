From: jjassal <jaswinderjassal@gmail.com>
Subject: [PATCH] ASoC: core: fix shift used for second item in
	snd_soc_get_enum_double
Date: Tue,  9 Aug 2016 19:09:05 +0100
Message-ID: <1470766145-3340-1-git-send-email-jjassal@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F449265D44
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 20:12:00 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id i138so4757328wmf.3
 for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2016 11:12:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: jjassal <jjassal@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Incorrect shift value was being used to extract the second item.

Signed-off-by: jjassal <jjassal@opensource.wolfsonmicro.com>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index a513a34..9fc1a7b 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -77,7 +77,7 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	item = snd_soc_enum_val_to_item(e, val);
 	ucontrol->value.enumerated.item[0] = item;
 	if (e->shift_l != e->shift_r) {
-		val = (reg_val >> e->shift_l) & e->mask;
+		val = (reg_val >> e->shift_r) & e->mask;
 		item = snd_soc_enum_val_to_item(e, val);
 		ucontrol->value.enumerated.item[1] = item;
 	}
-- 
2.1.4
