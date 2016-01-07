From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/6] [ALSA] portman2x4 - fix trailing whitespace
Date: Thu,  7 Jan 2016 12:45:46 +0530
Message-ID: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Trailing whitespace is not encouraged by Kernel coding style.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/portman2x4.c | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 464385a..ba0860d 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -57,7 +57,7 @@ static int index[SNDRV_CARDS]  = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS]   = SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
 
-static struct platform_device *platform_devices[SNDRV_CARDS]; 
+static struct platform_device *platform_devices[SNDRV_CARDS];
 static int device_count;
 
 module_param_array(index, int, NULL, S_IRUGO);
@@ -105,7 +105,7 @@ static int portman_create(struct snd_card *card,
 	*rchip = NULL;
 
 	pm = kzalloc(sizeof(struct portman), GFP_KERNEL);
-	if (pm == NULL) 
+	if (pm == NULL)
 		return -ENOMEM;
 
 	/* Init chip specific data */
@@ -140,7 +140,7 @@ static int portman_create(struct snd_card *card,
 #define	INT_EN	 	PP_CMD_IEN	/* Interrupt enable. */
 #define	STROBE	        PP_CMD_STB	/* Command strobe. */
 
-/* The parallel port command register field (b1..b3) selects the 
+/* The parallel port command register field (b1..b3) selects the
  * various "registers" within the PC/P 2x4.  These are the internal
  * address of these "registers" that must be written to the parallel
  * port command register.
@@ -218,7 +218,7 @@ static inline void portman_write_data(struct portman *pm, u8 value)
 	parport_write_data(pm->pardev->port, value);
 }
 
-static void portman_write_midi(struct portman *pm, 
+static void portman_write_midi(struct portman *pm,
 			       int port, u8 mididata)
 {
 	int command = ((port + 4) << 1);
@@ -234,20 +234,20 @@ static void portman_write_midi(struct portman *pm,
 	 */
 	command |= INT_EN;
 
-	/* Disable interrupts so that the process is not interrupted, then 
-	 * write the address associated with the current Tx channel to the 
+	/* Disable interrupts so that the process is not interrupted, then
+	 * write the address associated with the current Tx channel to the
 	 * PP Command Reg.  Do not set the Strobe signal yet.
 	 */
 
 	do {
 		portman_write_command(pm, command);
 
-		/* While the address lines settle, write parallel output data to 
+		/* While the address lines settle, write parallel output data to
 		 * PP Data Reg.  This has no effect until Strobe signal is asserted.
 		 */
 
 		portman_write_data(pm, mididata);
-		
+
 		/* If PCP channel's TxEmpty is set (TxEmpty is read through the PP
 		 * Status Register), then go write data.  Else go back and wait.
 		 */
@@ -370,7 +370,7 @@ static int portman_read_midi(struct portman *pm, int port)
 
 /*
  *  Checks if any input data on the given channel is available
- *  Checks RxAvail 
+ *  Checks RxAvail
  */
 static int portman_data_avail(struct portman *pm, int channel)
 {
@@ -456,7 +456,7 @@ static int portman_probe(struct parport *p)
 	 * hardware handshake lines to midi box:
 	 *
 	 *                                  Strobe = 0
-	 *                                  Interrupt Enable = 0            
+	 *                                  Interrupt Enable = 0
 	 */
 	/* 2 */
 	parport_write_control(p, 0);
@@ -481,7 +481,7 @@ static int portman_probe(struct parport *p)
 	/* 7 */
 	parport_write_control(p, 0);	/* Reset Strobe=0. */
 
-	/* Check if Tx circuitry is functioning properly.  If initialized 
+	/* Check if Tx circuitry is functioning properly.  If initialized
 	 * unit TxEmpty is false, send out char and see if if goes true.
 	 */
 	/* 8 */
@@ -567,12 +567,12 @@ static int snd_portman_rawmidi_create(struct snd_card *card)
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_substream *substream;
 	int err;
-	
-	err = snd_rawmidi_new(card, CARD_NAME, 0, 
-			      PORTMAN_NUM_OUTPUT_PORTS, 
-			      PORTMAN_NUM_INPUT_PORTS, 
+
+	err = snd_rawmidi_new(card, CARD_NAME, 0,
+			      PORTMAN_NUM_OUTPUT_PORTS,
+			      PORTMAN_NUM_INPUT_PORTS,
 			      &rmidi);
-	if (err < 0) 
+	if (err < 0)
 		return err;
 
 	rmidi->private_data = pm;
@@ -584,9 +584,9 @@ static int snd_portman_rawmidi_create(struct snd_card *card)
 	pm->rmidi = rmidi;
 
 	/* register rawmidi ops */
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, 
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
 			    &snd_portman_midi_output);
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, 
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
 			    &snd_portman_midi_input);
 
 	/* name substreams */
@@ -621,7 +621,7 @@ static void snd_portman_interrupt(void *userdata)
 
 	/* While any input data is waiting */
 	while ((portman_read_status(pm) & INT_REQ) == INT_REQ) {
-		/* If data available on channel 0, 
+		/* If data available on channel 0,
 		   read it and stuff it into the queue. */
 		if (portman_data_avail(pm, 0)) {
 			/* Read Midi */
@@ -632,7 +632,7 @@ static void snd_portman_interrupt(void *userdata)
 						    &midivalue, 1);
 
 		}
-		/* If data available on channel 1, 
+		/* If data available on channel 1,
 		   read it and stuff it into the queue. */
 		if (portman_data_avail(pm, 1)) {
 			/* Read Midi */
@@ -658,7 +658,7 @@ static int snd_portman_probe_port(struct parport *p)
 					 0, NULL);
 	if (!pardev)
 		return -EIO;
-	
+
 	if (parport_claim(pardev)) {
 		parport_unregister_device(pardev);
 		return -EIO;
@@ -742,7 +742,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
-	if (!enable[dev]) 
+	if (!enable[dev])
 		return -ENOENT;
 
 	if ((err = snd_portman_probe_port(p)) < 0)
@@ -756,7 +756,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 	}
 	strcpy(card->driver, DRIVER_NAME);
 	strcpy(card->shortname, CARD_NAME);
-	sprintf(card->longname,  "%s at 0x%lx, irq %i", 
+	sprintf(card->longname,  "%s at 0x%lx, irq %i",
 		card->shortname, p->base, p->irq);
 
 	pardev = parport_register_device(p,                     /* port */
@@ -779,7 +779,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 	}
 	card->private_data = pm;
 	card->private_free = snd_portman_card_private_free;
-	
+
 	if ((err = snd_portman_rawmidi_create(card)) < 0) {
 		snd_printd("Creating Rawmidi component failed\n");
 		goto __err;
@@ -844,7 +844,7 @@ static void snd_portman_unregister_all(void)
 			platform_device_unregister(platform_devices[i]);
 			platform_devices[i] = NULL;
 		}
-	}		
+	}
 	platform_driver_unregister(&snd_portman_driver);
 	parport_unregister_driver(&portman_parport_driver);
 }
-- 
1.9.1
