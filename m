From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: hda/ca0132 - fix possible NULL pointer use
Date: Wed, 11 Jan 2017 14:39:44 +0100
Message-ID: <20170111134013.3798733-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

gcc-7 caught what it considers a NULL pointer dereference:

sound/pci/hda/patch_ca0132.c: In function 'dspio_scp.constprop':
sound/pci/hda/patch_ca0132.c:1487:4: error: argument 1 null where non-null expected [-Werror=nonnull]

This is plausible from looking at the function, as we compare 'reply'
to NULL earlier in it. I have not tried to analyze if there are constraints
that make it impossible to hit the bug, but adding another NULL check in
the end kills the warning and makes the function more robust.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/hda/patch_ca0132.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index bd7c29f8ab1e..07a9deb17477 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1482,6 +1482,9 @@ static int dspio_scp(struct hda_codec *codec,
 		} else if (ret_size != reply_data_size) {
 			codec_dbg(codec, "RetLen and HdrLen .NE.\n");
 			return -EINVAL;
+		} else if (!reply) {
+			codec_dbg(codec, "NULL reply\n");
+			return -EINVAL;
 		} else {
 			*reply_len = ret_size*sizeof(unsigned int);
 			memcpy(reply, scp_reply.data, *reply_len);
-- 
2.9.0
