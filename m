From: Erick Reyes <erickreyes@google.com>
Subject: [PATCH] ALSA: info: Check for integer overflow in snd_info_entry_write()
Date: Wed, 15 Aug 2018 17:55:48 -0700
Message-ID: <20180816005548.151269-1-erickreyes@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kernel-team@android.com, Vinod Koul <vkoul@kernel.org>, Joe Perches <joe@perches.com>, Al Viro <viro@zeniv.linux.org.uk>, alsa-devel@alsa-project.org, Erick Reyes <erickreyes@google.com>, Siqi Lin <siqilin@google.com>
List-Id: alsa-devel@alsa-project.org

Commit 4adb7bcbcb69 ("ALSA: core: Use seq_file for text proc file
reads") heavily refactored ALSA procfs and fixed the overflow as
a side-effect, so this fix only applies to kernels < 4.2 and
there is no upstream equivalent

snd_info_entry_write() resizes the buffer with an unsigned long
size argument that gets truncated because resize_info_buffer()
takes the size parameter as an unsigned int. On 64-bit kernels,
this causes the following copy_to_user() to write out-of-bounds
if (pos + count) can't be represented by an unsigned int.

Signed-off-by: Siqi Lin <siqilin@google.com>
Signed-off-by: Erick Reyes <erickreyes@google.com>
---
 sound/core/info.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 9f404e965ea2..08832c973a53 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -253,6 +253,7 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
 	struct snd_info_buffer *buf;
 	ssize_t size = 0;
 	loff_t pos;
+	unsigned long realloc_size;
 
 	data = file->private_data;
 	if (snd_BUG_ON(!data))
@@ -261,7 +262,8 @@ static ssize_t snd_info_entry_write(struct file *file, const char __user *buffer
 	pos = *offset;
 	if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
 		return -EIO;
-	if ((unsigned long) pos + (unsigned long) count < (unsigned long) pos)
+	realloc_size = (unsigned long) pos + (unsigned long) count;
+	if (realloc_size < (unsigned long) pos || realloc_size > UINT_MAX)
 		return -EIO;
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:
-- 
2.18.0.865.gffc8e1a3cd6-goog
