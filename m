From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: ppc/awacs: shut up maybe-uninitialized warning
Date: Mon,  4 Jul 2016 17:07:45 +0200
Message-ID: <20160704150759.2909708-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The awacs sound driver produces a false-positive warning in ppc64_defconfig:

sound/ppc/awacs.c: In function 'snd_pmac_awacs_init':
include/sound/control.h:219:9: warning: 'master_vol' may be used uninitialized in this function [-Wmaybe-uninitialized]

I haven't come up with a good way to rewrite the code to avoid the
warning, so here is a bad one: I initialize the variable before
the conditionall initialization so gcc no longer has to worry about
it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/ppc/awacs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index 09da7b52bc2e..1468e4b7bf93 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -991,6 +991,7 @@ snd_pmac_awacs_init(struct snd_pmac *chip)
 		if (err < 0)
 			return err;
 	}
+	master_vol = NULL;
 	if (pm7500)
 		err = build_mixers(chip,
 				   ARRAY_SIZE(snd_pmac_awacs_mixers_pmac7500),
-- 
2.9.0
