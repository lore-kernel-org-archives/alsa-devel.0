From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: gus: remove redundant pointer private_data
Date: Mon, 16 Jul 2018 09:49:38 +0100
Message-ID: <20180716084938.15733-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Pointer private_data is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'private_data' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/gus/gus_reset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/isa/gus/gus_reset.c b/sound/isa/gus/gus_reset.c
index 3d1fed0c2620..59b3f683d49b 100644
--- a/sound/isa/gus/gus_reset.c
+++ b/sound/isa/gus/gus_reset.c
@@ -292,7 +292,6 @@ void snd_gf1_free_voice(struct snd_gus_card * gus, struct snd_gus_voice *voice)
 {
 	unsigned long flags;
 	void (*private_free)(struct snd_gus_voice *voice);
-	void *private_data;
 
 	if (voice == NULL || !voice->use)
 		return;
@@ -300,7 +299,6 @@ void snd_gf1_free_voice(struct snd_gus_card * gus, struct snd_gus_voice *voice)
 	snd_gf1_clear_voices(gus, voice->number, voice->number);
 	spin_lock_irqsave(&gus->voice_alloc, flags);
 	private_free = voice->private_free;
-	private_data = voice->private_data;
 	voice->private_free = NULL;
 	voice->private_data = NULL;
 	if (voice->pcm)
-- 
2.17.1
