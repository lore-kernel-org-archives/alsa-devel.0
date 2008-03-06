From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: [RFC] add a "private" field to the ac97 struct
Date: Thu, 6 Mar 2008 17:42:11 +0100
Message-ID: <20080306164211.GA8205@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	by alsa0.perex.cz (Postfix) with ESMTP id BF7D6103857
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 17:42:15 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Nicolas Pitre <nico@cam.org>
List-Id: alsa-devel@alsa-project.org

I have a PowerPC board with an AC97 controller and that one has an
UCB1400 attached.
Currently the UCB1400 driver discovers the interrupt via probing. This
doesn't really work here. The resources are read from the device tree.
I haven't found any other driver besides ucb1400_ts that uses the
ac97_bus_type so I can't check where others get their HW information
from.

My proposal is to introduce a new field in struct snd_ac97 where the
AC97 driver can leave the required HW info regarding the attached (in my
case the interrupt for the ucb1400) before calling snd_card_register().
I attached just a single int field since I am not aware if multiple
devices / resource are realistic / possible. In that case maybe a void *
or struct platform_device would be a better choice.

Signed-off-by: Sebastian Siewior <sebastian@breakpoint.cc>
---
 drivers/input/touchscreen/ucb1400_ts.c |   13 ++++++++-----
 include/sound/ac97_codec.h             |    2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 607f993..95d1fea 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -492,11 +492,14 @@ static int ucb1400_ts_probe(struct device *dev)
 		goto err_free_devs;
 	}
 
-	error = ucb1400_detect_irq(ucb);
-	if (error) {
-		printk(KERN_ERR "UCB1400: IRQ probe failed\n");
-		goto err_free_devs;
-	}
+	if (!ucb->ac97->device_irq) {
+		error = ucb1400_detect_irq(ucb);
+		if (error) {
+			printk(KERN_ERR "UCB1400: IRQ probe failed\n");
+			goto err_free_devs;
+		}
+	} else
+		ucb->irq = ucb->ac97->device_irq;
 
 	error = request_irq(ucb->irq, ucb1400_hard_irq, IRQF_TRIGGER_RISING,
 				"UCB1400", ucb);
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 0148058..bf920a2 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -474,6 +474,8 @@ struct snd_ac97 {
 	struct snd_ac97_build_ops * build_ops;
 	void *private_data;
 	void (*private_free) (struct snd_ac97 *ac97);
+	/* device attached to the AC97 bus */
+	int device_irq;
 	/* --- */
 	struct snd_ac97_bus *bus;
 	struct pci_dev *pci;	/* assigned PCI device - used for quirks */
-- 
1.5.3.5
