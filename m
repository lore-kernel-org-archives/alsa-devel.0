From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 5/5] ALSA: hdspm - Enable 32 samples/period on
	RME RayDAT/AIO
Date: Mon, 15 Aug 2011 00:22:54 +0200
Message-ID: <1313360574-9891-6-git-send-email-adi@drcomp.erfurt.thur.de>
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

Newer RME cards like RayDAT and AIO support 32 samples per period. This
value is encoded as {1,1,1} in the HDSP_LatencyMask bits in the control
register.

Since {1,1,1} is also the representation for 8192 samples/period on
older RME cards, we have to special case 32 samples and 32768 bytes
according to the actual card.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 1a52a1a..92ac64c 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1323,12 +1323,27 @@ static int hdspm_set_interrupt_interval(struct hdspm *s, unsigned int frames)
 
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
