From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] Add handling CMP output connection
Date: Mon, 29 Apr 2013 18:44:03 +0900
Message-ID: <1367228643-8451-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1367125189-377-1-git-send-email-o-takashi@sakamocchi.jp>
	<1367228643-8451-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1367228643-8451-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

To handle CMP output connection, this patch adds some macros, codes with
condition of direction and new functions. Once cmp_connection_init() is
executed with its direction, CMP input and output connection can be
handled by the same way.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c |  102 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index a8d3d5f..9e70077 100644
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
@@ -64,8 +94,7 @@ static int pcr_modify(struct cmp_connection *c,
 		rcode = fw_run_transaction(
 				device->card, TCODE_LOCK_COMPARE_SWAP,
 				device->node_id, generation, device->max_speed,
-				CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index),
-				buffer, 8);
+				get_offset(c, false), buffer, 8);
 
 		if (rcode == RCODE_COMPLETE) {
 			if (buffer[0] == old_arg) /* success? */
@@ -110,8 +139,7 @@ int cmp_connection_init(struct cmp_connection *c,
 	int err;
 
 	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
-				 CSR_REGISTER_BASE + CSR_IMPR,
-				 &mpr_be, 4);
+				 get_offset(c, true), &mpr_be, 4);
 	if (err < 0)
 		return err;
 	mpr = be32_to_cpu(mpr_be);
@@ -130,6 +158,7 @@ int cmp_connection_init(struct cmp_connection *c,
 	c->max_speed = (mpr & MPR_SPEED_MASK) >> MPR_SPEED_SHIFT;
 	if (c->max_speed == SCODE_BETA)
 		c->max_speed += (mpr & MPR_XSPEED_MASK) >> MPR_XSPEED_SHIFT;
+	c->direction = direction;
 
 	return 0;
 }
@@ -159,6 +188,51 @@ static __be32 ipcr_set_modify(struct cmp_connection *c, __be32 ipcr)
 	return ipcr;
 }
 
+static int get_overhead_id(struct cmp_connection *c)
+{
+	int id;
+
+	/*
+	 * Apply "oPCR overhead ID encoding"
+	 * The encoding table can convert up to 512.
+	 * Here the value over 512 is converted as the same way as 512.
+	 */
+	id = DIV_ROUND_UP(c->resources.bandwidth_overhead, 32);
+	if (id >= 16)
+		id = 0;
+
+	return id;
+}
+
+static __be32 opcr_set_modify(struct cmp_connection *c, __be32 opcr)
+{
+	unsigned int spd, xspd;
+
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
+			     OPCR_OVERHEAD_ID_MASK);
+	opcr |= cpu_to_be32(1 << PCR_P2P_CONN_SHIFT);
+	opcr |= cpu_to_be32(xspd << OPCR_XSPEED_SHIFT);
+	opcr |= cpu_to_be32(c->resources.channel << PCR_CHANNEL_SHIFT);
+	opcr |= cpu_to_be32(spd << OPCR_SPEED_SHIFT);
+	opcr |= cpu_to_be32(get_overhead_id(c) << OPCR_OVERHEAD_ID_SHIFT);
+
+	/* NOTE: payload field is set by target device */
+
+	return opcr;
+}
+
 static int pcr_set_check(struct cmp_connection *c, __be32 pcr)
 {
 	if (pcr & cpu_to_be32(PCR_BCAST_CONN |
@@ -204,8 +278,13 @@ retry_after_bus_reset:
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
@@ -253,8 +332,13 @@ int cmp_connection_update(struct cmp_connection *c)
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
1.7.10.4


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
