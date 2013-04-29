From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] Add "direction" member to cmp_connection structure
Date: Mon, 29 Apr 2013 18:44:02 +0900
Message-ID: <1367228643-8451-3-git-send-email-o-takashi@sakamocchi.jp>
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

To indicate the direction of connection, this patch adds "direction" member to
cmp_connection structure. To determine the direction, this patch also adds
"direction" argument to cmp_connection_init() function. The
cmp_connection_init() function is exported and used in snd-firewire-speakers so
this patch also affect it.

This patch just add them. Actual implementation will be done by followed
patches.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c      |    1 +
 sound/firewire/cmp.h      |    7 +++++++
 sound/firewire/speakers.c |    2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index ec6d341..a8d3d5f 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -102,6 +102,7 @@ bus_reset:
  */
 int cmp_connection_init(struct cmp_connection *c,
 			struct fw_unit *unit,
+			enum cmp_direction direction,
 			unsigned int pcr_index)
 {
 	__be32 mpr_be;
diff --git a/sound/firewire/cmp.h b/sound/firewire/cmp.h
index 2320cd4..4d26cc9 100644
--- a/sound/firewire/cmp.h
+++ b/sound/firewire/cmp.h
@@ -7,6 +7,11 @@
 
 struct fw_unit;
 
+enum cmp_direction {
+	CMP_OUTPUT = 0,
+	CMP_INPUT
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
index d684655..1e1f003 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -723,7 +723,7 @@ static int fwspk_probe(struct device *unit_dev)
 		goto err_unit;
 	}
 
-	err = cmp_connection_init(&fwspk->connection, unit, 0);
+	err = cmp_connection_init(&fwspk->connection, unit, CMP_INPUT, 0);
 	if (err < 0)
 		goto err_unit;
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
