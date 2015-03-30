From: Joe Perches <joe@perches.com>
Subject: [PATCH 17/25] sound: Use bool function return values of true/false not 1/0
Date: Mon, 30 Mar 2015 16:46:15 -0700
Message-ID: <89241da97a2fb2d869ea7902b34743bc4991e88b.1427759009.git.joe@perches.com>
References: <cover.1427759009.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1427759009.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/sound/soc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fcb312b..5ca7ec0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1418,13 +1418,13 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
 {
 	if (mc->reg == mc->rreg && mc->shift == mc->rshift)
-		return 0;
+		return false;
 	/*
 	 * mc->reg == mc->rreg && mc->shift != mc->rshift, or
 	 * mc->reg != mc->rreg means that the control is
 	 * stereo (bits in one register or in two registers)
 	 */
-	return 1;
+	return true;
 }
 
 static inline unsigned int snd_soc_enum_val_to_item(struct soc_enum *e,
-- 
2.1.2
