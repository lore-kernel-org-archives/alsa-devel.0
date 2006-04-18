From: Maximilian Rehkopf <otakon@gmx.net>
Subject: [PATCH] ice1712: Improve PCM volume gradient for aureon cards
Date: Tue, 18 Apr 2006 23:18:53 +0200
Message-ID: <444557BD.6000900@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010003000501010603050202"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E7C311A7
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 23:18:55 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010003000501010603050202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch introduces logarithmic volume control for the "PCM Playback
Volume" control of Terratec Aureon cards (digital master attenuation of
WM8770). A separate logarithmic table is used.

diff created against alsa-driver-1.0.11rc5 as suggested by Takashi.

Signed-off-by: Maximilian Rehkopf <otakon@gmx.net>

Many people seem to post patches in-line instead of attaching them. What
do you prefer?

-- 
Maximilian Rehkopf

--------------010003000501010603050202
Content-Type: text/plain;
 name="aureon-pcmvol.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aureon-pcmvol.diff"

--- alsa-kernel/pci/ice1712/aureon.c	2006-04-06 15:34:58.000000000 +0200
+++ alsa-kernel.pcm/pci/ice1712/aureon.c	2006-04-18 22:11:52.000000000 +0200
@@ -679,6 +679,31 @@ static unsigned char wm_vol[256] = {
 	0, 0
 };
 
+/* 
+ * Logarithmic volume values for digital attenuation
+ * for WM8770 
+ * Computed as 2 * (20 * Log10(255 / x))
+ */
+static unsigned char wm_vol_dig[256] = {
+        255, 96, 84, 77, 72, 68, 65, 62, 60, 58, 56, 55, 53, 52, 50, 49,
+         48, 47, 46, 45, 44, 43, 43, 42, 41, 40, 40, 39, 38, 38, 37, 37,
+         36, 36, 35, 34, 34, 34, 33, 33, 32, 32, 31, 31, 31, 30, 30, 29,
+         29, 29, 28, 28, 28, 27, 27, 27, 26, 26, 26, 25, 25, 25, 25, 24,
+         24, 24, 23, 23, 23, 23, 22, 22, 22, 22, 21, 21, 21, 21, 21, 20,
+         20, 20, 20, 19, 19, 19, 19, 19, 18, 18, 18, 18, 18, 18, 17, 17,
+         17, 17, 17, 16, 16, 16, 16, 16, 16, 15, 15, 15, 15, 15, 15, 14,
+         14, 14, 14, 14, 14, 14, 13, 13, 13, 13, 13, 13, 13, 12, 12, 12,
+         12, 12, 12, 12, 11, 11, 11, 11, 11, 11, 11, 11, 10, 10, 10, 10,
+         10, 10, 10, 10,  9,  9,  9,  9,  9,  9,  9,  9,  9,  8,  8,  8,
+          8,  8,  8,  8,  8,  8,  7,  7,  7,  7,  7,  7,  7,  7,  7,  7,
+          6,  6,  6,  6,  6,  6,  6,  6,  6,  6,  5,  5,  5,  5,  5,  5,
+          5,  5,  5,  5,  5,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,
+          4,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  2,  2,  2,
+          2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  1,  1,  1,  1,  1,  1,
+          1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0,  0,  0,  0,  0
+};
+
+
 #define WM_VOL_MAX	(sizeof(wm_vol) - 1)
 #define WM_VOL_MUTE	0x8000
 
@@ -913,45 +938,46 @@ static int wm_master_mute_put(struct snd
 
 /* digital master volume */
 #define PCM_0dB 0xff
-#define PCM_RES 128	/* -64dB */
+#define PCM_RES 255	/* available steps to mute */ 
 #define PCM_MIN (PCM_0dB - PCM_RES)
-static int wm_pcm_vol_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+static int wm_pcm_vol_info(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
-	uinfo->value.integer.min = 0;		/* mute (-64dB) */
+	uinfo->value.integer.min = 0;		/* mute */
 	uinfo->value.integer.max = PCM_RES;	/* 0dB */
 	return 0;
 }
 
-static int wm_pcm_vol_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int wm_pcm_vol_get(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned short val;
 
-	mutex_lock(&ice->gpio_mutex);
-	val = wm_get(ice, WM_DAC_DIG_MASTER_ATTEN) & 0xff;
+	val = ice->spec.aureon.pcm_vol;
 	val = val > PCM_MIN ? (val - PCM_MIN) : 0;
 	ucontrol->value.integer.value[0] = val;
-	mutex_unlock(&ice->gpio_mutex);
 	return 0;
 }
 
-static int wm_pcm_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int wm_pcm_vol_put(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned short ovol, nvol;
 	int change = 0;
 
 	snd_ice1712_save_gpio_status(ice);
-	nvol = ucontrol->value.integer.value[0];
-	nvol = (nvol ? (nvol + PCM_MIN) : 0) & 0xff;
-	ovol = wm_get(ice, WM_DAC_DIG_MASTER_ATTEN) & 0xff;
+	nvol = PCM_0dB - wm_vol_dig[ucontrol->value.integer.value[0]];
+	ovol = PCM_0dB - wm_vol_dig[ice->spec.aureon.pcm_vol & 0xff];
 	if (ovol != nvol) {
 		wm_put(ice, WM_DAC_DIG_MASTER_ATTEN, nvol); /* prelatch */
 		wm_put_nocache(ice, WM_DAC_DIG_MASTER_ATTEN, nvol | 0x100); /* update */
 		change = 1;
 	}
+	ice->spec.aureon.pcm_vol = ucontrol->value.integer.value[0];
 	snd_ice1712_restore_gpio_status(ice);
 	return change;
 }
@@ -2021,6 +2047,8 @@ static int __devinit aureon_init(struct 
 		wm_set_vol(ice, i, ice->spec.aureon.vol[i], ice->spec.aureon.master[i % 2]);
 	}
 
+	ice->spec.aureon.pcm_vol = 0;
+	
 	return 0;
 }
 
--- alsa-kernel/pci/ice1712/ice1712.h	2006-04-06 15:34:58.000000000 +0200
+++ alsa-kernel.pcm/pci/ice1712/ice1712.h	2006-04-18 22:08:04.000000000 +0200
@@ -373,6 +373,7 @@ struct snd_ice1712 {
 			unsigned int cs8415_mux;
 			unsigned short master[2];
 			unsigned short vol[8];
+			unsigned char pcm_vol;
 			unsigned char pca9554_out;
 		} aureon;
 		/* AC97 register cache for Phase28 */

--------------010003000501010603050202--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
