From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] alsa-lib: pcm: Drop
	snd_pcm_linear_{get|put}32_index()
Date: Tue, 22 Jul 2014 12:22:22 +0200
Message-ID: <1406024542-2284-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EFAD42654E4
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 12:22:22 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A703DAAC3
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 10:22:22 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

These are identical with snd_pcm_linear_{get|put}_index().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_lfloat.c |  4 ++--
 src/pcm/pcm_linear.c | 44 ++++----------------------------------------
 src/pcm/pcm_plugin.h |  4 ----
 src/pcm/pcm_route.c  |  4 ++--
 4 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/src/pcm/pcm_lfloat.c b/src/pcm/pcm_lfloat.c
index 324282f0b7fc..2f3e578fc503 100644
--- a/src/pcm/pcm_lfloat.c
+++ b/src/pcm/pcm_lfloat.c
@@ -286,11 +286,11 @@ static int snd_pcm_lfloat_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 		err = INTERNAL(snd_pcm_hw_params_get_format)(params, &dst_format);
 	}
 	if (snd_pcm_format_linear(src_format)) {
-		lfloat->int32_idx = snd_pcm_linear_get32_index(src_format, SND_PCM_FORMAT_S32);
+		lfloat->int32_idx = snd_pcm_linear_get_index(src_format, SND_PCM_FORMAT_S32);
 		lfloat->float32_idx = snd_pcm_lfloat_put_s32_index(dst_format);
 		lfloat->func = snd_pcm_lfloat_convert_integer_float;
 	} else {
-		lfloat->int32_idx = snd_pcm_linear_put32_index(SND_PCM_FORMAT_S32, dst_format);
+		lfloat->int32_idx = snd_pcm_linear_put_index(SND_PCM_FORMAT_S32, dst_format);
 		lfloat->float32_idx = snd_pcm_lfloat_get_s32_index(src_format);
 		lfloat->func = snd_pcm_lfloat_convert_float_integer;
 	}
diff --git a/src/pcm/pcm_linear.c b/src/pcm/pcm_linear.c
index 3d5bbb8a3688..9a92abd04fb8 100644
--- a/src/pcm/pcm_linear.c
+++ b/src/pcm/pcm_linear.c
@@ -107,11 +107,6 @@ int snd_pcm_linear_get_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
 	}
 }
 
-int snd_pcm_linear_get32_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format)
-{
-	return snd_pcm_linear_get_index(src_format, dst_format);
-}
-
 int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format)
 {
 	int sign, width, pwidth, endian;
@@ -143,37 +138,6 @@ int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
 	}
 }
 
-int snd_pcm_linear_put32_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format)
-{
-	int sign, width, pwidth, endian;
-	sign = (snd_pcm_format_signed(src_format) != 
-		snd_pcm_format_signed(dst_format));
-#ifdef SND_LITTLE_ENDIAN
-	endian = snd_pcm_format_big_endian(dst_format);
-#else
-	endian = snd_pcm_format_little_endian(dst_format);
-#endif
-	if (endian < 0)
-		endian = 0;
-	pwidth = snd_pcm_format_physical_width(dst_format);
-	width = snd_pcm_format_width(dst_format);
-	if (pwidth == 24) {
-		switch (width) {
-		case 24:
-			width = 0; break;
-		case 20:
-			width = 1; break;
-		case 18:
-		default:
-			width = 2; break;
-		}
-		return width * 4 + endian * 2 + sign + 16;
-	} else {
-		width = width / 8 - 1;
-		return width * 4 + endian * 2 + sign;
-	}
-}
-
 void snd_pcm_linear_convert(const snd_pcm_channel_area_t *dst_areas, snd_pcm_uframes_t dst_offset,
 			    const snd_pcm_channel_area_t *src_areas, snd_pcm_uframes_t src_offset,
 			    unsigned int channels, snd_pcm_uframes_t frames,
@@ -342,11 +306,11 @@ static int snd_pcm_linear_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 			      snd_pcm_format_physical_width(linear->sformat) == 24);
 	if (linear->use_getput) {
 		if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
-			linear->get_idx = snd_pcm_linear_get32_index(format, SND_PCM_FORMAT_S32);
-			linear->put_idx = snd_pcm_linear_put32_index(SND_PCM_FORMAT_S32, linear->sformat);
+			linear->get_idx = snd_pcm_linear_get_index(format, SND_PCM_FORMAT_S32);
+			linear->put_idx = snd_pcm_linear_put_index(SND_PCM_FORMAT_S32, linear->sformat);
 		} else {
-			linear->get_idx = snd_pcm_linear_get32_index(linear->sformat, SND_PCM_FORMAT_S32);
-			linear->put_idx = snd_pcm_linear_put32_index(SND_PCM_FORMAT_S32, format);
+			linear->get_idx = snd_pcm_linear_get_index(linear->sformat, SND_PCM_FORMAT_S32);
+			linear->put_idx = snd_pcm_linear_put_index(SND_PCM_FORMAT_S32, format);
 		}
 	} else {
 		if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
diff --git a/src/pcm/pcm_plugin.h b/src/pcm/pcm_plugin.h
index 19e82c3e7321..b0a3e1869ea1 100644
--- a/src/pcm/pcm_plugin.h
+++ b/src/pcm/pcm_plugin.h
@@ -86,8 +86,6 @@ snd_pcm_sframes_t snd_pcm_plugin_undo_write_generic
 /* make local functions really local */
 #define snd_pcm_linear_get_index	snd1_pcm_linear_get_index
 #define snd_pcm_linear_put_index	snd1_pcm_linear_put_index
-#define snd_pcm_linear_get32_index	snd1_pcm_linear_get32_index
-#define snd_pcm_linear_put32_index	snd1_pcm_linear_put32_index
 #define snd_pcm_linear_convert_index	snd1_pcm_linear_convert_index
 #define snd_pcm_linear_convert	snd1_pcm_linear_convert
 #define snd_pcm_linear_getput	snd1_pcm_linear_getput
@@ -100,8 +98,6 @@ snd_pcm_sframes_t snd_pcm_plugin_undo_write_generic
 
 int snd_pcm_linear_get_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format);
 int snd_pcm_linear_put_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format);
-int snd_pcm_linear_get32_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format);
-int snd_pcm_linear_put32_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format);
 int snd_pcm_linear_convert_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_format);
 
 void snd_pcm_linear_convert(const snd_pcm_channel_area_t *dst_areas, snd_pcm_uframes_t dst_offset,
diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 36a74ba661a9..b55a0736f447 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -617,8 +617,8 @@ static int snd_pcm_route_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	route->params.use_getput =
 		(snd_pcm_format_physical_width(src_format) + 7) / 3 == 3 ||
 		(snd_pcm_format_physical_width(dst_format) + 7) / 3 == 3;
-	route->params.get_idx = snd_pcm_linear_get32_index(src_format, SND_PCM_FORMAT_S32);
-	route->params.put_idx = snd_pcm_linear_put32_index(SND_PCM_FORMAT_S32, dst_format);
+	route->params.get_idx = snd_pcm_linear_get_index(src_format, SND_PCM_FORMAT_S32);
+	route->params.put_idx = snd_pcm_linear_put_index(SND_PCM_FORMAT_S32, dst_format);
 	route->params.conv_idx = snd_pcm_linear_convert_index(src_format, dst_format);
 	route->params.src_size = snd_pcm_format_width(src_format) / 8;
 	route->params.dst_sfmt = dst_format;
-- 
2.0.1
