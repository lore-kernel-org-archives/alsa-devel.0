From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/6] firewire-digi00x: use in-kernel
	representation for the type of 8 bits
Date: Sun, 11 Oct 2015 12:30:14 +0900
Message-ID: <1444534219-31718-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A3BCC2605F0
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 05:30:30 +0200 (CEST)
In-Reply-To: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Original code for 'DoubleOhThree' encoding was written with '__u8' type,
while the type is usually used to export something to userspace.

This commit replaces the type with 'u8'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/amdtp-dot.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index e6731d3..c12ce4d 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -21,8 +21,8 @@
  * Zammit in 2012, with reverse-engineering for Digi 003 Rack.
  */
 struct dot_state {
-	__u8 carry;
-	__u8 idx;
+	u8 carry;
+	u8 idx;
 	unsigned int off;
 };
 
@@ -47,25 +47,25 @@ struct amdtp_dot {
 #define BYTE_PER_SAMPLE (4)
 #define MAGIC_DOT_BYTE (2)
 #define MAGIC_BYTE_OFF(x) (((x) * BYTE_PER_SAMPLE) + MAGIC_DOT_BYTE)
-static const __u8 dot_scrt(const __u8 idx, const unsigned int off)
+static const u8 dot_scrt(const u8 idx, const unsigned int off)
 {
 	/*
 	 * the length of the added pattern only depends on the lower nibble
 	 * of the last non-zero data
 	 */
-	static const __u8 len[16] = {0, 1, 3, 5, 7, 9, 11, 13, 14,
-				     12, 10, 8, 6, 4, 2, 0};
+	static const u8 len[16] = {0, 1, 3, 5, 7, 9, 11, 13, 14,
+				   12, 10, 8, 6, 4, 2, 0};
 
 	/*
 	 * the lower nibble of the salt. Interleaved sequence.
 	 * this is walked backwards according to len[]
 	 */
-	static const __u8 nib[15] = {0x8, 0x7, 0x9, 0x6, 0xa, 0x5, 0xb, 0x4,
-				     0xc, 0x3, 0xd, 0x2, 0xe, 0x1, 0xf};
+	static const u8 nib[15] = {0x8, 0x7, 0x9, 0x6, 0xa, 0x5, 0xb, 0x4,
+				   0xc, 0x3, 0xd, 0x2, 0xe, 0x1, 0xf};
 
 	/* circular list for the salt's hi nibble. */
-	static const __u8 hir[15] = {0x0, 0x6, 0xf, 0x8, 0x7, 0x5, 0x3, 0x4,
-				     0xc, 0xd, 0xe, 0x1, 0x2, 0xb, 0xa};
+	static const u8 hir[15] = {0x0, 0x6, 0xf, 0x8, 0x7, 0x5, 0x3, 0x4,
+				   0xc, 0xd, 0xe, 0x1, 0x2, 0xb, 0xa};
 
 	/*
 	 * start offset for upper nibble mapping.
@@ -73,12 +73,12 @@ static const __u8 dot_scrt(const __u8 idx, const unsigned int off)
 	 * hir[] is not used and - coincidentally - the salt's hi nibble is
 	 * 0x09 regardless of the offset.
 	 */
-	static const __u8 hio[16] = {0, 11, 12, 6, 7, 5, 1, 4,
-				     3, 0x00, 14, 13, 8, 9, 10, 2};
+	static const u8 hio[16] = {0, 11, 12, 6, 7, 5, 1, 4,
+				   3, 0x00, 14, 13, 8, 9, 10, 2};
 
-	const __u8 ln = idx & 0xf;
-	const __u8 hn = (idx >> 4) & 0xf;
-	const __u8 hr = (hn == 0x9) ? 0x9 : hir[(hio[hn] + off) % 15];
+	const u8 ln = idx & 0xf;
+	const u8 hn = (idx >> 4) & 0xf;
+	const u8 hr = (hn == 0x9) ? 0x9 : hir[(hio[hn] + off) % 15];
 
 	if (len[ln] < off)
 		return 0x00;
@@ -88,7 +88,7 @@ static const __u8 dot_scrt(const __u8 idx, const unsigned int off)
 
 static void dot_encode_step(struct dot_state *state, __be32 *const buffer)
 {
-	__u8 * const data = (__u8 *) buffer;
+	u8 * const data = (u8 *) buffer;
 
 	if (data[MAGIC_DOT_BYTE] != 0x00) {
 		state->off = 0;
-- 
2.1.4
