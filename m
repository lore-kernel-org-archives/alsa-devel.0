From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - AAF PCM plugin 2/7] aaf: Add presentation
	time tolerance
Date: Fri,  7 Dec 2018 17:55:45 -0800
Message-ID: <20181208015550.20268-3-andre.guedes@intel.com>
References: <20181208015550.20268-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 48E0E267D3B
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 03:02:24 +0100 (CET)
In-Reply-To: <20181208015550.20268-1-andre.guedes@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Different AVTP applications have different presentation time tolerance.
The current version of the plugin doesn't support any tolerance so this
patch extends the AAF plugin in order to enable the user to configure
that tolerance value.

The presentation time tolerance is specified in microseconds and it is
relevant only when the plugin is operating in capture mode.  For more
information see the 'Plugin Configuration' session in doc/aaf.txt

This patch also does some code refactoring and encapsulates all
presentation time validation code in the new is_ptime_valid() helper
function.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 aaf/pcm_aaf.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 doc/aaf.txt   |  6 ++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/aaf/pcm_aaf.c b/aaf/pcm_aaf.c
index b1c3d83..8410dcf 100644
--- a/aaf/pcm_aaf.c
+++ b/aaf/pcm_aaf.c
@@ -60,6 +60,7 @@ typedef struct {
 	int mtt;
 	int t_uncertainty;
 	snd_pcm_uframes_t frames_per_pdu;
+	int ptime_tolerance;
 
 	int sk_fd;
 	int timer_fd;
@@ -328,6 +329,17 @@ static int aaf_load_config(snd_pcm_aaf_t *aaf, snd_config_t *conf)
 				goto err;
 
 			aaf->frames_per_pdu = frames_per_pdu;
+		} else if (strcmp(id, "ptime_tolerance") == 0) {
+			long ptime_tolerance;
+
+			if (snd_config_get_integer(entry,
+						   &ptime_tolerance) < 0)
+				goto err;
+
+			if (ptime_tolerance < 0)
+				goto err;
+
+			aaf->ptime_tolerance = ptime_tolerance * NSEC_PER_USEC;
 		} else {
 			SNDERR("Invalid configuration: %s", id);
 			goto err;
@@ -699,6 +711,27 @@ static int aaf_tx_pdu(snd_pcm_aaf_t *aaf)
 	return 0;
 }
 
+static bool is_ptime_valid(snd_pcm_aaf_t *aaf, uint32_t avtp_time)
+{
+	const uint64_t exp_ptime = aaf->prev_ptime + aaf->timer_period;
+	const uint64_t lower_bound = exp_ptime - aaf->ptime_tolerance;
+	const uint64_t upper_bound = exp_ptime + aaf->ptime_tolerance;
+	const uint64_t ptime = (exp_ptime & 0xFFFFFFFF00000000ULL) | avtp_time;
+
+	if (ptime < lower_bound || ptime > upper_bound) {
+		pr_debug("Presentation time not expected");
+		return false;
+	}
+
+	if (ptime < aaf_mclk_gettime(aaf)) {
+		pr_debug("Presentation time in the past");
+		return false;
+	}
+
+	aaf->prev_ptime = ptime;
+	return true;
+}
+
 static int aaf_rx_pdu(snd_pcm_aaf_t *aaf)
 {
 	int res;
@@ -753,19 +786,10 @@ static int aaf_rx_pdu(snd_pcm_aaf_t *aaf)
 		if (res < 0)
 			return res;
 	} else {
-		uint64_t ptime = aaf->prev_ptime + aaf->timer_period;
-
-		if (avtp_time != ptime % (1ULL << 32)) {
-			pr_debug("Packet dropped: PT not expected");
+		if (!is_ptime_valid(aaf, avtp_time)) {
+			pr_debug("Packet dropped: PT not valid");
 			return 0;
 		}
-
-		if (ptime < aaf_mclk_gettime(aaf)) {
-			pr_debug("Packet dropped: PT in the past");
-			return 0;
-		}
-
-		aaf->prev_ptime = ptime;
 	}
 
 	hw_avail = snd_pcm_ioplug_hw_avail(io, aaf->hw_virt_ptr, io->appl_ptr);
@@ -950,6 +974,8 @@ static void aaf_dump(snd_pcm_ioplug_t *io, snd_output_t *out)
 			  aaf->t_uncertainty / NSEC_PER_USEC);
 	snd_output_printf(out, "  frames per AVTPDU: %lu\n",
 			  aaf->frames_per_pdu);
+	snd_output_printf(out, "  ptime tolerance: %d\n",
+			  aaf->ptime_tolerance / NSEC_PER_USEC);
 }
 
 static int aaf_hw_params(snd_pcm_ioplug_t *io,
diff --git a/doc/aaf.txt b/doc/aaf.txt
index cae86d8..e72eba2 100644
--- a/doc/aaf.txt
+++ b/doc/aaf.txt
@@ -121,6 +121,11 @@ as follows:
 
 	* frames_per_pdu: Number of audio frames transmitted in one AVTPDU.
 
+	* ptime_tolerance: Presentation time tolerance in microseconds.
+	  AVTPDUs with presentation time off by +- ptime_tolerance are not
+	  considered invalid. This option is relevant only when operating in
+	  capture mode.
+
 Plugin Usage
 ------------
 
@@ -138,6 +143,7 @@ below:
 		mtt 2000
 		time_uncertainty 125
 		frames_per_pdu 6
+		ptime_tolerance 100
 	}
 
 Put the above to ~/.asoundrc (or /etc/asound.conf), and use the AAF PCM virtual
-- 
2.19.1
