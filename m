From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: snd_pcm_hardware_t NOT pre-initialized
Date: Fri, 6 Sep 2002 09:28:01 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020906162801.82599.qmail@web11504.mail.yahoo.com>
References: <20020829205716.2839.qmail@web11502.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1322339782-1031329681=:81493"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11504.mail.yahoo.com (web11504.mail.yahoo.com [216.136.172.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA16857
	for <alsa-devel@alsa-project.org>; Fri, 6 Sep 2002 18:28:14 +0200
In-Reply-To: <20020829205716.2839.qmail@web11502.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-1322339782-1031329681=:81493
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

snd_pcm_hardware_t is NOT pre-initialized, and drivers are responsible to
define ALL fields necessary. This is too bad, because it essentially means that
a new constraint (i.e. period_size_min + period_size_max) will need to be
supported by all drivers.

I have tested successfully such a new constraint (patch in attachment), and
hope that you'll incorporate it in the cvs anyway.

Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
--0-1322339782-1031329681=:81493
Content-Type: text/plain; name="alsa_rc3.diff"
Content-Description: alsa_rc3.diff
Content-Disposition: inline; filename="alsa_rc3.diff"

--- alsa-kernel/include_orig/asound.h	Wed Jun 26 14:07:13 2002
+++ alsa-kernel/include/asound.h	Thu Sep  5 12:08:02 2002
@@ -190,8 +191,15 @@
 	SNDRV_PCM_FORMAT_IMA_ADPCM,
 	SNDRV_PCM_FORMAT_MPEG,
 	SNDRV_PCM_FORMAT_GSM,
-	SNDRV_PCM_FORMAT_SPECIAL = 31,
-	SNDRV_PCM_FORMAT_S24_3LE = 32,	/* in three bytes */
+	SNDRV_PCM_FORMAT_G723_5_3KBPS,
+	SNDRV_PCM_FORMAT_G723_6_3KBPS,
+	SNDRV_PCM_FORMAT_G726_16KBPS,
+	SNDRV_PCM_FORMAT_G726_24KBPS,
+	SNDRV_PCM_FORMAT_G726_32KBPS,
+	SNDRV_PCM_FORMAT_G726_40KBPS,
+	SNDRV_PCM_FORMAT_G729,
+	SNDRV_PCM_FORMAT_SPECIAL = 47,
+	SNDRV_PCM_FORMAT_S24_3LE = 48,	/* in three bytes */
 	SNDRV_PCM_FORMAT_S24_3BE,	/* in three bytes */
 	SNDRV_PCM_FORMAT_U24_3LE,	/* in three bytes */
 	SNDRV_PCM_FORMAT_U24_3BE,	/* in three bytes */
--- alsa-kernel/include_orig/pcm.h	Tue Aug  6 03:28:27 2002
+++ alsa-kernel/include/pcm.h	Wed Sep  4 13:32:19 2002
@@ -75,6 +75,8 @@
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
 	size_t buffer_bytes_max;	/* max buffer size */
+	size_t period_size_min;		/* min size size (in samples) */
+	size_t period_size_max;		/* max size size (in samples) */
 	size_t period_bytes_min;	/* min period size */
 	size_t period_bytes_max;	/* max period size */
 	unsigned int periods_min;	/* min # of periods */
@@ -176,6 +178,13 @@
 #define SNDRV_PCM_FMTBIT_IMA_ADPCM	(1ULL << SNDRV_PCM_FORMAT_IMA_ADPCM)
 #define SNDRV_PCM_FMTBIT_MPEG		(1ULL << SNDRV_PCM_FORMAT_MPEG)
 #define SNDRV_PCM_FMTBIT_GSM		(1ULL << SNDRV_PCM_FORMAT_GSM)
+#define SNDRV_PCM_FMTBIT_G723_5_3KBPS	(1ULL << SNDRV_PCM_FORMAT_G723_5_3KBPS)
+#define SNDRV_PCM_FMTBIT_G723_6_3KBPS	(1ULL << SNDRV_PCM_FORMAT_G723_5_3KBPS)
+#define SNDRV_PCM_FMTBIT_G726_16KBPS	(1ULL << SNDRV_PCM_FORMAT_G726_16KBPS)
+#define SNDRV_PCM_FMTBIT_G726_24KBPS	(1ULL << SNDRV_PCM_FORMAT_G726_24KBPS)
+#define SNDRV_PCM_FMTBIT_G726_32KBPS	(1ULL << SNDRV_PCM_FORMAT_G726_32KBPS)
+#define SNDRV_PCM_FMTBIT_G726_40KBPS	(1ULL << SNDRV_PCM_FORMAT_G726_40KBPS)
+#define SNDRV_PCM_FMTBIT_G729		(1ULL << SNDRV_PCM_FORMAT_G729)
 #define SNDRV_PCM_FMTBIT_SPECIAL	(1ULL << SNDRV_PCM_FORMAT_SPECIAL)
 #define SNDRV_PCM_FMTBIT_S24_3LE	(1ULL << SNDRV_PCM_FORMAT_S24_3LE)
 #define SNDRV_PCM_FMTBIT_U24_3LE	(1ULL << SNDRV_PCM_FORMAT_U24_3LE)
--- alsa-kernel/core_orig/pcm.c	Tue Aug 13 12:13:34 2002
+++ alsa-kernel/core/pcm.c	Thu Aug 22 13:35:40 2002
@@ -183,6 +183,13 @@
 	FORMAT(IMA_ADPCM),
 	FORMAT(MPEG),
 	FORMAT(GSM),
+	FORMAT(G723_5_3KBPS),
+	FORMAT(G723_6_3KBPS),
+	FORMAT(G726_16KBPS),
+	FORMAT(G726_24KBPS),
+	FORMAT(G726_32KBPS),
+	FORMAT(G726_40KBPS),
+	FORMAT(G729),
 	FORMAT(SPECIAL),
 	FORMAT(S24_3LE),
 	FORMAT(S24_3BE),
--- alsa-kernel/core_orig/pcm_misc.c	Mon Aug 12 04:43:45 2002
+++ alsa-kernel/core/pcm_misc.c	Fri Aug 23 08:50:20 2002
@@ -188,6 +188,20 @@
 		return 8;
 	case SNDRV_PCM_FORMAT_IMA_ADPCM:
 		return 4;
+	case SNDRV_PCM_FORMAT_G723_5_3KBPS:
+		return 160;
+	case SNDRV_PCM_FORMAT_G723_6_3KBPS:
+		return 192;
+	case SNDRV_PCM_FORMAT_G726_16KBPS:
+		return 2;
+	case SNDRV_PCM_FORMAT_G726_24KBPS:
+		return 3;
+	case SNDRV_PCM_FORMAT_G726_32KBPS:
+		return 4;
+	case SNDRV_PCM_FORMAT_G726_40KBPS:
+		return 5;
+	case SNDRV_PCM_FORMAT_G729:
+		return 80;
 	default:
 		return -EINVAL;
 	}
@@ -238,6 +252,20 @@
 		return 8;
 	case SNDRV_PCM_FORMAT_IMA_ADPCM:
 		return 4;
+	case SNDRV_PCM_FORMAT_G723_5_3KBPS:
+		return 160;
+	case SNDRV_PCM_FORMAT_G723_6_3KBPS:
+		return 192;
+	case SNDRV_PCM_FORMAT_G726_16KBPS:
+		return 2;
+	case SNDRV_PCM_FORMAT_G726_24KBPS:
+		return 3;
+	case SNDRV_PCM_FORMAT_G726_32KBPS:
+		return 4;
+	case SNDRV_PCM_FORMAT_G726_40KBPS:
+		return 5;
+	case SNDRV_PCM_FORMAT_G729:
+		return 80;
 	default:
 		return -EINVAL;
 	}
@@ -291,6 +319,34 @@
 		if (samples & 1)
 			return -EINVAL;
 		return samples / 2;
+	case SNDRV_PCM_FORMAT_G723_5_3KBPS:
+		if (samples % 240)
+			return -EINVAL;
+		return (samples / 240) * 160;
+	case SNDRV_PCM_FORMAT_G723_6_3KBPS:
+		if (samples % 240)
+			return -EINVAL;
+		return (samples / 240) * 192;
+	case SNDRV_PCM_FORMAT_G726_16KBPS:
+		if (samples & 3)
+			return -EINVAL;
+		return samples / 4;
+	case SNDRV_PCM_FORMAT_G726_24KBPS:
+		if (samples & 7)
+			return -EINVAL;
+		return (samples * 3) / 8;
+	case SNDRV_PCM_FORMAT_G726_32KBPS:
+		if (samples & 1)
+			return -EINVAL;
+		return samples / 2;
+	case SNDRV_PCM_FORMAT_G726_40KBPS:
+		if (samples & 7)
+			return -EINVAL;
+		return (samples * 5) / 8;
+	case SNDRV_PCM_FORMAT_G729:
+		if (samples % 80)
+			return -EINVAL;
+		return samples / 8;
 	default:
 		return -EINVAL;
 	}
@@ -428,6 +484,13 @@
 	case SNDRV_PCM_FORMAT_IMA_ADPCM:	/* special case */
 	case SNDRV_PCM_FORMAT_MPEG:
 	case SNDRV_PCM_FORMAT_GSM:
+	case SNDRV_PCM_FORMAT_G723_5_3KBPS:
+	case SNDRV_PCM_FORMAT_G723_6_3KBPS:
+	case SNDRV_PCM_FORMAT_G726_16KBPS:
+	case SNDRV_PCM_FORMAT_G726_24KBPS:
+	case SNDRV_PCM_FORMAT_G726_32KBPS:
+	case SNDRV_PCM_FORMAT_G726_40KBPS:
+	case SNDRV_PCM_FORMAT_G729:
 	case SNDRV_PCM_FORMAT_SPECIAL:
 		return 0;
 	default:
@@ -456,12 +519,39 @@
 	if (samples == 0)
 		return 0;
 	switch (snd_pcm_format_width(format)) {
+	case 2: {
+		u_int8_t silence = snd_pcm_format_silence_64(format);
+		unsigned int samples1;
+		if (samples & 3)
+			return -EINVAL;
+		samples1 = samples / 4;
+		memset(data, silence, samples1);
+		break;
+	}
+	case 3: {
+		u_int8_t silence = snd_pcm_format_silence_64(format);
+		unsigned int samples1;
+		if (samples & 7)
+			return -EINVAL;
+		samples1 = (samples * 3) / 8;
+		memset(data, silence, samples1);
+		break;
+	}
 	case 4: {
 		u_int8_t silence = snd_pcm_format_silence_64(format);
 		unsigned int samples1;
-		if (samples % 2 != 0)
+		if (samples & 1)
 			return -EINVAL;
 		samples1 = samples / 2;
+		memset(data, silence, samples1);
+		break;
+	}
+	case 5: {
+		u_int8_t silence = snd_pcm_format_silence_64(format);
+		unsigned int samples1;
+		if (samples & 7)
+			return -EINVAL;
+		samples1 = (samples * 5) / 8;
 		memset(data, silence, samples1);
 		break;
 	}
--- alsa-kernel/core_orig/pcm_native.c	Tue Aug 13 12:13:34 2002
+++ alsa-kernel/core/pcm_native.c	Wed Sep  4 13:36:41 2002
@@ -1628,6 +1628,10 @@
 					   hw->rate_min, hw->rate_max);
 	snd_assert(err >= 0, return -EINVAL);
 
+	err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   hw->period_size_min, hw->period_size_max);
+	snd_assert(err >= 0, return -EINVAL);
+
 	err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 					   hw->period_bytes_min, hw->period_bytes_max);
 	snd_assert(err >= 0, return -EINVAL);

--0-1322339782-1031329681=:81493--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
