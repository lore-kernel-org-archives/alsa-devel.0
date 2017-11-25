From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 22/24] ALSA: ctl: replacement for compat
	ELEM_READ/ELEM_WRITE operation for i386 ABI
Date: Sat, 25 Nov 2017 18:20:04 +0900
Message-ID: <20171125092006.24408-23-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8A67A2674DB
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:18 +0100 (CET)
In-Reply-To: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit obsoletes old implementation for compat ELEM_READ/ELEM_WRITE
operation for i386 ABI with a renewal way. Existent implementation for x32
ABI compatibility is removed so that it can be handled by the same way for
the other modern 32 bit ABIs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control_compat.c | 76 +++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 2982423dccd0..430f178aa4d8 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -404,27 +404,11 @@ struct snd_ctl_elem_value32 {
         union {
 		s32 integer[128];
 		unsigned char data[512];
-#ifndef CONFIG_X86_64
 		s64 integer64[64];
-#endif
         } value;
         unsigned char reserved[128];
 };
 
-#ifdef CONFIG_X86_X32
-/* x32 has a different alignment for 64bit values from ia32 */
-struct snd_ctl_elem_value_x32 {
-	struct snd_ctl_elem_id id;
-	unsigned int indirect;	/* bit-field causes misalignment */
-	union {
-		s32 integer[128];
-		unsigned char data[512];
-		s64 integer64[64];
-	} value;
-	unsigned char reserved[128];
-};
-#endif /* CONFIG_X86_X32 */
-
 /* get the value type and count of the control */
 static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
 			int *countp)
@@ -601,20 +585,6 @@ static int snd_ctl_elem_write_user_compat(struct snd_ctl_file *file,
 	return ctl_elem_write_user(file, data32, &data32->value);
 }
 
-#ifdef CONFIG_X86_X32
-static int snd_ctl_elem_read_user_x32(struct snd_ctl_file *ctl_file,
-				      struct snd_ctl_elem_value_x32 __user *data32)
-{
-	return ctl_elem_read_user(ctl_file, data32, &data32->value);
-}
-
-static int snd_ctl_elem_write_user_x32(struct snd_ctl_file *file,
-				       struct snd_ctl_elem_value_x32 __user *data32)
-{
-	return ctl_elem_write_user(file, data32, &data32->value);
-}
-#endif /* CONFIG_X86_X32 */
-
 static int ctl_compat_ioctl_elem_list_32(struct snd_ctl_file *ctl_file,
 					 void *buf)
 {
@@ -647,6 +617,22 @@ static int ctl_compat_ioctl_elem_replace_32(struct snd_ctl_file *ctl_file,
 	return snd_ctl_elem_replace(ctl_file, info);
 }
 
+static int ctl_compat_ioctl_elem_read_32(struct snd_ctl_file *ctl_file,
+					 void *buf)
+{
+	struct snd_ctl_elem_value *value = buf;
+
+	return snd_ctl_elem_read(ctl_file, value);
+}
+
+static int ctl_compat_ioctl_elem_write_32(struct snd_ctl_file *ctl_file,
+					  void *buf)
+{
+	struct snd_ctl_elem_value *value = buf;
+
+	return snd_ctl_elem_write(ctl_file, value);
+}
+
 enum {
 	SNDRV_CTL_IOCTL_ELEM_LIST_32 =
 				_IOWR('U', 0x10, struct snd_ctl_elem_list_32),
@@ -658,10 +644,10 @@ enum {
 				_IOWR('U', 0x17, struct snd_ctl_elem_info_32),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE_32 =
 				_IOWR('U', 0x18, struct snd_ctl_elem_info_32),
-#ifdef CONFIG_X86_X32
-	SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
-	SNDRV_CTL_IOCTL_ELEM_WRITE_X32 = _IOWR('U', 0x13, struct snd_ctl_elem_value_x32),
-#endif /* CONFIG_X86_X32 */
+	SNDRV_CTL_IOCTL_ELEM_READ_I386 =
+				_IOWR('U', 0x12, struct snd_ctl_elem_value_i386),
+	SNDRV_CTL_IOCTL_ELEM_WRITE_I386 =
+				_IOWR('U', 0x13, struct snd_ctl_elem_value_i386),
 };
 
 static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
@@ -704,6 +690,22 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 			serialize_to_elem_info_32,
 			SNDRV_CTL_IOCTL_ELEM_REPLACE,
 		},
+#ifdef CONFIG_X86_64
+		{
+			SNDRV_CTL_IOCTL_ELEM_READ_I386,
+			deserialize_from_elem_value_i386,
+			ctl_compat_ioctl_elem_read_32,
+			serialize_to_elem_value_i386,
+			SNDRV_CTL_IOCTL_ELEM_READ,
+		},
+		{
+			SNDRV_CTL_IOCTL_ELEM_WRITE_I386,
+			deserialize_from_elem_value_i386,
+			ctl_compat_ioctl_elem_write_32,
+			serialize_to_elem_value_i386,
+			SNDRV_CTL_IOCTL_ELEM_WRITE,
+		},
+#endif
 	};
 	struct snd_ctl_file *ctl;
 	void __user *argp = compat_ptr(arg);
@@ -721,12 +723,6 @@ static long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd,
 		return snd_ctl_elem_read_user_compat(ctl, argp);
 	case SNDRV_CTL_IOCTL_ELEM_WRITE32:
 		return snd_ctl_elem_write_user_compat(ctl, argp);
-#ifdef CONFIG_X86_X32
-	case SNDRV_CTL_IOCTL_ELEM_READ_X32:
-		return snd_ctl_elem_read_user_x32(ctl, argp);
-	case SNDRV_CTL_IOCTL_ELEM_WRITE_X32:
-		return snd_ctl_elem_write_user_x32(ctl, argp);
-#endif /* CONFIG_X86_X32 */
 	}
 
 	for (i = 0; i < ARRAY_SIZE(handlers); ++i) {
-- 
2.14.1
