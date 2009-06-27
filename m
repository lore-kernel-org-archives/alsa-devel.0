From: Ondrej Zary <linux@rainbow-software.org>
Subject: [RFC] cmi8330: Add basic CMI8329 support
Date: Sat, 27 Jun 2009 17:07:31 +0200
Message-ID: <200906271707.32687.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail.atlantis.sk [80.94.52.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CE2024720
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 17:07:37 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add basic support for CMI8329 cards. It seems to be very similar to CMI8330,
but the PnP devices are different:
 - AD1848 (WSS) and SB16 device IDs are swapped
 - the OPL3 port is contained in SB16 device, not AD1848 (WSS)
 - there is A@@0001 device (looks like some control interface - it has only
   one 8-bit I/O address)

Is my detection code correct, shouldn't the struct pnp_dev returned
pnp_request_card_device() be released somehow?

Also the mixer seems to be a bit different - master volume does not work
currently.

My card includes wavetable MIDI - it works in Windows when MPU-401 is
selected. It does not work with this driver - pmidi plays but no sound
comes out. OPL3 works.

My card has also an IDE interface but it's not visible as PnP device and
it does not work even in Windows (and I'm unable to find any driver for it
for any OS).

Here's a scan of the card: http://www.rainbow-software.org/images/hardware/cmi8329a_.jpg
The main chip is labelled AD Chips CMI8329A.


--- linux-test/sound/isa/cmi8330.c	2009-06-27 16:32:13.000000000 +0200
+++ linux-2.6.30-pentium/sound/isa/cmi8330.c	2009-06-27 16:33:25.000000000 +0200
@@ -156,6 +156,11 @@
 
 typedef int (*snd_pcm_open_callback_t)(struct snd_pcm_substream *);
 
+enum card_type {
+	CMI8329,
+	CMI8330
+};
+
 struct snd_cmi8330 {
 #ifdef CONFIG_PNP
 	struct pnp_dev *cap;
@@ -172,6 +177,8 @@
 		snd_pcm_open_callback_t open;
 		void *private_data; /* sb or wss */
 	} streams[2];
+
+	enum card_type type;
 };
 
 #ifdef CONFIG_PNP
@@ -328,12 +335,26 @@
 {
 	struct pnp_dev *pdev;
 	int err;
+	const char *sb16_id, *wss_id;
+
+	/* CMI8329 has a device with ID A@@0001, CMI8330 does not */
+	pdev = pnp_request_card_device(card, "A@@0001", NULL);
+	if (pdev) {
+		acard->type = CMI8329;
+		pnp_release_card_device(pdev);
+		sb16_id = id->devs[0].id;
+		wss_id = id->devs[1].id;
+	} else {
+		acard->type = CMI8330;
+		sb16_id = id->devs[1].id;
+		wss_id = id->devs[0].id;
+	}
 
-	acard->cap = pnp_request_card_device(card, id->devs[0].id, NULL);
+	acard->cap = pnp_request_card_device(card, wss_id, NULL);
 	if (acard->cap == NULL)
 		return -EBUSY;
 
-	acard->play = pnp_request_card_device(card, id->devs[1].id, NULL);
+	acard->play = pnp_request_card_device(card, sb16_id, NULL);
 	if (acard->play == NULL)
 		return -EBUSY;
 
@@ -351,7 +372,8 @@
 	wssport[dev] = pnp_port_start(pdev, 0);
 	wssdma[dev] = pnp_dma(pdev, 0);
 	wssirq[dev] = pnp_irq(pdev, 0);
-	fmport[dev] = pnp_port_start(pdev, 1);
+	if (acard->type == CMI8330)
+		fmport[dev] = pnp_port_start(pdev, 1);
 
 	/* allocate SB16 resources */
 	pdev = acard->play;
@@ -365,6 +387,8 @@
 	sbdma8[dev] = pnp_dma(pdev, 0);
 	sbdma16[dev] = pnp_dma(pdev, 1);
 	sbirq[dev] = pnp_irq(pdev, 0);
+	if (acard->type == CMI8329)
+		fmport[dev] = pnp_port_start(pdev, 1);
 
 	/* allocate MPU-401 resources */
 	pdev = acard->mpu;

-- 
Ondrej Zary
