From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: firewire-lib: add a restriction for
	a transaction at once
Date: Wed,  7 Oct 2015 09:19:36 +0900
Message-ID: <1444177179-8082-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1444177179-8082-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 11BAD2658D2
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 02:19:44 +0200 (CEST)
In-Reply-To: <1444177179-8082-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, when waiting for a response, callers can start another
transaction by scheduling another work. This is not good for error
processing of transaction, especially the first response is too late.

This commit serialize request/response transactions, by adding one
boolean member to represent idling state.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/lib.c | 9 +++++++++
 sound/firewire/lib.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 03ada3f..ddc3e88 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -76,6 +76,8 @@ static void async_midi_port_callback(struct fw_card *card, int rcode,
 
 	if (rcode == RCODE_COMPLETE && substream != NULL)
 		snd_rawmidi_transmit_ack(substream, port->consume_bytes);
+
+	port->idling = true;
 }
 
 static void midi_port_work(struct work_struct *work)
@@ -86,6 +88,10 @@ static void midi_port_work(struct work_struct *work)
 	int generation;
 	int type;
 
+	/* Under transacting. */
+	if (!port->idling)
+		return;
+
 	/* Nothing to do. */
 	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
 		return;
@@ -110,6 +116,8 @@ static void midi_port_work(struct work_struct *work)
 		type = TCODE_WRITE_BLOCK_REQUEST;
 
 	/* Start this transaction. */
+	port->idling = false;
+
 	/*
 	 * In Linux FireWire core, when generation is updated with memory
 	 * barrier, node id has already been updated. In this module, After
@@ -150,6 +158,7 @@ int snd_fw_async_midi_port_init(struct snd_fw_async_midi_port *port,
 	port->parent = fw_parent_device(unit);
 	port->addr = addr;
 	port->fill = fill;
+	port->idling = true;
 
 	INIT_WORK(&port->work, midi_port_work);
 
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index 37a7fe4..0af06f4 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -30,6 +30,7 @@ typedef int (*snd_fw_async_midi_port_fill)(
 struct snd_fw_async_midi_port {
 	struct fw_device *parent;
 	struct work_struct work;
+	bool idling;
 
 	u64 addr;
 	struct fw_transaction transaction;
-- 
2.1.4
