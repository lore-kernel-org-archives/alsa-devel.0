From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] ASoC: dapm: Remove redundant cast
Date: Tue, 21 Oct 2014 17:01:15 +0200
Message-ID: <1413903675-3363-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: alsa-devel@alsa-project.org

Both path->name and e->texts[i] have type const char*, so the cast is
slightly confusing and certainly unnecessary.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c61cb9c..39f992b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -496,7 +496,7 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 			list_add(&path->list, &dapm->card->paths);
 			list_add(&path->list_sink, &dest->sources);
 			list_add(&path->list_source, &src->sinks);
-			path->name = (char*)e->texts[i];
+			path->name = e->texts[i];
 			if (i == item)
 				path->connect = 1;
 			else
-- 
2.0.4
