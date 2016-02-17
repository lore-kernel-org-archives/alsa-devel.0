From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: use workqueue instead of tasklet
	for scs1x
Date: Thu, 18 Feb 2016 01:24:36 +0900
Message-ID: <1455726276-31966-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 4700B26067A
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 17:24:41 +0100 (CET)
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

This commit replaces tasklet with workqueue for scs1x functionality of
ALSA oxfw driver.

This driver transfers MIDI message specific for SCS.1m and SCS.1d. This
task is currently done in software IRQ context of tasklet. In a view of
system, this context is limited resources and some important drivers (at
least, more important than ALSA oxfw driver) use the context as its
bottom-harf.

If the work to transfer MIDI messages is done within a time, it's better
to use the other context for the work. Actually, with recent CPUs, the
work will be scheduled within a time. This is a reason of this commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index bb53eb3..f7ac124 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -26,7 +26,7 @@ struct fw_scs1x {
 	u8 output_bytes;
 	bool output_escaped;
 	bool output_escape_high_nibble;
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 	wait_queue_head_t idle_wait;
 	u8 buffer[HSS1394_MAX_PACKET_SIZE];
 	bool transaction_running;
@@ -129,7 +129,7 @@ static void scs_write_callback(struct fw_card *card, int rcode,
 		;	/* TODO: retry this packet */
 
 	scs->transaction_running = false;
-	tasklet_schedule(&scs->tasklet);
+	schedule_work(&scs->work);
 }
 
 static bool is_valid_running_status(u8 status)
@@ -165,9 +165,9 @@ static bool is_invalid_cmd(u8 status)
 	       status == 0xfd;
 }
 
-static void scs_output_tasklet(unsigned long data)
+static void scs_output_work(struct work_struct *work)
 {
-	struct fw_scs1x *scs = (struct fw_scs1x *)data;
+	struct fw_scs1x *scs = container_of(work, struct fw_scs1x, work);
 	struct snd_rawmidi_substream *stream;
 	unsigned int i;
 	u8 byte;
@@ -311,7 +311,7 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *stream, int up)
 		scs->output_idle = false;
 
 		ACCESS_ONCE(scs->output) = stream;
-		tasklet_schedule(&scs->tasklet);
+		schedule_work(&scs->work);
 	} else {
 		ACCESS_ONCE(scs->output) = NULL;
 	}
@@ -395,7 +395,7 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
 			    &midi_playback_ops);
 
-	tasklet_init(&scs->tasklet, scs_output_tasklet, (unsigned long)scs);
+	INIT_WORK(&scs->work, scs_output_work);
 	init_waitqueue_head(&scs->idle_wait);
 	scs->output_idle = true;
 
-- 
2.5.0
