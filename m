From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 1/3] ALSA: pcm: add IEC958 channel status update
Date: Wed, 2 Dec 2015 15:22:04 +0100
Message-ID: <1449066126-19431-2-git-send-email-moise.gergaud@st.com>
References: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D822B261A5A
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 15:22:23 +0100 (CET)
In-Reply-To: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, rmk+kernel@arm.linux.org.uk
Cc: Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Add a helper to update only the IEC958 channel status sampling freq and
word length parameters from an ALSA snd_pcm_runtime structure, taking
account of the sample rate and sample size.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/pcm_iec958.h | 19 ++++++++++-
 sound/core/pcm_iec958.c    | 78 +++++++++++++++++++++++++++++++---------------
 2 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
index 0eed397..0c84c69 100644
--- a/include/sound/pcm_iec958.h
+++ b/include/sound/pcm_iec958.h
@@ -3,7 +3,24 @@
 
 #include <linux/types.h>
 
+#ifdef CONFIG_SND_PCM_IEC958
 int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
-	size_t len);
+				   size_t len);
+
+int snd_pcm_update_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
+				   size_t len);
+#else
+int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
+				   size_t len)
+{
+	return len;
+}
+
+int snd_pcm_update_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
+				   size_t len)
+{
+	return len;
+}
+#endif
 
 #endif
diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
index 36b2d7a..abe3967 100644
--- a/sound/core/pcm_iec958.c
+++ b/sound/core/pcm_iec958.c
@@ -11,67 +11,72 @@
 #include <sound/pcm.h>
 #include <sound/pcm_iec958.h>
 
-/**
- * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
+/*
+ * snd_pcm_update_iec958_consumer - update consumer format IEC958 channel status
  * @runtime: pcm runtime structure with ->rate filled in
  * @cs: channel status buffer, at least four bytes
  * @len: length of channel status buffer
  *
- * Create the consumer format channel status data in @cs of maximum size
- * @len corresponding to the parameters of the PCM runtime @runtime.
- *
- * Drivers may wish to tweak the contents of the buffer after creation.
+ * Update sampling frequency and word length parameters of the consumer format
+ * channel status data in @cs of maximum size @len.
+ * Values correspond to the rate and format parameters of the PCM runtime
+ * @runtime.
  *
  * Returns: length of buffer, or negative error code if something failed.
  */
-int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
-	size_t len)
+int snd_pcm_update_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
+				   size_t len)
 {
-	unsigned int fs, ws;
-
 	if (len < 4)
 		return -EINVAL;
 
+	cs[3] &= ~IEC958_AES3_CON_FS;
+
 	switch (runtime->rate) {
+	case 22050:
+		cs[3] |= IEC958_AES3_CON_FS_22050;
+		break;
 	case 32000:
-		fs = IEC958_AES3_CON_FS_32000;
+		cs[3] |= IEC958_AES3_CON_FS_32000;
 		break;
 	case 44100:
-		fs = IEC958_AES3_CON_FS_44100;
+		cs[3] |= IEC958_AES3_CON_FS_44100;
 		break;
 	case 48000:
-		fs = IEC958_AES3_CON_FS_48000;
+		cs[3] |= IEC958_AES3_CON_FS_48000;
 		break;
 	case 88200:
-		fs = IEC958_AES3_CON_FS_88200;
+		cs[3] |= IEC958_AES3_CON_FS_88200;
 		break;
 	case 96000:
-		fs = IEC958_AES3_CON_FS_96000;
+		cs[3] |= IEC958_AES3_CON_FS_96000;
 		break;
 	case 176400:
-		fs = IEC958_AES3_CON_FS_176400;
+		cs[3] |= IEC958_AES3_CON_FS_176400;
 		break;
 	case 192000:
-		fs = IEC958_AES3_CON_FS_192000;
+		cs[3] |= IEC958_AES3_CON_FS_192000;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	if (len > 4) {
+		cs[4] &= ~IEC958_AES4_CON_WORDLEN;
+
 		switch (snd_pcm_format_width(runtime->format)) {
 		case 16:
-			ws = IEC958_AES4_CON_WORDLEN_20_16;
+			cs[4] |= IEC958_AES4_CON_WORDLEN_20_16;
 			break;
 		case 18:
-			ws = IEC958_AES4_CON_WORDLEN_22_18;
+			cs[4] |= IEC958_AES4_CON_WORDLEN_22_18;
 			break;
 		case 20:
-			ws = IEC958_AES4_CON_WORDLEN_20_16 |
+			cs[4] |= IEC958_AES4_CON_WORDLEN_20_16 |
 			     IEC958_AES4_CON_MAX_WORDLEN_24;
 			break;
 		case 24:
-			ws = IEC958_AES4_CON_WORDLEN_24_20 |
+			cs[4] |= IEC958_AES4_CON_WORDLEN_24_20 |
 			     IEC958_AES4_CON_MAX_WORDLEN_24;
 			break;
 
@@ -80,15 +85,38 @@ int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
 		}
 	}
 
+	return len;
+}
+EXPORT_SYMBOL(snd_pcm_update_iec958_consumer);
+
+/**
+ * snd_pcm_create_iec958_consumer - create consumer format IEC958 channel status
+ * @runtime: pcm runtime structure with ->rate filled in
+ * @cs: channel status buffer, at least four bytes
+ * @len: length of channel status buffer
+ *
+ * Create the consumer format channel status data in @cs of maximum size
+ * @len corresponding to the parameters of the PCM runtime @runtime.
+ *
+ * Drivers may wish to tweak the contents of the buffer after creation.
+ *
+ * Returns: length of buffer, or negative error code if something failed.
+ */
+int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
+				   size_t len)
+{
+	int ret;
+
 	memset(cs, 0, len);
 
+	ret = snd_pcm_update_iec958_consumer(runtime, cs, len);
+	if (ret < 0)
+		return ret;
+
 	cs[0] = IEC958_AES0_CON_NOT_COPYRIGHT | IEC958_AES0_CON_EMPHASIS_NONE;
 	cs[1] = IEC958_AES1_CON_GENERAL;
 	cs[2] = IEC958_AES2_CON_SOURCE_UNSPEC | IEC958_AES2_CON_CHANNEL_UNSPEC;
-	cs[3] = IEC958_AES3_CON_CLOCK_1000PPM | fs;
-
-	if (len > 4)
-		cs[4] = ws;
+	cs[3] |= IEC958_AES3_CON_CLOCK_1000PPM;
 
 	return len;
 }
-- 
1.9.1
