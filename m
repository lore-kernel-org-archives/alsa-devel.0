From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/52] firewire-lib: Add a new function to check others'
	connection
Date: Wed, 29 Jan 2014 22:44:22 +0900
Message-ID: <1391003099-7109-16-git-send-email-o-takashi@sakamocchi.jp>
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

Plug Control Registers have two fields related to the number of established
connections, one is 'Broadcast connection counter' and another is
'Point-to-point connection counter'. The driver can know there are established
connections or not to check these fields.

This is considering for JACK/FFADO streaming. Currently, when JACK/FFADO starts
its streaming to the device, cmp_connection_establish() is failed expectedly.
This seems to be enough but there are some devices which needs to change
samplling frequency before trying to establish connections. For such devices,
this functionality is needed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c | 18 ++++++++++++++++++
 sound/firewire/cmp.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index 00b1b2d..354920a 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -157,6 +157,24 @@ int cmp_connection_init(struct cmp_connection *c,
 EXPORT_SYMBOL(cmp_connection_init);
 
 /**
+ * cmp_connection_check_used - check connection is already esablished or not
+ * @c: the connection manager to be checked
+ */
+int cmp_connection_check_used(struct cmp_connection *c, bool *used)
+{
+	__be32 pcr;
+	int err;
+
+	err = snd_fw_transaction(
+			c->resources.unit, TCODE_READ_QUADLET_REQUEST,
+			get_offset(c, false), &pcr, 4, 0);
+	if (err >= 0)
+		*used = (pcr & cpu_to_be32(PCR_BCAST_CONN | PCR_P2P_CONN_MASK));
+	return err;
+}
+EXPORT_SYMBOL(cmp_connection_check_used);
+
+/**
  * cmp_connection_destroy - free connection manager resources
  * @c: the connection manager
  */
diff --git a/sound/firewire/cmp.h b/sound/firewire/cmp.h
index 9b58448..ebcb484 100644
--- a/sound/firewire/cmp.h
+++ b/sound/firewire/cmp.h
@@ -38,6 +38,7 @@ int cmp_connection_init(struct cmp_connection *connection,
 			struct fw_unit *unit,
 			enum cmp_direction direction,
 			unsigned int pcr_index);
+int cmp_connection_check_used(struct cmp_connection *connection, bool *used);
 void cmp_connection_destroy(struct cmp_connection *connection);
 
 int cmp_connection_establish(struct cmp_connection *connection,
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
