From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2] trivial: sound/core/seq/seq_memory.c: Fix closing brace followed by if
Date: Mon, 23 Jun 2014 17:56:09 +0200
Message-ID: <1403538969-26147-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1403293803-17650-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403293803-17650-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Jiri Kosina <trivial@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: alsa-devel@alsa-project.org

Add a newline and, while at it, remove a space and redundant braces.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 sound/core/seq/seq_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 1e206de..ba8e4a6 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -101,9 +101,9 @@ int snd_seq_dump_var_event(const struct snd_seq_event *event,
 			len -= size;
 		}
 		return 0;
-	} if (! (event->data.ext.len & SNDRV_SEQ_EXT_CHAINED)) {
-		return func(private_data, event->data.ext.ptr, len);
 	}
+	if (!(event->data.ext.len & SNDRV_SEQ_EXT_CHAINED))
+		return func(private_data, event->data.ext.ptr, len);
 
 	cell = (struct snd_seq_event_cell *)event->data.ext.ptr;
 	for (; len > 0 && cell; cell = cell->next) {
-- 
1.9.2
