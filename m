From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 4/5] hda: make global snd_print_pcm_bits()
Date: Wed, 19 Nov 2008 15:14:02 +0800
Message-ID: <20081119072203.739082953@linux.intel.com>
References: <20081119071358.231716724@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B154245C1
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 08:26:03 +0100 (CET)
Content-Disposition: inline; filename=alsa-print-sample-bits.patch
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Introduce a global function snd_print_pcm_bits() and use it in the ELD code.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c   |   10 ++++++----
 sound/pci/hda/hda_local.h |    3 +++
 sound/pci/hda/hda_proc.c  |   22 ++++++++++++++++------
 3 files changed, 25 insertions(+), 10 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_proc.c
+++ sound-2.6/sound/pci/hda/hda_proc.c
@@ -107,23 +107,33 @@ void snd_print_pcm_rates(int pcm, char *
 static void print_pcm_rates(struct snd_info_buffer *buffer, unsigned int pcm)
 {
 	char buf[SND_PRINT_RATES_ADVISED_BUFSIZE];
+
 	pcm &= AC_SUPPCM_RATES;
 	snd_iprintf(buffer, "    rates [0x%x]:", pcm);
 	snd_print_pcm_rates(pcm, buf, sizeof(buf));
 	snd_iprintf(buffer, "%s\n", buf);
 }
 
-static void print_pcm_bits(struct snd_info_buffer *buffer, unsigned int pcm)
+void snd_print_pcm_bits(int pcm, char *buf, int buflen)
 {
 	static unsigned int bits[] = { 8, 16, 20, 24, 32 };
-	int i;
+	int i, j;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(bits); i++)
+		if (pcm & (1 << i))
+			j += snprintf(buf + j, buflen - j,  " %d", bits[i]);
+
+	buf[j] = '\0'; /* necessary when j == 0 */
+}
+
+static void print_pcm_bits(struct snd_info_buffer *buffer, unsigned int pcm)
+{
+	char buf[SND_PRINT_BITS_ADVISED_BUFSIZE];
 
 	pcm = (pcm >> 16) & 0xff;
 	snd_iprintf(buffer, "    bits [0x%x]:", pcm);
-	for (i = 0; i < ARRAY_SIZE(bits); i++)
-		if (pcm & (1 << i))
-			snd_iprintf(buffer, " %d", bits[i]);
-	snd_iprintf(buffer, "\n");
+	snd_print_pcm_bits(pcm, buf, sizeof(buf));
+	snd_iprintf(buffer, "%s\n", buf);
 }
 
 static void print_pcm_formats(struct snd_info_buffer *buffer,
--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -455,7 +455,7 @@ void snd_hdmi_show_eld(struct hdmi_eld *
 static void hdmi_print_sad_info(int i, struct cea_sad *a,
 				struct snd_info_buffer *buffer)
 {
-	char buf[80];
+	char buf[SND_PRINT_RATES_ADVISED_BUFSIZE];
 
 	snd_iprintf(buffer, "sad%d_coding_type\t[0x%x] %s\n",
 			i, a->format, cea_audio_coding_type_names[a->format]);
@@ -464,9 +464,11 @@ static void hdmi_print_sad_info(int i, s
 	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
 	snd_iprintf(buffer, "sad%d_rates\t\t[0x%x]%s\n", i, a->rates, buf);
 
-	if (a->format == AUDIO_CODING_TYPE_LPCM)
-		snd_iprintf(buffer, "sad%d_bits\t\t0x%x\n",
-							i, a->sample_bits);
+	if (a->format == AUDIO_CODING_TYPE_LPCM) {
+		snd_print_pcm_bits(a->sample_bits, buf, sizeof(buf));
+		snd_iprintf(buffer, "sad%d_bits\t\t[0x%x]%s\n",
+							i, a->sample_bits, buf);
+	}
 
 	if (a->max_bitrate)
 		snd_iprintf(buffer, "sad%d_max_bitrate\t%d\n",
--- sound-2.6.orig/sound/pci/hda/hda_local.h
+++ sound-2.6/sound/pci/hda/hda_local.h
@@ -287,6 +287,9 @@ static inline int snd_hda_codec_proc_new
 #define SND_PRINT_RATES_ADVISED_BUFSIZE	80
 void snd_print_pcm_rates(int pcm, char *buf, int buflen);
 
+#define SND_PRINT_BITS_ADVISED_BUFSIZE	16
+void snd_print_pcm_bits(int pcm, char *buf, int buflen);
+
 /*
  * Misc
  */

-- 
