From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] fireworks: serialize transactions to update
	connections at bus reset
Date: Sat, 20 Feb 2016 16:41:01 +0900
Message-ID: <1455954061-18816-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F303261298
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 08:41:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In IEC 61883-1, at bus-reset, applications can continue isochronous
streaming by updating connections. In ALSA fireworks driver, the
operation is executed in 'update' handler for bus driver.

The connection resources are also changed in process contexts of PCM/MIDI
applications. Therefore, bus-reset handling has race condition
against connection. Current ALSA fireworks driver has a bug for the
condition.

This commit fixes the bug, by expand critical section with mutex. As a
result, connection updating operation in bus-reset handler and connection
changing operation in process context are serialized.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks.c        | 3 +++
 sound/firewire/fireworks/fireworks_stream.c | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index d5b19bc..8f27b67 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -301,7 +301,10 @@ static void efw_update(struct fw_unit *unit)
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
 
 	snd_efw_transaction_bus_reset(efw->unit);
+
+	mutex_lock(&efw->mutex);
 	snd_efw_stream_update_duplex(efw);
+	mutex_unlock(&efw->mutex);
 }
 
 static void efw_remove(struct fw_unit *unit)
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 968a40a..425db8d 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -313,12 +313,10 @@ void snd_efw_stream_stop_duplex(struct snd_efw *efw)
 
 void snd_efw_stream_update_duplex(struct snd_efw *efw)
 {
-	if ((cmp_connection_update(&efw->out_conn) < 0) ||
-	    (cmp_connection_update(&efw->in_conn) < 0)) {
-		mutex_lock(&efw->mutex);
+	if (cmp_connection_update(&efw->out_conn) < 0 ||
+	    cmp_connection_update(&efw->in_conn) < 0) {
 		stop_stream(efw, &efw->rx_stream);
 		stop_stream(efw, &efw->tx_stream);
-		mutex_unlock(&efw->mutex);
 	} else {
 		amdtp_stream_update(&efw->rx_stream);
 		amdtp_stream_update(&efw->tx_stream);
-- 
2.5.0
