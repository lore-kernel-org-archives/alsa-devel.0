From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/9] ALSA: hdspm - Report external rate in
	slave mode on PCI MADI
Date: Fri, 19 Oct 2012 17:42:23 +0200
Message-ID: <1350661350-5000-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, andre.schramm@iosono-sound.com
List-Id: alsa-devel@alsa-project.org

As a follow-up to a97bda7d29d02a2e9c6609d0947b15e55f5200e5, report the
external sample rate as system_sample_rate when in slave mode.

For PCIe MADI cards, the DDS value automatically contains the external
sample rate, but the PCI version needs this manual workaround.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 742bd5e..1131a8a 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -971,6 +971,7 @@ static inline void snd_hdspm_initialize_midi_flush(struct hdspm *hdspm);
 static int hdspm_update_simple_mixer_controls(struct hdspm *hdspm);
 static int hdspm_autosync_ref(struct hdspm *hdspm);
 static int snd_hdspm_set_defaults(struct hdspm *hdspm);
+static int hdspm_system_clock_mode(struct hdspm *hdspm);
 static void hdspm_set_sgbuf(struct hdspm *hdspm,
 			    struct snd_pcm_substream *substream,
 			     unsigned int reg, int channels);
@@ -1989,10 +1990,14 @@ static int hdspm_get_system_sample_rate(struct hdspm *hdspm)
 	rate = hdspm_calc_dds_value(hdspm, period);
 
 	if (rate > 207000) {
-		/* Unreasonable high sample rate as seen on PCI MADI cards.
-		 * Use the cached value instead.
-		 */
-		rate = hdspm->system_sample_rate;
+		/* Unreasonable high sample rate as seen on PCI MADI cards. */
+		if (0 == hdspm_system_clock_mode(hdspm)) {
+			/* master mode, return internal sample rate */
+			rate = hdspm->system_sample_rate;
+		} else {
+			/* slave mode, return external sample rate */
+			rate = hdspm_external_sample_rate(hdspm);
+		}
 	}
 
 	return rate;
-- 
1.7.10.4
