From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 1/2] Sync include/sound/asound.h with
	3.17-rc1 kernel
Date: Mon, 11 Aug 2014 11:57:15 +0200
Message-ID: <1407751036-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 96E9926513A
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 11:57:21 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7A86AACFF
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 09:57:21 +0000 (UTC)
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asound.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 519452466317..32168f7ffce3 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -93,9 +93,12 @@ enum {
 	SNDRV_HWDEP_IFACE_SB_RC,	/* SB Extigy/Audigy2NX remote control */
 	SNDRV_HWDEP_IFACE_HDA,		/* HD-audio */
 	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
+	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
+	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
+	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_USB_STREAM
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_FW_BEBOB
 };
 
 struct snd_hwdep_info {
@@ -214,8 +217,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_G723_24_1B	((__force snd_pcm_format_t) 45) /* 1 sample in 1 byte */
 #define	SNDRV_PCM_FORMAT_G723_40	((__force snd_pcm_format_t) 46) /* 8 Samples in 5 bytes */
 #define	SNDRV_PCM_FORMAT_G723_40_1B	((__force snd_pcm_format_t) 47) /* 1 sample in 1 byte */
-#define SNDRV_PCM_FORMAT_DSD_U8		((__force snd_pcm_format_t) 48) /* 8 1-bit samples in 1 byte */
-#define SNDRV_PCM_FORMAT_DSD_U16_LE	((__force snd_pcm_format_t) 49) /* 16 1-bit samples in 2 bytes */
+#define	SNDRV_PCM_FORMAT_DSD_U8		((__force snd_pcm_format_t) 48) /* DSD, 1-byte samples DSD (x8) */
+#define	SNDRV_PCM_FORMAT_DSD_U16_LE	((__force snd_pcm_format_t) 49) /* DSD, 2-byte samples DSD (x16), little endian */
 #define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U16_LE
 
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -461,7 +464,7 @@ struct snd_xfern {
 enum {
 	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
 	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
-	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,	/* monotonic_raw (no NTP) */
+	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,    /* monotonic_raw (no NTP) */
 	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
 };
 
@@ -820,6 +823,8 @@ typedef int __bitwise snd_ctl_elem_iface_t;
 #define SNDRV_CTL_POWER_D3hot		(SNDRV_CTL_POWER_D3|0x0000)	/* Off, with power */
 #define SNDRV_CTL_POWER_D3cold		(SNDRV_CTL_POWER_D3|0x0001)	/* Off, without power */
 
+#define SNDRV_CTL_ELEM_ID_NAME_MAXLEN	44
+
 struct snd_ctl_elem_id {
 	unsigned int numid;		/* numeric identifier, zero = invalid */
 	snd_ctl_elem_iface_t iface;	/* interface identifier */
-- 
2.0.4
