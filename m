From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/6] ALSA: seq-dummy: remove deadlock-causing
	events on close
Date: Sun, 25 Jan 2015 14:34:29 +0100
Message-ID: <54C4F0E5.8030205@ladisch.de>
References: <54C4F0A1.2000907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 807F6260438
 for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2015 14:34:31 +0100 (CET)
In-Reply-To: <54C4F0A1.2000907@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When the last subscriber to a "Through" port has been removed, the
subscribed destination ports might still be active, so it would be
wrong to send "all sounds off" and "reset controller" events to them.
The proper place for such a shutdown would be the closing of the actual
MIDI port (and close_substream() in rawmidi.c already can do this).

This also fixes a deadlock when dummy_unuse() tries to send events to
its own port that is already locked because it is being freed.

Reported-by: Peter Billam <peter@www.pjb.com.au>
Fixes: 1da177e4c3f4
Cc: <stable@vger.kernel.org>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/seq/seq_dummy.c |   31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/sound/core/seq/seq_dummy.c b/sound/core/seq/seq_dummy.c
index ec667f1..5d905d9 100644
--- a/sound/core/seq/seq_dummy.c
+++ b/sound/core/seq/seq_dummy.c
@@ -82,36 +82,6 @@ struct snd_seq_dummy_port {
 static int my_client = -1;

 /*
- * unuse callback - send ALL_SOUNDS_OFF and RESET_CONTROLLERS events
- * to subscribers.
- * Note: this callback is called only after all subscribers are removed.
- */
-static int
-dummy_unuse(void *private_data, struct snd_seq_port_subscribe *info)
-{
-	struct snd_seq_dummy_port *p;
-	int i;
-	struct snd_seq_event ev;
-
-	p = private_data;
-	memset(&ev, 0, sizeof(ev));
-	if (p->duplex)
-		ev.source.port = p->connect;
-	else
-		ev.source.port = p->port;
-	ev.dest.client = SNDRV_SEQ_ADDRESS_SUBSCRIBERS;
-	ev.type = SNDRV_SEQ_EVENT_CONTROLLER;
-	for (i = 0; i < 16; i++) {
-		ev.data.control.channel = i;
-		ev.data.control.param = MIDI_CTL_ALL_SOUNDS_OFF;
-		snd_seq_kernel_client_dispatch(p->client, &ev, 0, 0);
-		ev.data.control.param = MIDI_CTL_RESET_CONTROLLERS;
-		snd_seq_kernel_client_dispatch(p->client, &ev, 0, 0);
-	}
-	return 0;
-}
-
-/*
  * event input callback - just redirect events to subscribers
  */
 static int
@@ -175,7 +145,6 @@ create_port(int idx, int type)
 		| SNDRV_SEQ_PORT_TYPE_PORT;
 	memset(&pcb, 0, sizeof(pcb));
 	pcb.owner = THIS_MODULE;
-	pcb.unuse = dummy_unuse;
 	pcb.event_input = dummy_input;
 	pcb.private_free = dummy_free;
 	pcb.private_data = rec;
