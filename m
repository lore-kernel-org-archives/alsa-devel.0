From: Juergen Kreileder <jk@blackdown.de>
Subject: Re: Any missing patches?
Date: Mon, 20 Mar 2006 21:26:47 +0100
Message-ID: <871wwwq2uw.fsf@blackdown.de>
References: <s5hmzfl9cql.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzfl9cql.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
	20 Mar 2006 19:45:22 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> if someone has patches intended for merging to ALSA tree, please
> submit them ASAP.
>
> I think the current ALSA CVS tree is forming to a relatively good
> shape now, and it's good time to push Linux kernel tree, too.
> Let's be not too late to ride a bus.

Here's a patch which adds support for S24_3LE and byte-swapped S16 and
S32 to softvol.  I've tested S24_3LE and byte-swapped S16 on powerpc
with snd-usb-audio.  All other cases are untested so far.
(Config at http://blog.blackdown.de/static/alsa/USB-Audio.conf)


        Juergen

Signed-off-by: Juergen Kreileder <jk@blackdown.de>

--- o/alsa-lib-1.0.11rc3/src/pcm/pcm_softvol.c	2005-09-02 18:36:40.000000000 +0200
+++ alsa-lib-1.0.11rc3/src/pcm/pcm_softvol.c	2006-03-10 02:46:39.000000000 +0100
@@ -96,10 +96,10 @@ typedef union {
 	int i;
 	short s[2];
 } val_t;
-static inline int MULTI_DIV_int(int a, unsigned short b)
+static inline int MULTI_DIV_int(int a, unsigned short b, int swap)
 {
 	val_t v, x, y;
-	v.i = a;
+	v.i = swap ? bswap_32(a) : a;
 	y.i = 0;
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 	x.i = (unsigned int)v.s[0] * b;
@@ -110,11 +110,14 @@ static inline int MULTI_DIV_int(int a, u
 	y.s[1] = x.s[0];
 	y.i += (int)v.s[0] * b;
 #endif
-	return y.i;
+	return swap ? bswap_32(y.i) : y.i;
 }
 
 /* (16bit x 16bit) >> 16 */
-#define MULTI_DIV_short(src,scale) (((int)(src) * (scale)) >> VOL_SCALE_SHIFT)
+#define MULTI_DIV_short(src, scale, swap)				  \
+(swap									  \
+ ? bswap_16(((short) bswap_16(src) * (scale)) >> VOL_SCALE_SHIFT)   \
+ : (((int) (src) * (scale)) >> VOL_SCALE_SHIFT))
 
 #endif /* DOC_HIDDEN */
 
@@ -125,7 +128,7 @@ static inline int MULTI_DIV_int(int a, u
  */
 
 #ifndef DOC_HIDDEN
-#define CONVERT_AREA(TYPE) do {	\
+#define CONVERT_AREA(TYPE, swap) do {	\
 	unsigned int ch, fr; \
 	TYPE *src, *dst; \
 	for (ch = 0; ch < channels; ch++) { \
@@ -150,15 +153,55 @@ static inline int MULTI_DIV_int(int a, u
 			} \
 		} else { \
 			while (fr--) { \
-				*dst = MULTI_DIV_##TYPE(*src, vol_scale);\
+				*dst = (TYPE) MULTI_DIV_##TYPE(*src, vol_scale, swap); \
 				src += src_step; \
 				dst += dst_step; \
 			} \
 		} \
 	} \
 } while (0)
-	
 
+#define CONVERT_AREA_S24_3LE() do {					\
+	unsigned int ch, fr;						\
+	unsigned char *src, *dst;					\
+	int tmp;							\
+	for (ch = 0; ch < channels; ch++) {				\
+		src_area = &src_areas[ch];				\
+		dst_area = &dst_areas[ch];				\
+		src = snd_pcm_channel_area_addr(src_area, src_offset);	\
+		dst = snd_pcm_channel_area_addr(dst_area, dst_offset);	\
+		src_step = snd_pcm_channel_area_step(src_area);		\
+		dst_step = snd_pcm_channel_area_step(dst_area);		\
+		GET_VOL_SCALE;						\
+		fr = frames;						\
+		if (! vol_scale) {					\
+			while (fr--) {					\
+				dst[0] = dst[1] = dst[2] = 0;		\
+				dst += dst_step;			\
+			}						\
+		} else if (vol_scale == 0xffff) {			\
+			while (fr--) {					\
+				dst[0] = src[0];			\
+				dst[1] = src[1];			\
+				dst[2] = src[2];			\
+				src += dst_step;			\
+				dst += src_step;			\
+			}						\
+		} else {						\
+			while (fr--) {					\
+				tmp = src[0] |				\
+				      (src[1] << 8) |			\
+				      (((signed char *) src)[2] << 16);	\
+				tmp = MULTI_DIV_int(tmp, vol_scale, 0);	\
+				dst[0] = tmp;				\
+				dst[1] = tmp >> 8;			\
+				dst[2] = tmp >> 16;			\
+				src += dst_step;			\
+				dst += src_step;			\
+			}						\
+		}							\
+	}								\
+} while (0)
 		
 #define GET_VOL_SCALE \
 	switch (ch) { \
@@ -204,12 +247,24 @@ static void softvol_convert_stereo_vol(s
 	vol[0] = svol->dB_value[svol->cur_vol[0]];
 	vol[1] = svol->dB_value[svol->cur_vol[1]];
 	vol_c = svol->dB_value[(svol->cur_vol[0] + svol->cur_vol[1]) / 2];
-	if (svol->sformat == SND_PCM_FORMAT_S16) {
+	switch (svol->sformat) {
+	case SND_PCM_FORMAT_S16_LE:
+	case SND_PCM_FORMAT_S16_BE:
 		/* 16bit samples */
-		CONVERT_AREA(short);
-	} else {
+		CONVERT_AREA(short, 
+			     !snd_pcm_format_cpu_endian(svol->sformat));
+		break;
+	case SND_PCM_FORMAT_S32_LE:
+	case SND_PCM_FORMAT_S32_BE:
 		/* 32bit samples */
-		CONVERT_AREA(int);
+		CONVERT_AREA(int,
+			     !snd_pcm_format_cpu_endian(svol->sformat));
+		break;
+	case SND_PCM_FORMAT_S24_3LE:
+		CONVERT_AREA_S24_3LE();
+		break;
+	default:
+		break;
 	}
 }
 
@@ -240,12 +295,24 @@ static void softvol_convert_mono_vol(snd
 	}
 
 	vol_scale = svol->dB_value[svol->cur_vol[0]];
-	if (svol->sformat == SND_PCM_FORMAT_S16) {
+	switch (svol->sformat) {
+	case SND_PCM_FORMAT_S16_LE:
+	case SND_PCM_FORMAT_S16_BE:
 		/* 16bit samples */
-		CONVERT_AREA(short);
-	} else {
+		CONVERT_AREA(short, 
+			     !snd_pcm_format_cpu_endian(svol->sformat));
+		break;
+	case SND_PCM_FORMAT_S32_LE:
+	case SND_PCM_FORMAT_S32_BE:
 		/* 32bit samples */
-		CONVERT_AREA(int);
+		CONVERT_AREA(int,
+			     !snd_pcm_format_cpu_endian(svol->sformat));
+		break;
+	case SND_PCM_FORMAT_S24_3LE:
+		CONVERT_AREA_S24_3LE();
+		break;
+	default:
+		break;
 	}
 }
 
@@ -287,14 +354,25 @@ static int snd_pcm_softvol_close(snd_pcm
 	return 0;
 }
 
-static int snd_pcm_softvol_hw_refine_cprepare(snd_pcm_t *pcm ATTRIBUTE_UNUSED,
+static int snd_pcm_softvol_hw_refine_cprepare(snd_pcm_t *pcm,
 					      snd_pcm_hw_params_t *params)
 {
 	int err;
+	snd_pcm_softvol_t *svol = pcm->private_data;
 	snd_pcm_access_mask_t access_mask = { SND_PCM_ACCBIT_SHM };
 	snd_pcm_format_mask_t format_mask = {
-		{ (1U << SND_PCM_FORMAT_S16) | (1U << SND_PCM_FORMAT_S32) }
+		{
+			(1ULL << SND_PCM_FORMAT_S16_LE) |
+			(1ULL << SND_PCM_FORMAT_S16_BE) |
+			(1ULL << SND_PCM_FORMAT_S32_LE) |
+ 			(1ULL << SND_PCM_FORMAT_S32_BE),
+			(1ULL << (SND_PCM_FORMAT_S24_3LE - 32))
+		}
 	};
+	if (svol->sformat != SND_PCM_FORMAT_UNKNOWN) {
+		snd_pcm_format_mask_none(&format_mask);
+		snd_pcm_format_mask_set(&format_mask, svol->sformat);
+	}
 	err = _snd_pcm_hw_param_set_mask(params, SND_PCM_HW_PARAM_ACCESS,
 					 &access_mask);
 	if (err < 0)
@@ -396,9 +474,13 @@ static int snd_pcm_softvol_hw_params(snd
 					  snd_pcm_generic_hw_params);
 	if (err < 0)
 		return err;
-	if (slave->format != SND_PCM_FORMAT_S16 &&
-	    slave->format != SND_PCM_FORMAT_S32) {
-		SNDERR("softvol supports only S16 or S32");
+	if (slave->format != SND_PCM_FORMAT_S16_LE &&
+	    slave->format != SND_PCM_FORMAT_S16_BE &&
+	    slave->format != SND_PCM_FORMAT_S24_3LE && 
+	    slave->format != SND_PCM_FORMAT_S32_LE &&
+	    slave->format != SND_PCM_FORMAT_S32_BE) {
+		SNDERR("softvol supports only S16_LE, S16_BE, S24_3LE, S32_LE "
+		       " or S32_BE");
 		return -EINVAL;
 	}
 	svol->sformat = slave->format;
@@ -619,8 +701,11 @@ int snd_pcm_softvol_open(snd_pcm_t **pcm
 	int err;
 	assert(pcmp && slave);
 	if (sformat != SND_PCM_FORMAT_UNKNOWN &&
-	    sformat != SND_PCM_FORMAT_S16 &&
-	    sformat != SND_PCM_FORMAT_S32)
+	    sformat != SND_PCM_FORMAT_S16_LE &&
+	    sformat != SND_PCM_FORMAT_S16_BE &&
+	    sformat != SND_PCM_FORMAT_S24_3LE && 
+	    sformat != SND_PCM_FORMAT_S32_LE &&
+	    sformat != SND_PCM_FORMAT_S32_BE)
 		return -EINVAL;
 	svol = calloc(1, sizeof(*svol));
 	if (! svol)
@@ -808,9 +893,13 @@ int _snd_pcm_softvol_open(snd_pcm_t **pc
 	if (err < 0)
 		return err;
 	if (sformat != SND_PCM_FORMAT_UNKNOWN &&
-	    sformat != SND_PCM_FORMAT_S16 &&
-	    sformat != SND_PCM_FORMAT_S32) {
-		SNDERR("only S16 or S32 format is supported");
+	    sformat != SND_PCM_FORMAT_S16_LE &&
+	    sformat != SND_PCM_FORMAT_S16_BE &&
+	    sformat != SND_PCM_FORMAT_S24_3LE && 
+	    sformat != SND_PCM_FORMAT_S32_LE &&
+	    sformat != SND_PCM_FORMAT_S32_BE) {
+		SNDERR("only S16_LE, S16_BE, S24_3LE, S32_LE or S32_BE format "
+		       "is supported");
 		snd_config_delete(sconf);
 		return -EINVAL;
 	}
=

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
