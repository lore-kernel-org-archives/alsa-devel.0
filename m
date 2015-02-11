From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: seq: potential out of bounds in
	do_control()
Date: Wed, 11 Feb 2015 18:10:54 +0300
Message-ID: <20150211151054.GA30155@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 754692605D0
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 16:10:05 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Smatch complains that "control" is user specifigy and needs to be
capped.  The call tree to understand this warning is quite long.

snd_seq_write()  <-- get the event from the user
  snd_seq_client_enqueue_event()
    snd_seq_deliver_event()
      deliver_to_subscribers()
        snd_seq_deliver_single_event()
          snd_opl3_oss_event_input()
            snd_midi_process_event()
              do_control()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I have spent some time reviewing this code, but I may have missed
something where we verify that control is in bounds.  I'm not very
familiar with this code and the call tree is fairly long.

diff --git a/sound/core/seq/seq_midi_emul.c b/sound/core/seq/seq_midi_emul.c
index 9b6470c..7ba9373 100644
--- a/sound/core/seq/seq_midi_emul.c
+++ b/sound/core/seq/seq_midi_emul.c
@@ -269,6 +269,9 @@ do_control(struct snd_midi_op *ops, void *drv, struct snd_midi_channel_set *chse
 {
 	int  i;
 
+	if (control >= ARRAY_SIZE(chan->control))
+		return;
+
 	/* Switches */
 	if ((control >=64 && control <=69) || (control >= 80 && control <= 83)) {
 		/* These are all switches; either off or on so set to 0 or 127 */
