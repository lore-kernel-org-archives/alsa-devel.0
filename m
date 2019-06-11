From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/12] ALSA: dice: update isochronous resources
	when starting packet streaming after bus-reset
Date: Tue, 11 Jun 2019 22:21:17 +0900
Message-ID: <20190611132118.8378-12-o-takashi@sakamocchi.jp>
References: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36D74F8973D
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 15:21:44 +0200 (CEST)
In-Reply-To: <20190611132118.8378-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

After bus reset, isochronous resource manager releases all of allocated
isochronous resources. The nodes to transfer isochronous packet should
request reallocation of the resources.

However, between the bus-reset and invocation of 'struct fw_driver.update'
handler, ALSA PCM application can detect this situation by XRUN because
the target device cancelled to transmit packets once bus-reset occurs.

Due to the above mechanism, ALSA fireface driver just stops packet
streaming in the update handler, thus pcm.prepare handler should
request the reallocation.

This commit requests the reallocation in pcm.prepare callback when
bus generation is changed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 6bbf7421a53c..f61b99a72655 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -399,6 +399,7 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
  */
 int snd_dice_stream_start_duplex(struct snd_dice *dice)
 {
+	unsigned int generation = dice->rx_resources[0].generation;
 	struct reg_params tx_params, rx_params;
 	unsigned int i;
 	unsigned int rate;
@@ -421,6 +422,15 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice)
 		}
 	}
 
+	if (generation != fw_parent_device(dice->unit)->card->generation) {
+		for (i = 0; i < MAX_STREAMS; ++i) {
+			if (i < tx_params.count)
+				fw_iso_resources_update(dice->tx_resources + i);
+			if (i < rx_params.count)
+				fw_iso_resources_update(dice->rx_resources + i);
+		}
+	}
+
 	// Check required streams are running or not.
 	err = snd_dice_transaction_get_rate(dice, &rate);
 	if (err < 0)
-- 
2.20.1
