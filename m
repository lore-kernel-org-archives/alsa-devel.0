From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH] Conversion from 16-bit internal format to
	24-bit formats
Date: Fri, 13 Aug 2010 13:32:02 +0100
Message-ID: <1281702722-3921-1-git-send-email-mark@pogo.org.uk>
References: <alpine.LNX.2.01.1008131319550.31084@fgnk.ybpnyqbznva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 9549B2454C
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 14:32:02 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.01.1008131319550.31084@fgnk.ybpnyqbznva>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

---
 src/pcm/pcm_linear.c |   21 ++++++++++++++++++---
 src/pcm/plugin_ops.h |   27 ++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_linear.c b/src/pcm/pcm_linear.c
index 12e2e7f..e85dfaa 100644
--- a/src/pcm/pcm_linear.c
+++ b/src/pcm/pcm_linear.c
@@ -114,10 +114,9 @@ int snd_pcm_linear_get32_index(snd_pcm_format_t src_format, snd_pcm_format_t dst
 
 int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format)
 {
-	int sign, width, endian;
+	int sign, width, pwidth, endian;
 	sign = (snd_pcm_format_signed(src_format) != 
 		snd_pcm_format_signed(dst_format));
-	width = snd_pcm_format_width(dst_format) / 8 - 1;
 #ifdef SND_LITTLE_ENDIAN
 	endian = snd_pcm_format_big_endian(dst_format);
 #else
@@ -125,7 +124,23 @@ int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
 #endif
 	if (endian < 0)
 		endian = 0;
-	return width * 4 + endian * 2 + sign;
+	pwidth = snd_pcm_format_physical_width(dst_format);
+	width = snd_pcm_format_width(dst_format);
+	if (pwidth == 24) {
+		switch (width) {
+		case 24:
+			width = 0; break;
+		case 20:
+			width = 1; break;
+		case 18:
+		default:
+			width = 2; break;
+		}
+		return width * 4 + endian * 2 + sign + 16;
+	} else {
+		width = width / 8 - 1;
+		return width * 4 + endian * 2 + sign;
+	}
 }
 
 int snd_pcm_linear_put32_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format)
diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
index 04220d6..21535c9 100644
--- a/src/pcm/plugin_ops.h
+++ b/src/pcm/plugin_ops.h
@@ -407,7 +407,7 @@ get16_123_B2_18: sample = (_get_triple_s(src) >> 2) ^ 0x8000; goto GET16_END;
 
 #ifdef PUT16_LABELS
 /* dst_wid dst_endswap sign_toggle */
-static void *const put16_labels[4 * 2 * 2] = {
+static void *const put16_labels[4 * 2 * 2 + 4 * 3] = {
 	&&put16_12_1,		 /* 16h ->  8h */
 	&&put16_12_9,		 /* 16h ^>  8h */
 	&&put16_12_1,		 /* 16h ->  8s */
@@ -424,6 +424,19 @@ static void *const put16_labels[4 * 2 * 2] = {
 	&&put16_12_9200,	 /* 16h ^> 32h */
 	&&put16_12_0021,	 /* 16h -> 32s */
 	&&put16_12_0029,	 /* 16h ^> 32s */
+	/* 3bytes format */
+	&&put16_12_120,		 /* 16h -> 24h */
+	&&put16_12_920,		 /* 16h ^> 24h */
+	&&put16_12_021,		 /* 16h -> 24s */
+	&&put16_12_029,		 /* 16h ^> 24s */
+	&&put16_12_120_20,	 /* 16h -> 20h */
+	&&put16_12_920_20,	 /* 16h ^> 20h */
+	&&put16_12_021_20,	 /* 16h -> 20s */
+	&&put16_12_029_20,	 /* 16h ^> 20s */
+	&&put16_12_120_18,	 /* 16h -> 18h */
+	&&put16_12_920_18,	 /* 16h ^> 18h */
+	&&put16_12_021_18,	 /* 16h -> 18s */
+	&&put16_12_029_18,	 /* 16h ^> 18s */
 };
 #endif
 
@@ -443,6 +456,18 @@ put16_12_1200: as_u32(dst) = (u_int32_t)sample << 16; goto PUT16_END;
 put16_12_9200: as_u32(dst) = (u_int32_t)(sample ^ 0x8000) << 16; goto PUT16_END;
 put16_12_0021: as_u32(dst) = (u_int32_t)bswap_16(sample); goto PUT16_END;
 put16_12_0029: as_u32(dst) = (u_int32_t)bswap_16(sample) ^ 0x80; goto PUT16_END;
+put16_12_120: _put_triple(dst, (u_int32_t)sample << 8); goto PUT16_END;
+put16_12_920: _put_triple(dst, (u_int32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
+put16_12_021: _put_triple_s(dst, (u_int32_t)sample << 8); goto PUT16_END;
+put16_12_029: _put_triple_s(dst, (u_int32_t)(sample ^ 0x8000) << 8); goto PUT16_END;
+put16_12_120_20: _put_triple(dst, (u_int32_t)sample << 4); goto PUT16_END;
+put16_12_920_20: _put_triple(dst, (u_int32_t)(sample ^ 0x8000) << 4); goto PUT16_END;
+put16_12_021_20: _put_triple_s(dst, (u_int32_t)sample << 4); goto PUT16_END;
+put16_12_029_20: _put_triple_s(dst, (u_int32_t)(sample ^ 0x8000) << 4); goto PUT16_END;
+put16_12_120_18: _put_triple(dst, (u_int32_t)sample << 2); goto PUT16_END;
+put16_12_920_18: _put_triple(dst, (u_int32_t)(sample ^ 0x8000) << 2); goto PUT16_END;
+put16_12_021_18: _put_triple_s(dst, (u_int32_t)sample << 2); goto PUT16_END;
+put16_12_029_18: _put_triple_s(dst, (u_int32_t)(sample ^ 0x8000) << 2); goto PUT16_END;
 }
 #endif
 
-- 
1.7.1
