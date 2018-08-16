From: <gregkh@linuxfoundation.org>
Subject: Patch "ALSA: info: Check for integer overflow in
	snd_info_entry_write()" has been added to the 3.18-stable tree
Date: Thu, 16 Aug 2018 12:08:01 +0200
Message-ID: <153441408119339@kroah.com>
References: <20180816005548.151269-1-erickreyes@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C53D26781E
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2018 12:08:07 +0200 (CEST)
In-Reply-To: <20180816005548.151269-1-erickreyes@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, erickreyes@google.com, gregkh@linuxfoundation.org, joe@perches.com, kernel-team@android.com, perex@perex.cz, siqilin@google.com, tiwai@suse.com, viro@zeniv.linux.org.uk, vkoul@kernel.org
Cc: stable-commits@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


This is a note to let you know that I've just added the patch titled

    ALSA: info: Check for integer overflow in snd_info_entry_write()

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     alsa-info-check-for-integer-overflow-in-snd_info_entry_write.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From erickreyes@google.com  Thu Aug 16 12:07:22 2018
From: Erick Reyes <erickreyes@google.com>
Date: Wed, 15 Aug 2018 17:55:48 -0700
Subject: ALSA: info: Check for integer overflow in snd_info_entry_write()
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kernel-team@android.com, Vinod Koul <vkoul@kernel.org>, Joe Perches <joe@perches.com>, Al Viro <viro@zeniv.linux.org.uk>, alsa-devel@alsa-project.org, Erick Reyes <erickreyes@google.com>, Siqi Lin <siqilin@google.com>
Message-ID: <20180816005548.151269-1-erickreyes@google.com>

From: Erick Reyes <erickreyes@google.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/info.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -253,6 +253,7 @@ static ssize_t snd_info_entry_write(stru
 	struct snd_info_buffer *buf;
 	ssize_t size = 0;
 	loff_t pos;
+	unsigned long realloc_size;
 
 	data = file->private_data;
 	if (snd_BUG_ON(!data))
@@ -261,7 +262,8 @@ static ssize_t snd_info_entry_write(stru
 	pos = *offset;
 	if (pos < 0 || (long) pos != pos || (ssize_t) count < 0)
 		return -EIO;
-	if ((unsigned long) pos + (unsigned long) count < (unsigned long) pos)
+	realloc_size = (unsigned long) pos + (unsigned long) count;
+	if (realloc_size < (unsigned long) pos || realloc_size > UINT_MAX)
 		return -EIO;
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:


Patches currently in stable-queue which might be from erickreyes@google.com are

queue-3.18/alsa-info-check-for-integer-overflow-in-snd_info_entry_write.patch
