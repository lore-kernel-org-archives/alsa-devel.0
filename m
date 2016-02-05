From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: firewire-tascam: fix NULL pointer
	dereference when model identification fails
Date: Fri,  5 Feb 2016 09:56:05 +0900
Message-ID: <1454633768-17729-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1454633768-17729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EDAA2605D2
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 01:56:13 +0100 (CET)
In-Reply-To: <1454633768-17729-1-git-send-email-o-takashi@sakamocchi.jp>
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

When unsupported models are connected, snd-firewire-tascam module causes
NULL pointer dereference in fw_core_remove_address_handler() (due to
list_del_rcu()).

This commit prevents this bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-transaction.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
index 904ce03..040a96d 100644
--- a/sound/firewire/tascam/tascam-transaction.c
+++ b/sound/firewire/tascam/tascam-transaction.c
@@ -230,6 +230,7 @@ int snd_tscm_transaction_register(struct snd_tscm *tscm)
 	return err;
 error:
 	fw_core_remove_address_handler(&tscm->async_handler);
+	tscm->async_handler.callback_data = NULL;
 	return err;
 }
 
@@ -276,6 +277,9 @@ void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
 	__be32 reg;
 	unsigned int i;
 
+	if (tscm->async_handler.callback_data == NULL)
+		return;
+
 	/* Turn off FireWire LED. */
 	reg = cpu_to_be32(0x0000008e);
 	snd_fw_transaction(tscm->unit, TCODE_WRITE_QUADLET_REQUEST,
@@ -297,6 +301,8 @@ void snd_tscm_transaction_unregister(struct snd_tscm *tscm)
 			   &reg, sizeof(reg), 0);
 
 	fw_core_remove_address_handler(&tscm->async_handler);
+	tscm->async_handler.callback_data = NULL;
+
 	for (i = 0; i < TSCM_MIDI_OUT_PORT_MAX; i++)
 		snd_fw_async_midi_port_destroy(&tscm->out_ports[i]);
 }
-- 
2.5.0
