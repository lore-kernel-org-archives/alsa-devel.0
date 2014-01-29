From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/52] firewire-lib: Add handling output connection by CMP
Date: Wed, 29 Jan 2014 22:44:21 +0900
Message-ID: <1391003099-7109-15-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This patch adds some macros, codes with condition of direction and new functions
to handle output connection. Once cmp_connection_init() is executed with its
direction, CMP input and output connection can be handled by the same way.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index 1430fec..00b1b2d 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -29,6 +29,16 @@
 #define PCR_CHANNEL_MASK	0x003f0000
 #define PCR_CHANNEL_SHIFT	16
 
+/* oPCR specific fields */
+#define OPCR_XSPEED_MASK	0x00C00000
+#define OPCR_XSPEED_SHIFT	22
+#define OPCR_SPEED_MASK		0x0000C000
+#define OPCR_SPEED_SHIFT	14
+#define OPCR_OVERHEAD_ID_MASK	0x00003C00
+#define OPCR_OVERHEAD_ID_SHIFT	10
+#define OPCR_PAYLOAD_MASK	0x000003FF
+#define OPCR_PAYLOAD_SHIFT	0
+
 enum bus_reset_handling {
 	ABORT_ON_BUS_RESET,
 	SUCCEED_ON_BUS_RESET,
@@ -41,10 +51,30 @@ void cmp_error(struct cmp_connection *c, const char *fmt, ...)
 
 	va_start(va, fmt);
 	dev_err(&c->resources.unit->device, "%cPCR%u: %pV",
-		'i', c->pcr_index, &(struct va_format){ fmt, &va });
+		(c->direction == CMP_INPUT) ? 'i' : 'o',
+		c->pcr_index, &(struct va_format){ fmt, &va });
 	va_end(va);
 }
 
+static unsigned long long get_offset(struct cmp_connection *c, bool master)
+{
+	unsigned long long offset = CSR_REGISTER_BASE;
+
+	if (!master) {
+		if (c->direction == CMP_INPUT)
+			offset += CSR_IPCR(c->pcr_index);
+		else
+			offset += CSR_OPCR(c->pcr_index);
+	} else {
+		if (c->direction == CMP_INPUT)
+			offset += CSR_IMPR;
+		else
+			offset += CSR_OMPR;
+	}
+
+	return offset;
+}
+
 static int pcr_modify(struct cmp_connection *c,
 		      __be32 (*modify)(struct cmp_connection *c, __be32 old),
 		      int (*check)(struct cmp_connection *c, __be32 pcr),
@@ -60,8 +90,7 @@ static int pcr_modify(struct cmp_connection *c,
 
 		err = snd_fw_transaction(
 				c->resources.unit, TCODE_LOCK_COMPARE_SWAP,
-				CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index),
-				buffer, 8,
+				get_offset(c, false), buffer, 8,
 				FW_FIXED_GENERATION | c->resources.generation);
 
 		if (err < 0) {
@@ -102,8 +131,7 @@ int cmp_connection_init(struct cmp_connection *c,
 	int err;
 
 	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
-				 CSR_REGISTER_BASE + CSR_IMPR,
-				 &mpr_be, 4, 0);
+				 get_offset(c, true), &mpr_be, 4, 0);
 	if (err < 0)
 		return err;
 	mpr = be32_to_cpu(mpr_be);
@@ -122,6 +150,7 @@ int cmp_connection_init(struct cmp_connection *c,
 	c->max_speed = (mpr & MPR_SPEED_MASK) >> MPR_SPEED_SHIFT;
 	if (c->max_speed == SCODE_BETA)
 		c->max_speed += (mpr & MPR_XSPEED_MASK) >> MPR_XSPEED_SHIFT;
+	c->direction = direction;
 
 	return 0;
 }
@@ -151,6 +180,62 @@ static __be32 ipcr_set_modify(struct cmp_connection *c, __be32 ipcr)
 	return ipcr;
 }
 
+static int get_overhead_id(struct cmp_connection *c)
+{
+	int id;
+
+	/*
+	 * apply "oPCR overhead ID encoding"
+	 * the encoding table can convert up to 512.
+	 * here the value over 512 is converted as the same way as 512.
+	 */
+	for (id = 1; id < 16; id++) {
+		if (c->resources.bandwidth_overhead < (id << 5))
+			break;
+	}
+	if (id == 16)
+		id = 0;
+
+	return id;
+}
+
+static __be32 opcr_set_modify(struct cmp_connection *c, __be32 opcr)
+{
+	unsigned int spd, xspd;
+
+	/* generate speed and extended speed field value */
+	if (c->speed > SCODE_400) {
+		spd  = SCODE_800;
+		xspd = c->speed - SCODE_800;
+	} else {
+		spd = c->speed;
+		xspd = 0;
+	}
+
+	opcr &= ~cpu_to_be32(PCR_BCAST_CONN |
+			     PCR_P2P_CONN_MASK |
+			     OPCR_XSPEED_MASK |
+			     PCR_CHANNEL_MASK |
+			     OPCR_SPEED_MASK |
+			     OPCR_OVERHEAD_ID_MASK |
+			     OPCR_PAYLOAD_MASK);
+	opcr |= cpu_to_be32(1 << PCR_P2P_CONN_SHIFT);
+	opcr |= cpu_to_be32(xspd << OPCR_XSPEED_SHIFT);
+	opcr |= cpu_to_be32(c->resources.channel << PCR_CHANNEL_SHIFT);
+	opcr |= cpu_to_be32(spd << OPCR_SPEED_SHIFT);
+	opcr |= cpu_to_be32(get_overhead_id(c) << OPCR_OVERHEAD_ID_SHIFT);
+	/*
+	 * here zero is applied to payload field.
+	 * it means the maximum number of quadlets in an isochronous packet is
+	 * 1024 when spd is less than three, 1024 * 2 * xspd + 1 when spd is
+	 * equal to three. An arbitrary value can be set here but 0 is enough
+	 * for our purpose.
+	 */
+	opcr |= cpu_to_be32(0 << OPCR_PAYLOAD_SHIFT);
+
+	return opcr;
+}
+
 static int pcr_set_check(struct cmp_connection *c, __be32 pcr)
 {
 	if (pcr & cpu_to_be32(PCR_BCAST_CONN |
@@ -196,8 +281,13 @@ retry_after_bus_reset:
 	if (err < 0)
 		goto err_mutex;
 
-	err = pcr_modify(c, ipcr_set_modify, pcr_set_check,
-			 ABORT_ON_BUS_RESET);
+	if (c->direction == CMP_OUTPUT)
+		err = pcr_modify(c, opcr_set_modify, pcr_set_check,
+				 ABORT_ON_BUS_RESET);
+	else
+		err = pcr_modify(c, ipcr_set_modify, pcr_set_check,
+				 ABORT_ON_BUS_RESET);
+
 	if (err == -EAGAIN) {
 		fw_iso_resources_free(&c->resources);
 		goto retry_after_bus_reset;
@@ -245,8 +335,13 @@ int cmp_connection_update(struct cmp_connection *c)
 	if (err < 0)
 		goto err_unconnect;
 
-	err = pcr_modify(c, ipcr_set_modify, pcr_set_check,
-			 SUCCEED_ON_BUS_RESET);
+	if (c->direction == CMP_OUTPUT)
+		err = pcr_modify(c, opcr_set_modify, pcr_set_check,
+				 SUCCEED_ON_BUS_RESET);
+	else
+		err = pcr_modify(c, ipcr_set_modify, pcr_set_check,
+				 SUCCEED_ON_BUS_RESET);
+
 	if (err < 0)
 		goto err_resources;
 
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
