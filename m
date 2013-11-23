From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/17] firewire-lib: Add 'direction' member to
	'cmp_connection' structure
Date: Sat, 23 Nov 2013 15:08:00 +0900
Message-ID: <1385186884-8259-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id CE43B2651C9
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

This patch adds 'direction' member to 'cmp_connection' structure to indicate
the direction of connection. This patch also adds 'direction' argument to
cmp_connection_init() function to determine the direction.

The cmp_connection_init() function is exported and used in snd-firewire-speakers
so this patch also affect it.

This patch just add them. Actual implementation will be done by followed
patches.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c      | 1 +
 sound/firewire/cmp.h      | 7 +++++++
 sound/firewire/speakers.c | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index 17ad4f2..1430fec 100644
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
index 8f0257e..d548376 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -680,7 +680,7 @@ static int fwspk_probe(struct fw_unit *unit,
 	fwspk->unit = fw_unit_get(unit);
 	fwspk->device_info = (const struct device_info *)id->driver_data;
 
-	err = cmp_connection_init(&fwspk->connection, unit, 0);
+	err = cmp_connection_init(&fwspk->connection, unit, CMP_INPUT, 0);
 	if (err < 0)
 		goto err_unit;
 
-- 
1.8.3.2
