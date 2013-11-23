From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/17] firewire-lib: Rename macros,
	variables and functions for CMP
Date: Sat, 23 Nov 2013 15:07:59 +0900
Message-ID: <1385186884-8259-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FA122651C6
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:13 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Referring to IEC 61883-1, oMPR and iMPR, oPCR and iPCR have some fields with
the same role in the same position. This patch renames some macros, variables
and function arguments with "i" in its prefix to reuse them between oMPR and
iMPR, oPCR and iPCR.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c | 91 ++++++++++++++++++++++++++--------------------------
 sound/firewire/cmp.h |  6 ++--
 2 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index efdbf58..17ad4f2 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -14,18 +14,20 @@
 #include "iso-resources.h"
 #include "cmp.h"
 
-#define IMPR_SPEED_MASK		0xc0000000
-#define IMPR_SPEED_SHIFT	30
-#define IMPR_XSPEED_MASK	0x00000060
-#define IMPR_XSPEED_SHIFT	5
-#define IMPR_PLUGS_MASK		0x0000001f
-
-#define IPCR_ONLINE		0x80000000
-#define IPCR_BCAST_CONN		0x40000000
-#define IPCR_P2P_CONN_MASK	0x3f000000
-#define IPCR_P2P_CONN_SHIFT	24
-#define IPCR_CHANNEL_MASK	0x003f0000
-#define IPCR_CHANNEL_SHIFT	16
+/* MPR common fields */
+#define MPR_SPEED_MASK		0xc0000000
+#define MPR_SPEED_SHIFT		30
+#define MPR_XSPEED_MASK		0x00000060
+#define MPR_XSPEED_SHIFT	5
+#define MPR_PLUGS_MASK		0x0000001f
+
+/* PCR common fields */
+#define PCR_ONLINE		0x80000000
+#define PCR_BCAST_CONN		0x40000000
+#define PCR_P2P_CONN_MASK	0x3f000000
+#define PCR_P2P_CONN_SHIFT	24
+#define PCR_CHANNEL_MASK	0x003f0000
+#define PCR_CHANNEL_SHIFT	16
 
 enum bus_reset_handling {
 	ABORT_ON_BUS_RESET,
@@ -88,24 +90,24 @@ static int pcr_modify(struct cmp_connection *c,
  * cmp_connection_init - initializes a connection manager
  * @c: the connection manager to initialize
  * @unit: a unit of the target device
- * @ipcr_index: the index of the iPCR on the target device
+ * @pcr_index: the index of the iPCR/oPCR on the target device
  */
 int cmp_connection_init(struct cmp_connection *c,
 			struct fw_unit *unit,
-			unsigned int ipcr_index)
+			unsigned int pcr_index)
 {
-	__be32 impr_be;
-	u32 impr;
+	__be32 mpr_be;
+	u32 mpr;
 	int err;
 
 	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
 				 CSR_REGISTER_BASE + CSR_IMPR,
-				 &impr_be, 4, 0);
+				 &mpr_be, 4, 0);
 	if (err < 0)
 		return err;
-	impr = be32_to_cpu(impr_be);
+	mpr = be32_to_cpu(mpr_be);
 
-	if (ipcr_index >= (impr & IMPR_PLUGS_MASK))
+	if (pcr_index >= (mpr & MPR_PLUGS_MASK))
 		return -EINVAL;
 
 	err = fw_iso_resources_init(&c->resources, unit);
@@ -115,10 +117,10 @@ int cmp_connection_init(struct cmp_connection *c,
 	c->connected = false;
 	mutex_init(&c->mutex);
 	c->last_pcr_value = cpu_to_be32(0x80000000);
-	c->pcr_index = ipcr_index;
-	c->max_speed = (impr & IMPR_SPEED_MASK) >> IMPR_SPEED_SHIFT;
+	c->pcr_index = pcr_index;
+	c->max_speed = (mpr & MPR_SPEED_MASK) >> MPR_SPEED_SHIFT;
 	if (c->max_speed == SCODE_BETA)
-		c->max_speed += (impr & IMPR_XSPEED_MASK) >> IMPR_XSPEED_SHIFT;
+		c->max_speed += (mpr & MPR_XSPEED_MASK) >> MPR_XSPEED_SHIFT;
 
 	return 0;
 }
@@ -139,23 +141,23 @@ EXPORT_SYMBOL(cmp_connection_destroy);
 
 static __be32 ipcr_set_modify(struct cmp_connection *c, __be32 ipcr)
 {
-	ipcr &= ~cpu_to_be32(IPCR_BCAST_CONN |
-			     IPCR_P2P_CONN_MASK |
-			     IPCR_CHANNEL_MASK);
-	ipcr |= cpu_to_be32(1 << IPCR_P2P_CONN_SHIFT);
-	ipcr |= cpu_to_be32(c->resources.channel << IPCR_CHANNEL_SHIFT);
+	ipcr &= ~cpu_to_be32(PCR_BCAST_CONN |
+			     PCR_P2P_CONN_MASK |
+			     PCR_CHANNEL_MASK);
+	ipcr |= cpu_to_be32(1 << PCR_P2P_CONN_SHIFT);
+	ipcr |= cpu_to_be32(c->resources.channel << PCR_CHANNEL_SHIFT);
 
 	return ipcr;
 }
 
-static int ipcr_set_check(struct cmp_connection *c, __be32 ipcr)
+static int pcr_set_check(struct cmp_connection *c, __be32 pcr)
 {
-	if (ipcr & cpu_to_be32(IPCR_BCAST_CONN |
-			       IPCR_P2P_CONN_MASK)) {
+	if (pcr & cpu_to_be32(PCR_BCAST_CONN |
+			       PCR_P2P_CONN_MASK)) {
 		cmp_error(c, "plug is already in use\n");
 		return -EBUSY;
 	}
-	if (!(ipcr & cpu_to_be32(IPCR_ONLINE))) {
+	if (!(pcr & cpu_to_be32(PCR_ONLINE))) {
 		cmp_error(c, "plug is not on-line\n");
 		return -ECONNREFUSED;
 	}
@@ -170,9 +172,9 @@ static int ipcr_set_check(struct cmp_connection *c, __be32 ipcr)
  *
  * This function establishes a point-to-point connection from the local
  * computer to the target by allocating isochronous resources (channel and
- * bandwidth) and setting the target's input plug control register.  When this
- * function succeeds, the caller is responsible for starting transmitting
- * packets.
+ * bandwidth) and setting the target's input/output plug control register.
+ * When this function succeeds, the caller is responsible for starting
+ * transmitting packets.
  */
 int cmp_connection_establish(struct cmp_connection *c,
 			     unsigned int max_payload_bytes)
@@ -193,7 +195,7 @@ retry_after_bus_reset:
 	if (err < 0)
 		goto err_mutex;
 
-	err = pcr_modify(c, ipcr_set_modify, ipcr_set_check,
+	err = pcr_modify(c, ipcr_set_modify, pcr_set_check,
 			 ABORT_ON_BUS_RESET);
 	if (err == -EAGAIN) {
 		fw_iso_resources_free(&c->resources);
@@ -221,8 +223,8 @@ EXPORT_SYMBOL(cmp_connection_establish);
  * cmp_connection_update - update the connection after a bus reset
  * @c: the connection manager
  *
- * This function must be called from the driver's .update handler to reestablish
- * any connection that might have been active.
+ * This function must be called from the driver's .update handler to
+ * reestablish any connection that might have been active.
  *
  * Returns zero on success, or a negative error code.  On an error, the
  * connection is broken and the caller must stop transmitting iso packets.
@@ -242,7 +244,7 @@ int cmp_connection_update(struct cmp_connection *c)
 	if (err < 0)
 		goto err_unconnect;
 
-	err = pcr_modify(c, ipcr_set_modify, ipcr_set_check,
+	err = pcr_modify(c, ipcr_set_modify, pcr_set_check,
 			 SUCCEED_ON_BUS_RESET);
 	if (err < 0)
 		goto err_resources;
@@ -261,19 +263,18 @@ err_unconnect:
 }
 EXPORT_SYMBOL(cmp_connection_update);
 
-
-static __be32 ipcr_break_modify(struct cmp_connection *c, __be32 ipcr)
+static __be32 pcr_break_modify(struct cmp_connection *c, __be32 pcr)
 {
-	return ipcr & ~cpu_to_be32(IPCR_BCAST_CONN | IPCR_P2P_CONN_MASK);
+	return pcr & ~cpu_to_be32(PCR_BCAST_CONN | PCR_P2P_CONN_MASK);
 }
 
 /**
  * cmp_connection_break - break the connection to the target
  * @c: the connection manager
  *
- * This function deactives the connection in the target's input plug control
- * register, and frees the isochronous resources of the connection.  Before
- * calling this function, the caller should cease transmitting packets.
+ * This function deactives the connection in the target's input/output plug
+ * control register, and frees the isochronous resources of the connection.
+ * Before calling this function, the caller should cease transmitting packets.
  */
 void cmp_connection_break(struct cmp_connection *c)
 {
@@ -286,7 +287,7 @@ void cmp_connection_break(struct cmp_connection *c)
 		return;
 	}
 
-	err = pcr_modify(c, ipcr_break_modify, NULL, SUCCEED_ON_BUS_RESET);
+	err = pcr_modify(c, pcr_break_modify, NULL, SUCCEED_ON_BUS_RESET);
 	if (err < 0)
 		cmp_error(c, "plug is still connected\n");
 
diff --git a/sound/firewire/cmp.h b/sound/firewire/cmp.h
index f47de08..2320cd4 100644
--- a/sound/firewire/cmp.h
+++ b/sound/firewire/cmp.h
@@ -11,8 +11,8 @@ struct fw_unit;
  * struct cmp_connection - manages an isochronous connection to a device
  * @speed: the connection's actual speed
  *
- * This structure manages (using CMP) an isochronous stream from the local
- * computer to a device's input plug (iPCR).
+ * This structure manages (using CMP) an isochronous stream between the local
+ * computer and a device's input plug (iPCR) and output plug (oPCR).
  *
  * There is no corresponding oPCR created on the local computer, so it is not
  * possible to overlay connections on top of this one.
@@ -30,7 +30,7 @@ struct cmp_connection {
 
 int cmp_connection_init(struct cmp_connection *connection,
 			struct fw_unit *unit,
-			unsigned int ipcr_index);
+			unsigned int pcr_index);
 void cmp_connection_destroy(struct cmp_connection *connection);
 
 int cmp_connection_establish(struct cmp_connection *connection,
-- 
1.8.3.2
