From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] SoC: nuc900: Remove space before semicolon
Date: Sat, 25 Feb 2017 22:11:47 +0200
Message-ID: <1488053507-10389-1-git-send-email-codrut.cristian.grosu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Codrut Grosu <codrut.cristian.grosu@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/nuc900/nuc900-ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615af..1cacfb4 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -76,7 +76,7 @@ static unsigned short nuc900_ac97_read(struct snd_ac97 *ac97,
 		goto out;
 	}

-	val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0) ;
+	val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0);
 	val &= ~SLOT1_VALID;
 	AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACOS0, val);

--
1.9.1
