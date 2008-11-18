From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 1/3] introduce snd_print_pcm_rates()
Date: Tue, 18 Nov 2008 11:47:51 +0800
Message-ID: <20081118042642.195987946@linux.intel.com>
References: <20081118034750.445933681@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 5500024465
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 05:26:54 +0100 (CET)
Content-Disposition: inline; filename=alsa-print-rates.patch
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

We want to share some code with print_pcm_rates(),
so extract a common routine snd_print_pcm_rates() from it.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_local.h |    3 +++
 sound/pci/hda/hda_proc.c  |   20 ++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_local.h
+++ sound-2.6/sound/pci/hda/hda_local.h
@@ -284,6 +284,9 @@ int snd_hda_codec_proc_new(struct hda_co
 static inline int snd_hda_codec_proc_new(struct hda_codec *codec) { return 0; }
 #endif
 
+#define SND_PRINT_RATES_ADVISED_BUFSIZE	80
+void snd_print_pcm_rates(int pcm, char *buf, int buflen);
+
 /*
  * Misc
  */
--- sound-2.6.orig/sound/pci/hda/hda_proc.c
+++ sound-2.6/sound/pci/hda/hda_proc.c
@@ -89,20 +89,28 @@ static void print_amp_vals(struct snd_in
 	snd_iprintf(buffer, "\n");
 }
 
-static void print_pcm_rates(struct snd_info_buffer *buffer, unsigned int pcm)
+void snd_print_pcm_rates(int pcm, char *buf, int buflen)
 {
 	static unsigned int rates[] = {
 		8000, 11025, 16000, 22050, 32000, 44100, 48000, 88200,
 		96000, 176400, 192000, 384000
 	};
-	int i;
+	int i, j;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(rates); i++)
+		if (pcm & (1 << i))
+			j += snprintf(buf + j, buflen - j,  " %d", rates[i]);
+
+	buf[j] = '\0'; /* necessary when j == 0 */
+}
 
+static void print_pcm_rates(struct snd_info_buffer *buffer, unsigned int pcm)
+{
+	char buf[SND_PRINT_RATES_ADVISED_BUFSIZE];
 	pcm &= AC_SUPPCM_RATES;
 	snd_iprintf(buffer, "    rates [0x%x]:", pcm);
-	for (i = 0; i < ARRAY_SIZE(rates); i++) 
-		if (pcm & (1 << i))
-			snd_iprintf(buffer, " %d", rates[i]);
-	snd_iprintf(buffer, "\n");
+	snd_print_pcm_rates(pcm, buf, sizeof(buf));
+	snd_iprintf(buffer, "%s\n", buf);
 }
 
 static void print_pcm_bits(struct snd_info_buffer *buffer, unsigned int pcm)

-- 
