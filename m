From: Dan Rosenberg <drosenberg@vsecurity.com>
Subject: [PATCH] sound/oss/midi_synth: prevent underflow, use of
 uninitialized value, and signedness issue
Date: Tue, 22 Mar 2011 14:31:08 -0400
Message-ID: <1300818668.2130.27.camel@dan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, security@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The offset passed to midi_synth_load_patch() can be essentially
arbitrary.  If it's greater than the header length, this will result in
a copy_from_user(dst, src, negative_val).  While this will just return
-EFAULT on x86, on other architectures this may cause memory corruption.
Additionally, the length field of the sysex_info structure may not be
initialized prior to its use.  Finally, a signed comparison may result
in an unintentionally large loop.

This patch fixes all these issues, as well as some cleanup to prevent
checkpatch.pl from complaining.

Signed-off-by: Dan Rosenberg <drosenberg@vsecurity.com>
Cc: stable@kernel.org
---
 sound/oss/midi_synth.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/oss/midi_synth.c b/sound/oss/midi_synth.c
index 3c09374..3500f80 100644
--- a/sound/oss/midi_synth.c
+++ b/sound/oss/midi_synth.c
@@ -491,16 +491,18 @@ midi_synth_load_patch(int dev, int format, const char __user *addr,
 	if (!prefix_cmd(orig_dev, 0xf0))
 		return 0;
 
+	/* Invalid patch format */
 	if (format != SYSEX_PATCH)
-	{
-/*		  printk("MIDI Error: Invalid patch format (key) 0x%x\n", format);*/
 		  return -EINVAL;
-	}
+
+	/* Patch header too short */
 	if (count < hdr_size)
-	{
-/*		printk("MIDI Error: Patch header too short\n");*/
 		return -EINVAL;
-	}
+
+	/* Offset too high */
+	if (offs > offsetof(struct sysex_info, len) || offs < 0)
+		return -EINVAL;
+
 	count -= hdr_size;
 
 	/*
@@ -510,14 +512,13 @@ midi_synth_load_patch(int dev, int format, const char __user *addr,
 
 	if(copy_from_user(&((char *) &sysex)[offs], &(addr)[offs], hdr_size - offs))
 		return -EFAULT;
- 
- 	if (count < sysex.len)
-	{
-/*		printk(KERN_WARNING "MIDI Warning: Sysex record too short (%d<%d)\n", count, (int) sysex.len);*/
+
+	/* Sysex record too short */
+	if ((unsigned)count < (unsigned)sysex.len)
 		sysex.len = count;
-	}
-  	left = sysex.len;
-  	src_offs = 0;
+
+	left = sysex.len;
+	src_offs = 0;
 
 	for (i = 0; i < left && !signal_pending(current); i++)
 	{
