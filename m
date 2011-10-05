From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ALSA: hdmi: fix printout of SAD sampling rates
Date: Wed,  5 Oct 2011 15:14:20 -0500
Message-ID: <1317845660-3337-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A9D791039FE
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 22:15:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SAD sampling rate information reported in
/proc/asound/cardX/eldX is incorrect due to a mismatch
between HDA and HDMI frequencies. Add new routine to provide
relevant values.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_codec.c |    2 +-
 sound/pci/hda/hda_eld.c   |   24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e3db196..34a24e4 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5205,7 +5205,7 @@ EXPORT_SYMBOL_HDA(snd_array_free);
  * @buf: the string buffer to write
  * @buflen: the max buffer length
  *
- * used by hda_proc.c and hda_eld.c
+ * used by hda_proc.c
  */
 void snd_print_pcm_rates(int pcm, char *buf, int buflen)
 {
diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index f1c621d..bc1ac294 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -363,6 +363,26 @@ error:
 	return ret;
 }
 
+/**
+ * SNDRV_PCM_RATE_* and AC_PAR_PCM values don't match, print correct rates with
+ * hdmi-specific routine.
+ */
+static void hdmi_print_pcm_rates(int pcm, char *buf, int buflen)
+{
+	static unsigned int alsa_rates[] = {
+		5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 88200,
+		96000, 176400, 192000, 384000
+	};
+	int i, j;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(alsa_rates); i++)
+		if (pcm & (1 << i))
+			j += snprintf(buf + j, buflen - j,  " %d",
+				alsa_rates[i]);
+
+	buf[j] = '\0'; /* necessary when j == 0 */
+}
+
 static void hdmi_show_short_audio_desc(struct cea_sad *a)
 {
 	char buf[SND_PRINT_RATES_ADVISED_BUFSIZE];
@@ -371,7 +391,7 @@ static void hdmi_show_short_audio_desc(struct cea_sad *a)
 	if (!a->format)
 		return;
 
-	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
+	hdmi_print_pcm_rates(a->rates, buf, sizeof(buf));
 
 	if (a->format == AUDIO_CODING_TYPE_LPCM)
 		snd_print_pcm_bits(a->sample_bits, buf2 + 8, sizeof(buf2) - 8);
@@ -430,7 +450,7 @@ static void hdmi_print_sad_info(int i, struct cea_sad *a,
 			i, a->format, cea_audio_coding_type_names[a->format]);
 	snd_iprintf(buffer, "sad%d_channels\t\t%d\n", i, a->channels);
 
-	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
+	hdmi_print_pcm_rates(a->rates, buf, sizeof(buf));
 	snd_iprintf(buffer, "sad%d_rates\t\t[0x%x]%s\n", i, a->rates, buf);
 
 	if (a->format == AUDIO_CODING_TYPE_LPCM) {
-- 
1.7.6.2
