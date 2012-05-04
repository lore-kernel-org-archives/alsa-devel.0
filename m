From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Lessen CPU usage when waiting for
	chip to respond
Date: Fri,  4 May 2012 11:05:55 +0200
Message-ID: <1336122355-6017-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 838E22462A
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2012 11:05:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: arun.raghavan@collabora.co.uk
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When an IRQ for some reason gets lost, we wait up to a second using
udelay, which is CPU intensive. This patch improves the situation by
waiting about 30 ms in the CPU intensive mode, then stepping down to
using msleep(2) instead. In essence, we trade some granularity in
exchange for less CPU consumption when the waiting time is a bit longer.

As a result, PulseAudio should no longer be killed by the kernel
for taking up to much RT-prio CPU time. At least not for *this* reason.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Hi Arun,

Can you check if this patch resolves your problem with PulseAudio getting
killed by the kernel? If so, we should apply it to the kernel, perhaps even
to stable.

// David


diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7b6a823..0e7c3f1 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -783,11 +783,13 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 {
 	struct azx *chip = bus->private_data;
 	unsigned long timeout;
+	unsigned long loopcounter;
 	int do_poll = 0;
 
  again:
 	timeout = jiffies + msecs_to_jiffies(1000);
-	for (;;) {
+	
+	for (loopcounter = 0;; loopcounter++) {
 		if (chip->polling_mode || do_poll) {
 			spin_lock_irq(&chip->reg_lock);
 			azx_update_rirb(chip);
@@ -803,7 +805,7 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		}
 		if (time_after(jiffies, timeout))
 			break;
-		if (bus->needs_damn_long_delay)
+		if (bus->needs_damn_long_delay || loopcounter > 3000)
 			msleep(2); /* temporary workaround */
 		else {
 			udelay(10);
-- 
1.7.9.5
