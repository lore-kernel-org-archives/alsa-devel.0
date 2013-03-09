From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/7] ALSA: hdspm - Refactor sample rate
	acquisition
Date: Sun, 10 Mar 2013 00:37:21 +0100
Message-ID: <1362872247-29029-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit introduces hdspm_get_pll_freq() to avoid code duplication.
Reading the sample rate from the DDS register will be required by
upcoming code.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 223c3d9..50cba5c 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -969,6 +969,7 @@ static int snd_hdspm_create_pcm(struct snd_card *card,
 				struct hdspm *hdspm);
 
 static inline void snd_hdspm_initialize_midi_flush(struct hdspm *hdspm);
+static inline int hdspm_get_pll_freq(struct hdspm *hdspm);
 static int hdspm_update_simple_mixer_controls(struct hdspm *hdspm);
 static int hdspm_autosync_ref(struct hdspm *hdspm);
 static int snd_hdspm_set_defaults(struct hdspm *hdspm);
@@ -1979,16 +1980,25 @@ static void hdspm_midi_tasklet(unsigned long arg)
 /* get the system sample rate which is set */
 
 
+static inline int hdspm_get_pll_freq(struct hdspm *hdspm)
+{
+	unsigned int period, rate;
+
+	period = hdspm_read(hdspm, HDSPM_RD_PLL_FREQ);
+	rate = hdspm_calc_dds_value(hdspm, period);
+
+	return rate;
+}
+
 /**
  * Calculate the real sample rate from the
  * current DDS value.
  **/
 static int hdspm_get_system_sample_rate(struct hdspm *hdspm)
 {
-	unsigned int period, rate;
+	unsigned int rate;
 
-	period = hdspm_read(hdspm, HDSPM_RD_PLL_FREQ);
-	rate = hdspm_calc_dds_value(hdspm, period);
+	rate = hdspm_get_pll_freq(hdspm);
 
 	if (rate > 207000) {
 		/* Unreasonable high sample rate as seen on PCI MADI cards. */
-- 
1.7.10.4
