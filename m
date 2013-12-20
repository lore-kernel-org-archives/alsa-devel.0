From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/38] firewire-lib: Add 'direction' member to
	'cmp_connection' structure
Date: Fri, 20 Dec 2013 22:14:04 +0900
Message-ID: <1387545269-3875-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
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
index 28147ef..afbaa55 100644
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


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
