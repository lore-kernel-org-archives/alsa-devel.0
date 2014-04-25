From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/49] firewire-lib: Add handling output connection by CMP
Date: Fri, 25 Apr 2014 22:44:56 +0900
Message-ID: <1398433530-13136-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
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
 sound/firewire/cmp.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index c7f7a31..9da40d9 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -29,6 +29,14 @@
 #define PCR_CHANNEL_MASK	0x003f0000
 #define PCR_CHANNEL_SHIFT	16
 
+/* oPCR specific fields */
+#define OPCR_XSPEED_MASK	0x00C00000
+#define OPCR_XSPEED_SHIFT	22
+#define OPCR_SPEED_MASK		0x0000C000
+#define OPCR_SPEED_SHIFT	14
+#define OPCR_OVERHEAD_ID_MASK	0x00003C00
+#define OPCR_OVERHEAD_ID_SHIFT	10
+
 enum bus_reset_handling {
 	ABORT_ON_BUS_RESET,
 	SUCCEED_ON_BUS_RESET,
@@ -41,10 +49,27 @@ void cmp_error(struct cmp_connection *c, const char *fmt, ...)
 
 	va_start(va, fmt);
 	dev_err(&c->resources.unit->device, "%cPCR%u: %pV",
-		'i', c->pcr_index, &(struct va_format){ fmt, &va });
+		(c->direction == CMP_INPUT) ? 'i' : 'o',
+		c->pcr_index, &(struct va_format){ fmt, &va });
 	va_end(va);
 }
 
+static u64 mpr_address(struct cmp_connection *c)
+{
+	if (c->direction == CMP_INPUT)
+		return CSR_REGISTER_BASE + CSR_IMPR;
+	else
+		return CSR_REGISTER_BASE + CSR_OMPR;
+}
+
+static u64 pcr_address(struct cmp_connection *c)
+{
+	if (c->direction == CMP_INPUT)
+		return CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index);
+	else
+		return CSR_REGISTER_BASE + CSR_OPCR(c->pcr_index);
+}
+
 static int pcr_modify(struct cmp_connection *c,
 		      __be32 (*modify)(struct cmp_connection *c, __be32 old),
 		      int (*check)(struct cmp_connection *c, __be32 pcr),
@@ -60,8 +85,7 @@ static int pcr_modify(struct cmp_connection *c,
 
 		err = snd_fw_transaction(
 				c->resources.unit, TCODE_LOCK_COMPARE_SWAP,
-				CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index),
-				buffer, 8,
+				pcr_address(c), buffer, 8,
 				FW_FIXED_GENERATION | c->resources.generation);
 
 		if (err < 0) {
@@ -101,9 +125,9 @@ int cmp_connection_init(struct cmp_connection *c,
 	u32 mpr;
 	int err;
 
+	c->direction = direction;
 	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
-				 CSR_REGISTER_BASE + CSR_IMPR,
-				 &mpr_be, 4, 0);
+				 mpr_address(c), &mpr_be, 4, 0);
 	if (err < 0)
 		return err;
 	mpr = be32_to_cpu(mpr_be);
@@ -151,6 +175,53 @@ static __be32 ipcr_set_modify(struct cmp_connection *c, __be32 ipcr)
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
+			     OPCR_OVERHEAD_ID_MASK);
+	opcr |= cpu_to_be32(1 << PCR_P2P_CONN_SHIFT);
+	opcr |= cpu_to_be32(xspd << OPCR_XSPEED_SHIFT);
+	opcr |= cpu_to_be32(c->resources.channel << PCR_CHANNEL_SHIFT);
+	opcr |= cpu_to_be32(spd << OPCR_SPEED_SHIFT);
+	opcr |= cpu_to_be32(get_overhead_id(c) << OPCR_OVERHEAD_ID_SHIFT);
+
+	return opcr;
+}
+
 static int pcr_set_check(struct cmp_connection *c, __be32 pcr)
 {
 	if (pcr & cpu_to_be32(PCR_BCAST_CONN |
@@ -196,8 +267,13 @@ retry_after_bus_reset:
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
@@ -245,8 +321,13 @@ int cmp_connection_update(struct cmp_connection *c)
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
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
