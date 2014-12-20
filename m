From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: isa: gus: gus_instr.c:  Remove unused function
Date: Sat, 20 Dec 2014 18:03:24 +0100
Message-ID: <1419095004-9727-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Remove the function snd_gus_simple_remove_sample() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/isa/gus/gus_instr.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/isa/gus/gus_instr.c b/sound/isa/gus/gus_instr.c
index 4dc9caf..2d21408 100644
--- a/sound/isa/gus/gus_instr.c
+++ b/sound/isa/gus/gus_instr.c
@@ -162,11 +162,3 @@ int snd_gus_simple_get_sample(void *private_data, struct simple_instrument *inst
 
 	return snd_gus_dram_read(gus, data, instr->address.memory, instr->size, 0);
 }
-
-int snd_gus_simple_remove_sample(void *private_data, struct simple_instrument *instr,
-			         int atomic)
-{
-	struct snd_gus_card *gus = private_data;
-
-	return snd_gf1_mem_free(&gus->gf1.mem_alloc, instr->address.memory);
-}
-- 
1.7.10.4
