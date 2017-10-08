From: Christos Gkekas <chris.gekas@gmail.com>
Subject: [PATCH] ASoC: cygnus: Remove unnecessary active_slots check
Date: Sun,  8 Oct 2017 19:20:30 +0100
Message-ID: <1507486830-21507-1-git-send-email-chris.gekas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Variable active_slots is unsigned so checking whether it is less than
zero is not necessary.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 15c438f..cb46128 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -998,7 +998,7 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 
 	active_slots = hweight32(tx_mask);
 
-	if ((active_slots < 0) || (active_slots > 16))
+	if (active_slots > 16)
 		return -EINVAL;
 
 	/* Slot value must be even */
-- 
2.7.4
