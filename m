From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/5] ALSA: hdspm - Introduce
	hdspm_get_latency() to harmonize latency calculation
Date: Mon, 15 Aug 2011 00:22:53 +0200
Message-ID: <1313360574-9891-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <20110814215943.GK19500@ltw.loris.tv>
	<1313360574-9891-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1313360574-9891-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently, hdspm_decode_latency is called several times, violating the
DRY principle. Given that we need to distinguish between old and new
cards when decoding the latency bits in the control register, introduce
hdspm_get_latency() to provide the required functionality.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 159133a..1a52a1a 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1241,10 +1241,30 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 	return rate;
 }
 
+/* return latency in samples per period */
+static int hdspm_get_latency(struct hdspm *hdspm)
+{
+	int n;
+
+	n = hdspm_decode_latency(hdspm->control_register);
+
+	/* Special case for new RME cards with 32 samples period size.
+	 * The three latency bits in the control register
+	 * (HDSP_LatencyMask) encode latency values of 64 samples as
+	 * 0, 128 samples as 1 ... 4096 samples as 6. For old cards, 7
+	 * denotes 8192 samples, but on new cards like RayDAT or AIO,
+	 * it corresponds to 32 samples.
+	 */
+	if ((7 == n) && (RayDAT == hdspm->io_type || AIO == hdspm->io_type))
+		n = -1;
+
+	return 1 << (n + 6);
+}
+
 /* Latency function */
 static inline void hdspm_compute_period_size(struct hdspm *hdspm)
 {
-	hdspm->period_bytes = 1 << ((hdspm_decode_latency(hdspm->control_register) + 8));
+	hdspm->period_bytes = 4 * hdspm_get_latency(hdspm);
 }
 
 
@@ -4801,8 +4821,7 @@ snd_hdspm_proc_read_madi(struct snd_info_entry * entry,
 
 	snd_iprintf(buffer, "--- Settings ---\n");
 
-	x = 1 << (6 + hdspm_decode_latency(hdspm->control_register &
-							HDSPM_LatencyMask));
+	x = hdspm_get_latency(hdspm);
 
 	snd_iprintf(buffer,
 		"Size (Latency): %d samples (2 periods of %lu bytes)\n",
@@ -4965,8 +4984,7 @@ snd_hdspm_proc_read_aes32(struct snd_info_entry * entry,
 
 	snd_iprintf(buffer, "--- Settings ---\n");
 
-	x = 1 << (6 + hdspm_decode_latency(hdspm->control_register &
-				HDSPM_LatencyMask));
+	x = hdspm_get_latency(hdspm);
 
 	snd_iprintf(buffer,
 		    "Size (Latency): %d samples (2 periods of %lu bytes)\n",
-- 
1.7.5.4
