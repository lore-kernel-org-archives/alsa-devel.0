From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/39] firewire-lib: Add 'direction' member to
	'cmp_connection' structure
Date: Fri, 28 Feb 2014 12:27:26 +0900
Message-ID: <1393558072-25926-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BE84265071
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 04:28:15 +0100 (CET)
In-Reply-To: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This patch adds 'direction' member to 'cmp_connection' structure to indicate
the direction of connection. This patch also adds 'direction' argument to
cmp_connection_init() function to determine the direction.

The cmp_connection_init() function is exported and used in snd-firewire-speakers
so this patch also affect it.

This patch just add them. Actual implementation will be done by followed
patches.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c      | 3 ++-
 sound/firewire/cmp.h      | 7 +++++++
 sound/firewire/speakers.c | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index 17ad4f2..c7f7a31 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -94,6 +94,7 @@ static int pcr_modify(struct cmp_connection *c,
  */
 int cmp_connection_init(struct cmp_connection *c,
 			struct fw_unit *unit,
+			enum cmp_direction direction,
 			unsigned int pcr_index)
 {
 	__be32 mpr_be;
@@ -153,7 +154,7 @@ static __be32 ipcr_set_modify(struct cmp_connection *c, __be32 ipcr)
 static int pcr_set_check(struct cmp_connection *c, __be32 pcr)
 {
 	if (pcr & cpu_to_be32(PCR_BCAST_CONN |
-			       PCR_P2P_CONN_MASK)) {
+			      PCR_P2P_CONN_MASK)) {
 		cmp_error(c, "plug is already in use\n");
 		return -EBUSY;
 	}
diff --git a/sound/firewire/cmp.h b/sound/firewire/cmp.h
index 2320cd4..9b58448 100644
--- a/sound/firewire/cmp.h
+++ b/sound/firewire/cmp.h
@@ -7,6 +7,11 @@
 
 struct fw_unit;
 
+enum cmp_direction {
+	CMP_INPUT = 0,
+	CMP_OUTPUT,
+};
+
 /**
  * struct cmp_connection - manages an isochronous connection to a device
  * @speed: the connection's actual speed
@@ -26,10 +31,12 @@ struct cmp_connection {
 	__be32 last_pcr_value;
 	unsigned int pcr_index;
 	unsigned int max_speed;
+	enum cmp_direction direction;
 };
 
 int cmp_connection_init(struct cmp_connection *connection,
 			struct fw_unit *unit,
+			enum cmp_direction direction,
 			unsigned int pcr_index);
 void cmp_connection_destroy(struct cmp_connection *connection);
 
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index c07e7cd..4a9b48b 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -679,7 +679,7 @@ static int fwspk_probe(struct fw_unit *unit,
 	fwspk->unit = fw_unit_get(unit);
 	fwspk->device_info = (const struct device_info *)id->driver_data;
 
-	err = cmp_connection_init(&fwspk->connection, unit, 0);
+	err = cmp_connection_init(&fwspk->connection, unit, CMP_INPUT, 0);
 	if (err < 0)
 		goto err_unit;
 
-- 
1.8.3.2
