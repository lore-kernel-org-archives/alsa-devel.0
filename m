From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: [PATCH 2/4] AC97 wm9713 support
Date: Fri, 25 Feb 2005 14:23:25 +0000
Message-ID: <1109341404.30473.673.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1YN4OtFnBupzQidKjwJd"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-1YN4OtFnBupzQidKjwJd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is against ac97_codec.h

Changes:-

 o Added the following AC97 flags:- AC97_HAS_NO_PC_BEEP,
AC97_HAS_NO_PHONE, AC97_HAS_NO_CD, AC97_HAS_NO_VIDEO,
AC97_HAS_NO_REC_GAIN.
 o Added struct ac97_enum to hold the new enum types
 o Combined some flags for WM9713

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
 

--=-1YN4OtFnBupzQidKjwJd
Content-Disposition: attachment; filename=ac97_codec.h.diff
Content-Type: text/x-patch; name=ac97_codec.h.diff; charset=
Content-Transfer-Encoding: 7bit

diff -u -r1.63 ac97_codec.h
--- include/ac97_codec.h	11 Jan 2005 17:44:51 -0000	1.63
+++ include/ac97_codec.h	24 Feb 2005 16:49:54 -0000
@@ -366,6 +366,13 @@
 #define AC97_DOUBLE_RATE	(1<<5)	/* supports double rate playback */
 #define AC97_HAS_NO_MASTER_VOL	(1<<6)	/* no Master volume */
 #define AC97_HAS_NO_PCM_VOL	(1<<7)	/* no PCM volume */
+#define AC97_DEFAULT_POWER_OFF	(1<<8)	/* no RESET write */
+#define AC97_MODEM_PATCH	(1<<9)	/* modem patch */
+#define AC97_HAS_NO_REC_GAIN	(1<<10) /* no Record gain */
+#define AC97_HAS_NO_PHONE	(1<<11) /* no PHONE volume */
+#define AC97_HAS_NO_PC_BEEP	(1<<12) /* no PC Beep volume */
+#define AC97_HAS_NO_VIDEO	(1<<13) /* no Video volume */
+#define AC97_HAS_NO_CD		(1<<14) /* no CD volume */
 
 /* rates indexes */
 #define AC97_RATES_FRONT_DAC	0
@@ -375,6 +382,12 @@
 #define AC97_RATES_MIC_ADC	4
 #define AC97_RATES_SPDIF	5
 
+/* combined flags */
+#define WM9713_AC97_FLAGS		AC97_DEFAULT_POWER_OFF | AC97_HAS_NO_REC_GAIN |\
+								AC97_STEREO_MUTES | AC97_HAS_NO_PHONE |\
+								AC97_HAS_NO_PC_BEEP | AC97_HAS_NO_VIDEO |\
+								AC97_HAS_NO_CD
+
 /* shared controllers */
 enum {
 	AC97_SHARED_TYPE_NONE,
@@ -580,4 +593,11 @@
 int snd_ac97_pcm_close(struct ac97_pcm *pcm);
 int snd_ac97_pcm_double_rate_rules(snd_pcm_runtime_t *runtime);
 
+struct ac97_enum {
+	unsigned char reg;
+	unsigned char shift_l;
+	unsigned char shift_r;
+	unsigned short mask;
+	const char **texts;
+};
 #endif /* __SOUND_AC97_CODEC_H */

--=-1YN4OtFnBupzQidKjwJd--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
