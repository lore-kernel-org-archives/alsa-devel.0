From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 18/31] ALSA: hdspm - Add prototype
	declarations
Date: Fri,  5 Jul 2013 11:28:10 +0200
Message-ID: <1373016503-9474-19-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-13-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-14-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-15-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-16-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-17-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-18-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-18-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch only introduces prototype declarations, no real change. The
functions themselves are already present.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index b7702b2..367dd41 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1017,6 +1017,17 @@ static void hdspm_set_sgbuf(struct hdspm *hdspm,
 			    struct snd_pcm_substream *substream,
 			     unsigned int reg, int channels);
 
+static int hdspm_aes_sync_check(struct hdspm *hdspm, int idx);
+static int hdspm_wc_sync_check(struct hdspm *hdspm);
+static int hdspm_tco_sync_check(struct hdspm *hdspm);
+static int hdspm_sync_in_sync_check(struct hdspm *hdspm);
+
+static int hdspm_get_aes_sample_rate(struct hdspm *hdspm, int index);
+static int hdspm_get_tco_sample_rate(struct hdspm *hdspm);
+static int hdspm_get_wc_sample_rate(struct hdspm *hdspm);
+
+
+
 static inline int HDSPM_bit2freq(int n)
 {
 	static const int bit2freq_tab[] = {
@@ -1152,10 +1163,7 @@ static int hdspm_rate_multiplier(struct hdspm *hdspm, int rate)
 	return rate;
 }
 
-static int hdspm_tco_sync_check(struct hdspm *hdspm);
-static int hdspm_sync_in_sync_check(struct hdspm *hdspm);
-
-/* check for external sample rate */
+/* check for external sample rate, returns the sample rate in Hz*/
 static int hdspm_external_sample_rate(struct hdspm *hdspm)
 {
 	unsigned int status, status2, timecode;
-- 
1.8.3.1
