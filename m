From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix names for MPU-401 ports
Date: Mon, 26 Jan 2004 10:07:03 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401261004380.6589-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This moves the initialization of card->shortname before the
component creation so that the name for the rawmidi port is
"<shortname> MPU-401" instead of "MPU-401 (UART) x-0".


Index: alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl,v
retrieving revision 1.21
diff -u -r1.21 writing-an-alsa-driver.tmpl
--- alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl	20 Jan 2004 16:15:02 -0000	1.21
+++ alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl	26 Jan 2004 09:00:11 -0000
@@ -496,14 +496,14 @@
           }

           // (4)
-          // implemented later
-
-          // (5)
           strcpy(card->driver, "My Chip");
           strcpy(card->shortname, "My Own Chip 123");
           sprintf(card->longname, "%s at 0x%lx irq %i",
                   card->shortname, chip->ioport, chip->irq);

+          // (5)
+          // implemented later
+
           // (6)
           if ((err = snd_card_register(card)) < 0) {
                   snd_card_free(card);
@@ -622,21 +622,8 @@
         </para>
       </section>

-      <section id="basic-flow-constructor-create-other">
-        <title>4) Create other components, such as mixer, MIDI, etc.</title>
-        <para>
-          Here you define the basic components such as
-          <link linkend="pcm-interface"><citetitle>PCM</citetitle></link>,
-          mixer (e.g. <link linkend="api-ac97"><citetitle>AC97</citetitle></link>),
-          MIDI (e.g. <link linkend="midi-interface"><citetitle>MPU-401</citetitle></link>),
-          and other interfaces.
-          Also, if you want a <link linkend="proc-interface"><citetitle>proc
-        file</citetitle></link>, define it here, too.
-        </para>
-      </section>
-
       <section id="basic-flow-constructor-main-component">
-        <title>5) Set the driver ID and name strings.</title>
+        <title>4) Set the driver ID and name strings.</title>
         <para>
           <informalexample>
             <programlisting>
@@ -660,6 +647,19 @@
           The shortname field is a string shown as more verbose
         name. The longname field contains the information which is
         shown in <filename>/proc/asound/cards</filename>.
+        </para>
+      </section>
+
+      <section id="basic-flow-constructor-create-other">
+        <title>5) Create other components, such as mixer, MIDI, etc.</title>
+        <para>
+          Here you define the basic components such as
+          <link linkend="pcm-interface"><citetitle>PCM</citetitle></link>,
+          mixer (e.g. <link linkend="api-ac97"><citetitle>AC97</citetitle></link>),
+          MIDI (e.g. <link linkend="midi-interface"><citetitle>MPU-401</citetitle></link>),
+          and other interfaces.
+          Also, if you want a <link linkend="proc-interface"><citetitle>proc
+        file</citetitle></link>, define it here, too.
         </para>
       </section>

Index: alsa-kernel/isa/als100.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/als100.c,v
retrieving revision 1.23
diff -u -r1.23 als100.c
--- alsa-kernel/isa/als100.c	21 Jan 2004 18:32:46 -0000	1.23
+++ alsa-kernel/isa/als100.c	26 Jan 2004 09:00:13 -0000
@@ -240,6 +240,12 @@
 		return error;
 	}

+	strcpy(card->driver, "ALS100");
+	strcpy(card->shortname, "Avance Logic ALS100");
+	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
+		card->shortname, chip->name, chip->port,
+		irq[dev], dma8[dev], dma16[dev]);
+
 	if ((error = snd_sb16dsp_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return error;
@@ -276,11 +282,6 @@
 		}
 	}

-	strcpy(card->driver, "ALS100");
-	strcpy(card->shortname, "Avance Logic ALS100");
-	sprintf(card->longname, "%s soundcard, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, chip->name, chip->port,
-		irq[dev], dma8[dev], dma16[dev]);
 	if ((error = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return error;
Index: alsa-kernel/isa/azt2320.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/azt2320.c,v
retrieving revision 1.23
diff -u -r1.23 azt2320.c
--- alsa-kernel/isa/azt2320.c	21 Jan 2004 18:32:46 -0000	1.23
+++ alsa-kernel/isa/azt2320.c	26 Jan 2004 09:00:13 -0000
@@ -271,6 +271,11 @@
 		return error;
 	}

+	strcpy(card->driver, "AZT2320");
+	strcpy(card->shortname, "Aztech AZT2320");
+	sprintf(card->longname, "%s, WSS at 0x%lx, irq %i, dma %i&%i",
+		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
+
 	if ((error = snd_cs4231_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return error;
@@ -309,11 +314,6 @@
 			}
 		}
 	}
-
-	strcpy(card->driver, "AZT2320");
-	strcpy(card->shortname, "Aztech AZT2320");
-	sprintf(card->longname, "%s soundcard, WSS at 0x%lx, irq %i, dma %i&%i",
-		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);

 	if ((error = snd_card_register(card)) < 0) {
 		snd_card_free(card);
Index: alsa-kernel/isa/dt019x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/dt019x.c,v
retrieving revision 1.14
diff -u -r1.14 dt019x.c
--- alsa-kernel/isa/dt019x.c	21 Jan 2004 18:32:46 -0000	1.14
+++ alsa-kernel/isa/dt019x.c	26 Jan 2004 09:00:13 -0000
@@ -227,6 +227,12 @@
 		return error;
 	}

+	strcpy(card->driver, "DT-019X");
+	strcpy(card->shortname, "Diamond Tech. DT-019X");
+	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
+		card->shortname, chip->name, chip->port,
+		irq[dev], dma8[dev]);
+
 	if ((error = snd_sb16dsp_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return error;
@@ -268,11 +274,6 @@
 		}
 	}

-	strcpy(card->driver, "DT-019X");
-	strcpy(card->shortname, "Diamond Tech. DT-019X");
-	sprintf(card->longname, "%s soundcard, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, chip->name, chip->port,
-		irq[dev], dma8[dev]);
 	if ((error = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return error;
Index: alsa-kernel/isa/es18xx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/es18xx.c,v
retrieving revision 1.39
diff -u -r1.39 es18xx.c
--- alsa-kernel/isa/es18xx.c	21 Jan 2004 18:32:46 -0000	1.39
+++ alsa-kernel/isa/es18xx.c	26 Jan 2004 09:00:13 -0000
@@ -2101,6 +2101,20 @@
 		snd_card_free(card);
 		return err;
 	}
+
+	sprintf(card->driver, "ES%x", chip->version);
+	sprintf(card->shortname, "ESS AudioDrive ES%x", chip->version);
+	if (xdma1 != xdma2)
+		sprintf(card->longname, "%s at 0x%lx, irq %d, dma1 %d, dma2 %d",
+			card->shortname,
+			chip->port,
+			xirq, xdma1, xdma2);
+	else
+		sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
+			card->shortname,
+			chip->port,
+			xirq, xdma1);
+
 	if ((err = snd_es18xx_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -2142,18 +2156,6 @@
 		card->power_state_private_data = chip;
 	}
 #endif
-	sprintf(card->driver, "ES%x", chip->version);
-	sprintf(card->shortname, "ESS AudioDrive ES%x", chip->version);
-	if (xdma1 != xdma2)
-		sprintf(card->longname, "%s at 0x%lx, irq %d, dma1 %d, dma2 %d",
-			card->shortname,
-			chip->port,
-			xirq, xdma1, xdma2);
-	else
-		sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-			card->shortname,
-			chip->port,
-			xirq, xdma1);
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
Index: alsa-kernel/isa/ad1816a/ad1816a.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/ad1816a/ad1816a.c,v
retrieving revision 1.17
diff -u -r1.17 ad1816a.c
--- alsa-kernel/isa/ad1816a/ad1816a.c	21 Jan 2004 18:32:46 -0000	1.17
+++ alsa-kernel/isa/ad1816a/ad1816a.c	26 Jan 2004 09:00:13 -0000
@@ -221,6 +221,11 @@
 		return error;
 	}

+	strcpy(card->driver, "AD1816A");
+	strcpy(card->shortname, "ADI SoundPort AD1816A");
+	sprintf(card->longname, "%s, SS at 0x%lx, irq %d, dma %d&%d",
+		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
+
 	if ((error = snd_ad1816a_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return error;
@@ -254,11 +259,6 @@
 			}
 		}
 	}
-
-	strcpy(card->driver, "AD1816A");
-	strcpy(card->shortname, "ADI SoundPort AD1816A");
-	sprintf(card->longname, "%s soundcard, SS at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);

 	if ((error = snd_card_register(card)) < 0) {
 		snd_card_free(card);
Index: alsa-kernel/isa/cs423x/cs4231.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/cs423x/cs4231.c,v
retrieving revision 1.11
diff -u -r1.11 cs4231.c
--- alsa-kernel/isa/cs423x/cs4231.c	30 Oct 2003 14:21:08 -0000	1.11
+++ alsa-kernel/isa/cs423x/cs4231.c	26 Jan 2004 09:00:13 -0000
@@ -117,6 +117,14 @@
 		snd_card_free(card);
 		return err;
 	}
+
+	strcpy(card->driver, "CS4231");
+	strcpy(card->shortname, pcm->name);
+	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
+		pcm->name, chip->port, irq[dev], dma1[dev]);
+	if (dma2[dev] >= 0)
+		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
+
 	if ((err = snd_cs4231_mixer(chip)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -136,12 +144,6 @@
 					NULL) < 0)
 			printk(KERN_ERR "cs4231: MPU401 not detected\n");
 	}
-	strcpy(card->driver, "CS4231");
-	strcpy(card->shortname, pcm->name);
-	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-		pcm->name, chip->port, irq[dev], dma1[dev]);
-	if (dma2[dev] >= 0)
-		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
Index: alsa-kernel/isa/cs423x/cs4236.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/cs423x/cs4236.c,v
retrieving revision 1.40
diff -u -r1.40 cs4236.c
--- alsa-kernel/isa/cs423x/cs4236.c	21 Jan 2004 18:32:47 -0000	1.40
+++ alsa-kernel/isa/cs423x/cs4236.c	26 Jan 2004 09:00:13 -0000
@@ -491,6 +491,15 @@
 		return err;
 	}
 #endif
+	strcpy(card->driver, pcm->name);
+	strcpy(card->shortname, pcm->name);
+	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i",
+		pcm->name,
+		chip->port,
+		irq[dev],
+		dma1[dev]);
+	if (dma2[dev] >= 0)
+		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);

 	if ((err = snd_cs4231_timer(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
@@ -519,15 +528,6 @@
 					mpu_irq[dev] >= 0 ? SA_INTERRUPT : 0, NULL) < 0)
 			printk(KERN_ERR IDENT ": MPU401 not detected\n");
 	}
-	strcpy(card->driver, pcm->name);
-	strcpy(card->shortname, pcm->name);
-	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i",
-		pcm->name,
-		chip->port,
-		irq[dev],
-		dma1[dev]);
-	if (dma2[dev] >= 0)
-		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
Index: alsa-kernel/isa/es1688/es1688.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/es1688/es1688.c,v
retrieving revision 1.11
diff -u -r1.11 es1688.c
--- alsa-kernel/isa/es1688/es1688.c	14 Oct 2003 13:08:15 -0000	1.11
+++ alsa-kernel/isa/es1688/es1688.c	26 Jan 2004 09:00:13 -0000
@@ -130,6 +130,10 @@
 		return err;
 	}

+	strcpy(card->driver, "ES1688");
+	strcpy(card->shortname, pcm->name);
+	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i", pcm->name, chip->port, xirq, xdma);
+
 	if ((snd_opl3_create(card, chip->port, chip->port + 2, OPL3_HW_OPL3, 0, &opl3)) < 0) {
 		printk(KERN_ERR "es1688: opl3 not detected at 0x%lx\n", chip->port);
 	} else {
@@ -149,9 +153,6 @@
 			return err;
 		}
 	}
-	strcpy(card->driver, "ES1688");
-	strcpy(card->shortname, pcm->name);
-	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i", pcm->name, chip->port, xirq, xdma);
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
Index: alsa-kernel/isa/opti9xx/opti92x-ad1848.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/opti9xx/opti92x-ad1848.c,v
retrieving revision 1.37
diff -u -r1.37 opti92x-ad1848.c
--- alsa-kernel/isa/opti9xx/opti92x-ad1848.c	21 Jan 2004 18:32:47 -0000	1.37
+++ alsa-kernel/isa/opti9xx/opti92x-ad1848.c	26 Jan 2004 09:00:14 -0000
@@ -2106,6 +2106,17 @@
 		return error;
 	}
 #endif
+	strcpy(card->driver, chip->name);
+	sprintf(card->shortname, "OPTi %s", card->driver);
+#if defined(CS4231) || defined(OPTi93X)
+	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
+		card->shortname, pcm->name, chip->wss_base + 4,
+		chip->irq, chip->dma1, chip->dma2);
+#else
+	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
+		card->shortname, pcm->name, chip->wss_base + 4,
+		chip->irq, chip->dma1);
+#endif	/* CS4231 || OPTi93X */

 	if (chip->mpu_port <= 0 || chip->mpu_port == SNDRV_AUTO_PORT)
 		rmidi = NULL;
@@ -2159,17 +2170,6 @@
 		}
 	}

-	strcpy(card->driver, chip->name);
-	sprintf(card->shortname, "OPTi %s", card->driver);
-#if defined(CS4231) || defined(OPTi93X)
-	sprintf(card->longname, "%s soundcard, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, pcm->name, chip->wss_base + 4,
-		chip->irq, chip->dma1, chip->dma2);
-#else
-	sprintf(card->longname, "%s soundcard, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, pcm->name, chip->wss_base + 4,
-		chip->irq, chip->dma1);
-#endif	/* CS4231 || OPTi93X */
 	if ((error = snd_card_register(card))) {
 		snd_card_free(card);
 		return error;
Index: alsa-kernel/isa/sb/sb16.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sb/sb16.c,v
retrieving revision 1.42
diff -u -r1.42 sb16.c
--- alsa-kernel/isa/sb/sb16.c	21 Jan 2004 18:32:47 -0000	1.42
+++ alsa-kernel/isa/sb/sb16.c	26 Jan 2004 09:00:14 -0000
@@ -466,6 +466,22 @@
 		return -ENXIO;
 	}

+	strcpy(card->driver,
+#ifdef SNDRV_SBAWE_EMU8000
+			awe_port[dev] > 0 ? "SB AWE" :
+#endif
+			"SB16");
+	strcpy(card->shortname, chip->name);
+	sprintf(card->longname, "%s at 0x%lx, irq %i, dma ",
+		chip->name,
+		chip->port,
+		xirq);
+	if (xdma8 >= 0)
+		sprintf(card->longname + strlen(card->longname), "%d", xdma8);
+	if (xdma16 >= 0)
+		sprintf(card->longname + strlen(card->longname), "%s%d",
+			xdma8 >= 0 ? "&" : "", xdma16);
+
 	if (chip->mpu_port > 0 && chip->mpu_port != SNDRV_AUTO_PORT) {
 		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_SB,
 					       chip->mpu_port, 0,
@@ -536,21 +552,6 @@
 		(mic_agc[dev] ? 0x00 : 0x01));
 	spin_unlock_irqrestore(&chip->mixer_lock, flags);

-	strcpy(card->driver,
-#ifdef SNDRV_SBAWE_EMU8000
-			awe_port[dev] > 0 ? "SB AWE" :
-#endif
-			"SB16");
-	strcpy(card->shortname, chip->name);
-	sprintf(card->longname, "%s at 0x%lx, irq %i, dma ",
-		chip->name,
-		chip->port,
-		xirq);
-	if (xdma8 >= 0)
-		sprintf(card->longname + strlen(card->longname), "%d", xdma8);
-	if (xdma16 >= 0)
-		sprintf(card->longname + strlen(card->longname), "%s%d",
-			xdma8 >= 0 ? "&" : "", xdma16);
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
Index: alsa-kernel/pci/als4000.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/als4000.c,v
retrieving revision 1.27
diff -u -r1.27 als4000.c
--- alsa-kernel/pci/als4000.c	21 Jan 2004 18:32:47 -0000	1.27
+++ alsa-kernel/pci/als4000.c	26 Jan 2004 09:00:14 -0000
@@ -688,6 +688,11 @@

 	snd_als4000_configure(chip);

+	strcpy(card->driver, "ALS4000");
+	strcpy(card->shortname, "Avance Logic ALS4000");
+	sprintf(card->longname, "%s at 0x%lx, irq %i",
+		card->shortname, chip->alt_port, chip->irq);
+
 	if ((err = snd_mpu401_uart_new( card, 0, MPU401_HW_ALS4000,
 				        gcr+0x30, 1, pci->irq, 0,
 				        &chip->rmidi)) < 0) {
@@ -722,10 +727,6 @@
 		gameport_register_port(&acard->gameport);
 	}
 #endif
-	strcpy(card->driver, "ALS4000");
-	strcpy(card->shortname, "Avance Logic ALS4000");
-	sprintf(card->longname, "%s at 0x%lx, irq %i",
-		card->shortname, chip->alt_port, chip->irq);

 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
Index: alsa-kernel/pci/es1938.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/es1938.c,v
retrieving revision 1.30
diff -u -r1.30 es1938.c
--- alsa-kernel/pci/es1938.c	21 Jan 2004 18:32:47 -0000	1.30
+++ alsa-kernel/pci/es1938.c	26 Jan 2004 09:00:14 -0000
@@ -1635,6 +1635,14 @@
 		snd_card_free(card);
 		return err;
 	}
+
+	strcpy(card->driver, "ES1938");
+	strcpy(card->shortname, "ESS ES1938 (Solo-1)");
+	sprintf(card->longname, "%s rev %i, irq %i",
+		card->shortname,
+		chip->revision,
+		chip->irq);
+
 	if ((err = snd_es1938_new_pcm(chip, 0, &pcm)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -1669,13 +1677,6 @@
 	chip->gameport.io = chip->game_port;
 	gameport_register_port(&chip->gameport);
 #endif
-
-	strcpy(card->driver, "ES1938");
-	strcpy(card->shortname, "ESS ES1938 (Solo-1)");
-	sprintf(card->longname, "%s rev %i, irq %i",
-		card->shortname,
-		chip->revision,
-		chip->irq);

 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
Index: alsa-kernel/pci/fm801.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/fm801.c,v
retrieving revision 1.37
diff -u -r1.37 fm801.c
--- alsa-kernel/pci/fm801.c	21 Jan 2004 18:32:47 -0000	1.37
+++ alsa-kernel/pci/fm801.c	26 Jan 2004 09:00:15 -0000
@@ -1083,6 +1083,13 @@
 		snd_card_free(card);
 		return err;
 	}
+
+	strcpy(card->driver, "FM801");
+	strcpy(card->shortname, "ForteMedia FM801-");
+	strcat(card->shortname, chip->multichannel ? "AU" : "AS");
+	sprintf(card->longname, "%s at 0x%lx, irq %i",
+		card->shortname, chip->port, chip->irq);
+
 	if ((err = snd_fm801_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -1107,12 +1114,6 @@
 		snd_card_free(card);
 		return err;
 	}
-
-	strcpy(card->driver, "FM801");
-	strcpy(card->shortname, "ForteMedia FM801-");
-	strcat(card->shortname, chip->multichannel ? "AU" : "AS");
-	sprintf(card->longname, "%s at 0x%lx, irq %i",
-		card->shortname, chip->port, chip->irq);

 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
Index: alsa-kernel/pci/sonicvibes.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/sonicvibes.c,v
retrieving revision 1.30
diff -u -r1.30 sonicvibes.c
--- alsa-kernel/pci/sonicvibes.c	21 Jan 2004 18:32:47 -0000	1.30
+++ alsa-kernel/pci/sonicvibes.c	26 Jan 2004 09:00:15 -0000
@@ -1469,6 +1469,15 @@
 		snd_card_free(card);
 		return err;
 	}
+
+	strcpy(card->driver, "SonicVibes");
+	strcpy(card->shortname, "S3 SonicVibes");
+	sprintf(card->longname, "%s rev %i at 0x%lx, irq %i",
+		card->shortname,
+		sonic->revision,
+		pci_resource_start(pci, 1),
+		sonic->irq);
+
 	if ((err = snd_sonicvibes_pcm(sonic, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -1499,13 +1508,6 @@
 	sonic->gameport.io = sonic->game_port;
 	gameport_register_port(&sonic->gameport);
 #endif
-	strcpy(card->driver, "SonicVibes");
-	strcpy(card->shortname, "S3 SonicVibes");
-	sprintf(card->longname, "%s rev %i at 0x%lx, irq %i",
-		card->shortname,
-		sonic->revision,
-		pci_resource_start(pci, 1),
-		sonic->irq);

 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
Index: alsa-kernel/pci/trident/trident.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/trident/trident.c,v
retrieving revision 1.20
diff -u -r1.20 trident.c
--- alsa-kernel/pci/trident/trident.c	12 Aug 2003 14:10:16 -0000	1.20
+++ alsa-kernel/pci/trident/trident.c	26 Jan 2004 09:00:16 -0000
@@ -106,6 +106,30 @@
 		snd_card_free(card);
 		return err;
 	}
+
+	switch (trident->device) {
+	case TRIDENT_DEVICE_ID_DX:
+		str = "TRID4DWAVEDX";
+		break;
+	case TRIDENT_DEVICE_ID_NX:
+		str = "TRID4DWAVENX";
+		break;
+	case TRIDENT_DEVICE_ID_SI7018:
+		str = "SI7018";
+		break;
+	default:
+		str = "Unknown";
+	}
+	strcpy(card->driver, str);
+	if (trident->device == TRIDENT_DEVICE_ID_SI7018) {
+		strcpy(card->shortname, "SiS ");
+	} else {
+		strcpy(card->shortname, "Trident ");
+	}
+	strcat(card->shortname, card->driver);
+	sprintf(card->longname, "%s PCI Audio at 0x%lx, irq %d",
+		card->shortname, trident->port, trident->irq);
+
 	if ((err = snd_trident_pcm(trident, pcm_dev++, NULL)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -140,29 +164,6 @@
 #endif

 	snd_trident_gameport(trident);
-
-	switch (trident->device) {
-	case TRIDENT_DEVICE_ID_DX:
-		str = "TRID4DWAVEDX";
-		break;
-	case TRIDENT_DEVICE_ID_NX:
-		str = "TRID4DWAVENX";
-		break;
-	case TRIDENT_DEVICE_ID_SI7018:
-		str = "SI7018";
-		break;
-	default:
-		str = "Unknown";
-	}
-	strcpy(card->driver, str);
-	if (trident->device == TRIDENT_DEVICE_ID_SI7018) {
-		strcpy(card->shortname, "SiS ");
-	} else {
-		strcpy(card->shortname, "Trident ");
-	}
-	strcat(card->shortname, card->driver);
-	sprintf(card->longname, "%s PCI Audio at 0x%lx, irq %d",
-		card->shortname, trident->port, trident->irq);

 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
Index: alsa-kernel/pci/ymfpci/ymfpci.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci.c,v
retrieving revision 1.32
diff -u -r1.32 ymfpci.c
--- alsa-kernel/pci/ymfpci/ymfpci.c	28 Oct 2003 11:28:01 -0000	1.32
+++ alsa-kernel/pci/ymfpci/ymfpci.c	26 Jan 2004 09:00:16 -0000
@@ -247,6 +247,12 @@
 #ifdef SUPPORT_JOYSTICK
 	chip->joystick_res = joystick_res;
 #endif
+	strcpy(card->driver, str);
+	sprintf(card->shortname, "Yamaha DS-XG (%s)", str);
+	sprintf(card->longname, "%s at 0x%lx, irq %i",
+		card->shortname,
+		chip->reg_area_phys,
+		chip->irq);
 	if ((err = snd_ymfpci_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -300,12 +306,6 @@
 		gameport_register_port(&chip->gameport);
 	}
 #endif
-	strcpy(card->driver, str);
-	sprintf(card->shortname, "Yamaha DS-XG PCI (%s)", str);
-	sprintf(card->longname, "%s at 0x%lx, irq %i",
-		card->shortname,
-		chip->reg_area_phys,
-		chip->irq);

 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
