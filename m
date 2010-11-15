From: Joe Perches <joe@perches.com>
Subject: [PATCH 43/44] sound/core/pcm_lib.c: Remove unnecessary semicolons
Date: Sun, 14 Nov 2010 19:05:02 -0800
Message-ID: <9fa8e193ce125ef4fd19a952792629c5ee84953f.1289789605.git.joe@perches.com>
References: <cover.1289789604.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1289789604.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/core/pcm_lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a1707cc..b75db8e 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -223,7 +223,7 @@ static void xrun_log(struct snd_pcm_substream *substream,
 	entry->jiffies = jiffies;
 	entry->pos = pos;
 	entry->period_size = runtime->period_size;
-	entry->buffer_size = runtime->buffer_size;;
+	entry->buffer_size = runtime->buffer_size;
 	entry->old_hw_ptr = runtime->status->hw_ptr;
 	entry->hw_ptr_base = runtime->hw_ptr_base;
 	log->idx = (log->idx + 1) % XRUN_LOG_CNT;
-- 
1.7.3.1.g432b3.dirty
