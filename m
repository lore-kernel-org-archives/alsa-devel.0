From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/39] firewire-lib: Add a new function to
	check others' connection
Date: Wed,  5 Mar 2014 19:48:03 +0900
Message-ID: <1394016507-15761-16-git-send-email-o-takashi@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BDBC26530F
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 11:49:03 +0100 (CET)
In-Reply-To: <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
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

Plug Control Registers have two fields related to the number of established
connections, one is 'Broadcast connection counter' and another is
'Point-to-point connection counter'. The driver can know there are established
connections or not to check these fields.

This is considering for JACK/FFADO streaming. Currently, when JACK/FFADO starts
its streaming to the device, cmp_connection_establish() is failed expectedly.
This seems to be enough but there are some devices which needs to change
samplling frequency before trying to establish connections. For such devices,
this functionality is needed.
---
 sound/firewire/cmp.c | 18 ++++++++++++++++++
 sound/firewire/cmp.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index 60d2e17..a8199fd 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -155,6 +155,24 @@ int cmp_connection_init(struct cmp_connection *c,
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
