From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/4] ALSA: hdspm - Enable 32 samples/period on
	RME RayDAT/AIO
Date: Fri, 12 Aug 2011 21:57:49 +0200
Message-ID: <1313179069-8432-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1313179069-8432-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1313179069-8432-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Newer RME cards like RayDAT and AIO support 32 samples per period. This
value is encoded as {1,1,1} in the HDSP_LatencyMask bits in the control
register.

Since {1,1,1} is also the representation for 8192 samples/period on
older RME cards, we have to special case 32 samples and 32768 bytes
according to the actual card.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 159133a..1ed4ba6 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1245,6 +1245,23 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 static inline void hdspm_compute_period_size(struct hdspm *hdspm)
 {
 	hdspm->period_bytes = 1 << ((hdspm_decode_latency(hdspm->control_register) + 8));
+	if (32768 == hdspm->period_bytes) {
+		/* Special case for new RME cards with 32 samples period size.
+		 * The three latency bits in the control register
+		 * (HDSP_LatencyMask) encode latency values of 64 samples as
+		 * 0, 128 samples as 1 ... 4096 samples as 6. For old cards, 7
+		 * denotes 8192 samples, but on new cards like RayDAT or AIO,
+		 * it corresponds to 32 samples. Multiplied by 4 bytes equals
+		 * 128 bytes.
+		 *
+		 * Note that hdspm->period_bytes isn't used for anything
+		 * useful on new cards (it's used on old cards in
+		 * hdspm_hw_pointer), but for the sake of correctness and
+		 * potential future output via procfs, let's get it right.
+		 */
+		if (RayDAT == hdspm->io_type || AIO == hdspm->io_type)
+			hdspm->period_bytes = 128;
+	}
 }
 
 
@@ -1303,12 +1320,27 @@ static int hdspm_set_interrupt_interval(struct hdspm *s, unsigned int frames)
 
 	spin_lock_irq(&s->lock);
 
-	frames >>= 7;
-	n = 0;
-	while (frames) {
-		n++;
-		frames >>= 1;
+	if (32 == frames) {
+		/* Special case for new RME cards like RayDAT/AIO which
+		 * support period sizes of 32 samples. Since latency is
+		 * encoded in the three bits of HDSP_LatencyMask, we can only
+		 * have values from 0 .. 7. While 0 still means 64 samples and
+		 * 6 represents 4096 samples on all cards, 7 represents 8192
+		 * on older cards and 32 samples on new cards.
+		 *
+		 * In other words, period size in samples is calculated by
+		 * 2^(n+6) with n ranging from 0 .. 7.
+		 */
+		n = 7;
+	} else {
+		frames >>= 7;
+		n = 0;
+		while (frames) {
+			n++;
+			frames >>= 1;
+		}
 	}
+
 	s->control_register &= ~HDSPM_LatencyMask;
 	s->control_register |= hdspm_encode_latency(n);
 
-- 
1.7.5.4
