From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] ALSA: off by one bug in
	snd_riptide_joystick_probe()
Date: Mon, 9 Feb 2015 16:51:40 +0300
Message-ID: <20150209135139.GA26866@mwanda>
References: <s5hy4ogfvc2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 31BD52605AB
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 14:50:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy4ogfvc2.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Benoit Taine <benoit.taine@lip6.fr>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Hans Wennborg <hans@hanshq.net>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: alsa-devel@alsa-project.org

The problem here is that we check:

	if (dev >= SNDRV_CARDS)

Then we increment "dev".

       if (!joystick_port[dev++])

Then we use it as an offset into a array with SNDRV_CARDS elements.

	if (!request_region(joystick_port[dev], 8, "Riptide gameport")) {

This has 3 effects:
1) If you use the module option to specify the joystick port then it has
   to be shifted one space over.
2) The wrong error message will be printed on failure if you have over
   32 cards.
3) Static checkers will correctly complain that are off by one.

Fixes: db1005ec6ff8 ('ALSA: riptide - Fix joystick resource handling')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: In the original patch I just made the array larger.

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 29f2827..94639d6 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -2011,32 +2011,43 @@ snd_riptide_joystick_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	static int dev;
 	struct gameport *gameport;
+	int ret;
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
+
 	if (!enable[dev]) {
-		dev++;
-		return -ENOENT;
+		ret = -ENOENT;
+		goto inc_dev;
 	}
 
-	if (!joystick_port[dev++])
-		return 0;
+	if (!joystick_port[dev]) {
+		ret = 0;
+		goto inc_dev;
+	}
 
 	gameport = gameport_allocate_port();
-	if (!gameport)
-		return -ENOMEM;
+	if (!gameport) {
+		ret = -ENOMEM;
+		goto inc_dev;
+	}
 	if (!request_region(joystick_port[dev], 8, "Riptide gameport")) {
 		snd_printk(KERN_WARNING
 			   "Riptide: cannot grab gameport 0x%x\n",
 			   joystick_port[dev]);
 		gameport_free_port(gameport);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto inc_dev;
 	}
 
 	gameport->io = joystick_port[dev];
 	gameport_register_port(gameport);
 	pci_set_drvdata(pci, gameport);
-	return 0;
+
+	ret = 0;
+inc_dev:
+	dev++;
+	return ret;
 }
 
 static void snd_riptide_joystick_remove(struct pci_dev *pci)
