From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 2/2] ALSA: seq: Fix snd_seq_call_port_info_ioctl in compat mode
Date: Mon, 18 Jan 2016 21:35:01 +0800
Message-ID: <1453124101-3402-2-git-send-email-drinkcat@chromium.org>
References: <1453124101-3402-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453124101-3402-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Nicolas Boichat <drinkcat@chromium.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This reverts one hunk of
commit ef44a1ec6eee ("ALSA: sound/core: use memdup_user()"), which
replaced a number of kmalloc followed by memcpy with memdup calls.

In this case, we are copying from a struct snd_seq_port_info32 to a
struct snd_seq_port_info, but the latter is 4 bytes longer than the
32-bit version, so we need to separate kmalloc and copy calls.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/core/seq/seq_compat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index 81f7c10..6517590 100644
--- a/sound/core/seq/seq_compat.c
+++ b/sound/core/seq/seq_compat.c
@@ -49,11 +49,12 @@ static int snd_seq_call_port_info_ioctl(struct snd_seq_client *client, unsigned
 	struct snd_seq_port_info *data;
 	mm_segment_t fs;
 
-	data = memdup_user(data32, sizeof(*data32));
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	if (get_user(data->flags, &data32->flags) ||
+	if (copy_from_user(data, data32, sizeof(*data32)) ||
+	    get_user(data->flags, &data32->flags) ||
 	    get_user(data->time_queue, &data32->time_queue))
 		goto error;
 	data->kernel = NULL;
-- 
2.6.0.rc2.230.g3dd15c0
