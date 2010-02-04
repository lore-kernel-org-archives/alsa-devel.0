From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH] Delay switching to polling mode if an
	interrupt was missing
Date: Thu,  4 Feb 2010 22:21:47 +0200
Message-ID: <1265314907-19502-1-git-send-email-maximlevitsky@gmail.com>
References: <1265314817.19186.8.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f221.google.com (mail-bw0-f221.google.com
	[209.85.218.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EDFC10384B
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 21:22:02 +0100 (CET)
Received: by bwz21 with SMTP id 21so2580875bwz.4
	for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2010 12:22:01 -0800 (PST)
In-Reply-To: <1265314817.19186.8.camel@maxim-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: alsa-devel@alsa-project.org

My sound codec seems sometimes (very rarely) to omit interrupts (ALC268)
However, interrupt mode still works.
Thus if we get timeout, poll the codec once.

If we get 3 such polls in a row, then switch to polling mode.

This patch is maybe an bandaid, but this might be a workaround for hardware bug.

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 sound/pci/hda/hda_intel.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ec9c348..11ce655 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -426,6 +426,7 @@ struct azx {
 
 	/* flags */
 	int position_fix;
+	int poll_count;
 	unsigned int running :1;
 	unsigned int initialized :1;
 	unsigned int single_cmd :1;
@@ -506,7 +507,7 @@ static char *driver_short_names[] __devinitdata = {
 #define get_azx_dev(substream) (substream->runtime->private_data)
 
 static int azx_acquire_irq(struct azx *chip, int do_disconnect);
-
+static int azx_send_cmd(struct hda_bus *bus, unsigned int val);
 /*
  * Interface for HD codec
  */
@@ -664,11 +665,12 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 {
 	struct azx *chip = bus->private_data;
 	unsigned long timeout;
+	int do_poll = 0;
 
  again:
 	timeout = jiffies + msecs_to_jiffies(1000);
 	for (;;) {
-		if (chip->polling_mode) {
+		if (chip->polling_mode || do_poll) {
 			spin_lock_irq(&chip->reg_lock);
 			azx_update_rirb(chip);
 			spin_unlock_irq(&chip->reg_lock);
@@ -676,6 +678,9 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		if (!chip->rirb.cmds[addr]) {
 			smp_rmb();
 			bus->rirb_error = 0;
+
+			if (!do_poll)
+				chip->poll_count = 0;
 			return chip->rirb.res[addr]; /* the last value */
 		}
 		if (time_after(jiffies, timeout))
@@ -688,6 +693,16 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		}
 	}
 
+	if (!chip->polling_mode && chip->poll_count < 2) {
+		snd_printd(SFX "azx_get_response timeout, "
+			   "polling the codec once: last cmd=0x%08x\n",
+			   chip->last_cmd[addr]);
+		do_poll = 1;
+		chip->poll_count++;
+		goto again;
+	}
+
+
 	if (!chip->polling_mode) {
 		snd_printk(KERN_WARNING SFX "azx_get_response timeout, "
 			   "switching to polling mode: last cmd=0x%08x\n",
-- 
1.6.3.3
