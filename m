From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 1/2] ALSA: convert "snd_printk(KERN_INFO" to
	"pr_info("
Date: Tue, 4 Jun 2013 13:20:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1306041315520.1093-100000@iolanthe.rowland.org>
References: <s5h61xtx6i5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 9D045261A5D
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 19:20:41 +0200 (CEST)
In-Reply-To: <s5h61xtx6i5.wl%tiwai@suse.de>
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
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The snd_printk() function prints kernel log messages, including the
filename and line number if CONFIG_SND_PRINTK_VERBOSE is enabled.
This may make sense for errors and warnings, but not for informational
messages.  For those, a simple pr_info() is what we want.

This patch mechanically converts all occurrences of
"snd_printk(KERN_INFO" to "pr_info(".  It doesn't try to tell whether
the message really is informational; it relies on the existing
KERN_INFO tag.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


[as1689]

 sound/drivers/ml403-ac97cr.c     |    6 +++---
 sound/drivers/mts64.c            |    2 +-
 sound/drivers/portman2x4.c       |    2 +-
 sound/isa/opti9xx/miro.c         |    4 ++--
 sound/isa/sb/sb16.c              |    2 +-
 sound/isa/sb/sb_common.c         |    2 +-
 sound/isa/sscape.c               |    4 ++--
 sound/isa/wavefront/wavefront.c  |    2 +-
 sound/pci/asihpi/asihpi.c        |   14 ++++++--------
 sound/pci/bt87x.c                |    4 ++--
 sound/pci/cs4281.c               |    2 +-
 sound/pci/cs46xx/cs46xx_lib.c    |    4 ++--
 sound/pci/echoaudio/echoaudio.c  |    2 +-
 sound/pci/emu10k1/emu10k1_main.c |   38 +++++++++++++++++++-------------------
 sound/pci/emu10k1/emu10k1x.c     |    8 ++++----
 sound/pci/emu10k1/emufx.c        |    8 ++++----
 sound/pci/emu10k1/irq.c          |    4 ++--
 sound/pci/es1968.c               |    2 +-
 sound/pci/fm801.c                |    4 ++--
 sound/pci/hda/hda_hwdep.c        |    2 +-
 sound/pci/hda/hda_intel.c        |   15 ++++++---------
 sound/pci/hda/patch_analog.c     |    2 +-
 sound/pci/ice1712/aureon.c       |    4 ++--
 sound/pci/oxygen/oxygen_lib.c    |    2 +-
 sound/pci/rme9652/hdsp.c         |   14 +++++++-------
 sound/pci/rme9652/hdspm.c        |   26 +++++++++++++-------------
 sound/pci/sonicvibes.c           |    4 ++--
 sound/usb/card.c                 |    2 +-
 sound/usb/clock.c                |    3 +--
 sound/usb/format.c               |    6 +++---
 sound/usb/mixer.c                |   21 +++++++--------------
 sound/usb/quirks.c               |    6 +++---
 32 files changed, 104 insertions(+), 117 deletions(-)

Index: usb-3.10/sound/drivers/ml403-ac97cr.c
===================================================================
--- usb-3.10.orig/sound/drivers/ml403-ac97cr.c
+++ usb-3.10/sound/drivers/ml403-ac97cr.c
@@ -1148,7 +1148,7 @@ snd_ml403_ac97cr_create(struct snd_card
 		snd_ml403_ac97cr_free(ml403_ac97cr);
 		return -EBUSY;
 	}
-	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
+	pr_info(SND_ML403_AC97CR_DRIVER ": "
 		   "remap controller memory region to "
 		   "0x%x done\n", (unsigned int)ml403_ac97cr->port);
 	/* get irq */
@@ -1162,7 +1162,7 @@ snd_ml403_ac97cr_create(struct snd_card
 		return -EBUSY;
 	}
 	ml403_ac97cr->irq = irq;
-	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
+	pr_info(SND_ML403_AC97CR_DRIVER ": "
 		   "request (playback) irq %d done\n",
 		   ml403_ac97cr->irq);
 	irq = platform_get_irq(pfdev, 1);
@@ -1175,7 +1175,7 @@ snd_ml403_ac97cr_create(struct snd_card
 		return -EBUSY;
 	}
 	ml403_ac97cr->capture_irq = irq;
-	snd_printk(KERN_INFO SND_ML403_AC97CR_DRIVER ": "
+	pr_info(SND_ML403_AC97CR_DRIVER ": "
 		   "request (capture) irq %d done\n",
 		   ml403_ac97cr->capture_irq);
 
Index: usb-3.10/sound/drivers/mts64.c
===================================================================
--- usb-3.10.orig/sound/drivers/mts64.c
+++ usb-3.10/sound/drivers/mts64.c
@@ -1017,7 +1017,7 @@ static int snd_mts64_probe(struct platfo
 		goto __err;
 	}
 
-	snd_printk(KERN_INFO "ESI Miditerminal 4140 on 0x%lx\n", p->base);
+	pr_info("ESI Miditerminal 4140 on 0x%lx\n", p->base);
 	return 0;
 
 __err:
Index: usb-3.10/sound/drivers/portman2x4.c
===================================================================
--- usb-3.10.orig/sound/drivers/portman2x4.c
+++ usb-3.10/sound/drivers/portman2x4.c
@@ -806,7 +806,7 @@ static int snd_portman_probe(struct plat
 		goto __err;
 	}
 
-	snd_printk(KERN_INFO "Portman 2x4 on 0x%lx\n", p->base);
+	pr_info("Portman 2x4 on 0x%lx\n", p->base);
 	return 0;
 
 __err:
Index: usb-3.10/sound/isa/opti9xx/miro.c
===================================================================
--- usb-3.10.orig/sound/isa/opti9xx/miro.c
+++ usb-3.10/sound/isa/opti9xx/miro.c
@@ -1346,11 +1346,11 @@ static int snd_miro_probe(struct snd_car
 		default:
 			sprintf(card->shortname, 
 				"unknown miro");
-			snd_printk(KERN_INFO "unknown miro aci id\n");
+			pr_info("unknown miro aci id\n");
 			break;
 		}
 	} else {
-		snd_printk(KERN_INFO "found unsupported aci card\n");
+		pr_info("found unsupported aci card\n");
 		sprintf(card->shortname, "unknown Cardinal Technologies");
 	}
 
Index: usb-3.10/sound/isa/sb/sb16.c
===================================================================
--- usb-3.10.orig/sound/isa/sb/sb16.c
+++ usb-3.10/sound/isa/sb/sb16.c
@@ -435,7 +435,7 @@ static int snd_sb16_probe(struct snd_car
 			chip->csp = xcsp->private_data;
 			chip->hardware = SB_HW_16CSP;
 		} else {
-			snd_printk(KERN_INFO PFX "warning - CSP chip not detected on soundcard #%i\n", dev + 1);
+			pr_info(PFX "warning - CSP chip not detected on soundcard #%i\n", dev + 1);
 		}
 	}
 #endif
Index: usb-3.10/sound/isa/sb/sb_common.c
===================================================================
--- usb-3.10.orig/sound/isa/sb/sb_common.c
+++ usb-3.10/sound/isa/sb/sb_common.c
@@ -154,7 +154,7 @@ static int snd_sbdsp_probe(struct snd_sb
 			str = "16";
 			break;
 		default:
-			snd_printk(KERN_INFO "SB [0x%lx]: unknown DSP chip version %i.%i\n",
+			pr_info("SB [0x%lx]: unknown DSP chip version %i.%i\n",
 				   chip->port, major, minor);
 			return -ENODEV;
 		}
Index: usb-3.10/sound/isa/sscape.c
===================================================================
--- usb-3.10.orig/sound/isa/sscape.c
+++ usb-3.10/sound/isa/sscape.c
@@ -590,7 +590,7 @@ static int sscape_upload_microcode(struc
 	}
 	err = upload_dma_data(sscape, init_fw->data, init_fw->size);
 	if (err == 0)
-		snd_printk(KERN_INFO "sscape: MIDI firmware loaded %d KBs\n",
+		pr_info("sscape: MIDI firmware loaded %d KBs\n",
 				init_fw->size >> 10);
 
 	release_firmware(init_fw);
@@ -1251,7 +1251,7 @@ static int sscape_pnp_detect(struct pnp_
 
 	if (!pnp_is_active(dev)) {
 		if (pnp_activate_dev(dev) < 0) {
-			snd_printk(KERN_INFO "sscape: device is inactive\n");
+			pr_info("sscape: device is inactive\n");
 			return -EBUSY;
 		}
 	}
Index: usb-3.10/sound/pci/asihpi/asihpi.c
===================================================================
--- usb-3.10.orig/sound/pci/asihpi/asihpi.c
+++ usb-3.10/sound/pci/asihpi/asihpi.c
@@ -1347,7 +1347,7 @@ static inline int ctl_add(struct snd_car
 	if (err < 0)
 		return err;
 	else if (mixer_dump)
-		snd_printk(KERN_INFO "added %s(%d)\n", ctl->name, ctl->index);
+		pr_info("added %s(%d)\n", ctl->name, ctl->index);
 
 	return 0;
 }
@@ -2583,8 +2583,7 @@ static int snd_card_asihpi_mixer_new(str
 		if (err) {
 			if (err == HPI_ERROR_CONTROL_DISABLED) {
 				if (mixer_dump)
-					snd_printk(KERN_INFO
-						   "Disabled HPI Control(%d)\n",
+					pr_info("Disabled HPI Control(%d)\n",
 						   idx);
 				continue;
 			} else
@@ -2648,8 +2647,7 @@ static int snd_card_asihpi_mixer_new(str
 		case HPI_CONTROL_COMPANDER:
 		default:
 			if (mixer_dump)
-				snd_printk(KERN_INFO
-					"Untranslated HPI Control"
+				pr_info("Untranslated HPI Control"
 					"(%d) %d %d %d %d %d\n",
 					idx,
 					hpi_ctl.control_type,
@@ -2665,7 +2663,7 @@ static int snd_card_asihpi_mixer_new(str
 	if (HPI_ERROR_INVALID_OBJ_INDEX != err)
 		hpi_handle_error(err);
 
-	snd_printk(KERN_INFO "%d mixer controls found\n", idx);
+	pr_info("%d mixer controls found\n", idx);
 
 	return 0;
 }
@@ -2844,7 +2842,7 @@ static int snd_asihpi_probe(struct pci_d
 	asihpi->pci = pci_dev;
 	asihpi->hpi = hpi;
 
-	snd_printk(KERN_INFO "adapter ID=%4X index=%d\n",
+	pr_info("adapter ID=%4X index=%d\n",
 			asihpi->hpi->adapter->type, adapter_index);
 
 	err = hpi_adapter_get_property(adapter_index,
@@ -2893,7 +2891,7 @@ static int snd_asihpi_probe(struct pci_d
 		asihpi->in_min_chans = 1;
 	}
 
-	snd_printk(KERN_INFO "Has dma:%d, grouping:%d, mrx:%d\n",
+	pr_info("Has dma:%d, grouping:%d, mrx:%d\n",
 			asihpi->can_dma,
 			asihpi->support_grouping,
 			asihpi->support_mrx
Index: usb-3.10/sound/pci/bt87x.c
===================================================================
--- usb-3.10.orig/sound/pci/bt87x.c
+++ usb-3.10/sound/pci/bt87x.c
@@ -856,7 +856,7 @@ static int snd_bt87x_detect_card(struct
 			return -EBUSY;
 		}
 
-	snd_printk(KERN_INFO "unknown card %#04x-%#04x:%#04x\n",
+	pr_info("unknown card %#04x-%#04x:%#04x\n",
 		   pci->device, pci->subsystem_vendor, pci->subsystem_device);
 	snd_printk(KERN_DEBUG "please mail id, board name, and, "
 		   "if it works, the correct digital_rate option to "
@@ -925,7 +925,7 @@ static int snd_bt87x_probe(struct pci_de
 		if (err < 0)
 			goto _error;
 	}
-	snd_printk(KERN_INFO "bt87x%d: Using board %d, %sanalog, %sdigital "
+	pr_info("bt87x%d: Using board %d, %sanalog, %sdigital "
 		   "(rate %d Hz)\n", dev, boardid,
 		   chip->board.no_analog ? "no " : "",
 		   chip->board.no_digital ? "no " : "", chip->board.dig_rate);
Index: usb-3.10/sound/pci/cs4281.c
===================================================================
--- usb-3.10.orig/sound/pci/cs4281.c
+++ usb-3.10/sound/pci/cs4281.c
@@ -1539,7 +1539,7 @@ static int snd_cs4281_chip_init(struct c
 				goto __codec2_ok;
 			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
-		snd_printk(KERN_INFO "secondary codec doesn't respond. disable it...\n");
+		pr_info("secondary codec doesn't respond. disable it...\n");
 		chip->dual_codec = 0;
 	__codec2_ok: ;
 	}
Index: usb-3.10/sound/pci/cs46xx/cs46xx_lib.c
===================================================================
--- usb-3.10.orig/sound/pci/cs46xx/cs46xx_lib.c
+++ usb-3.10/sound/pci/cs46xx/cs46xx_lib.c
@@ -3806,12 +3806,12 @@ int snd_cs46xx_create(struct snd_card *c
 	}
 
 	if (external_amp) {
-		snd_printk(KERN_INFO "Crystal EAPD support forced on.\n");
+		pr_info("Crystal EAPD support forced on.\n");
 		chip->amplifier_ctrl = amp_voyetra;
 	}
 
 	if (thinkpad) {
-		snd_printk(KERN_INFO "Activating CLKRUN hack for Thinkpad.\n");
+		pr_info("Activating CLKRUN hack for Thinkpad.\n");
 		chip->active_ctrl = clkrun_hack;
 		clkrun_init(chip);
 	}
Index: usb-3.10/sound/pci/echoaudio/echoaudio.c
===================================================================
--- usb-3.10.orig/sound/pci/echoaudio/echoaudio.c
+++ usb-3.10/sound/pci/echoaudio/echoaudio.c
@@ -2189,7 +2189,7 @@ static int snd_echo_probe(struct pci_dev
 	err = snd_card_register(card);
 	if (err < 0)
 		goto ctl_error;
-	snd_printk(KERN_INFO "Card registered: %s\n", card->longname);
+	pr_info("Card registered: %s\n", card->longname);
 
 	pci_set_drvdata(pci, chip);
 	dev++;
Index: usb-3.10/sound/pci/emu10k1/emu10k1_main.c
===================================================================
--- usb-3.10.orig/sound/pci/emu10k1/emu10k1_main.c
+++ usb-3.10/sound/pci/emu10k1/emu10k1_main.c
@@ -217,7 +217,7 @@ static int snd_emu10k1_init(struct snd_e
 	}
 	if (emu->card_capabilities->ca0108_chip) { /* audigy2 Value */
 		/* Hacks for Alice3 to work independent of haP16V driver */
-		snd_printk(KERN_INFO "Audigy2 value: Special config.\n");
+		pr_info("Audigy2 value: Special config.\n");
 		/* Setup SRCMulti_I2S SamplingRate */
 		tmp = snd_emu10k1_ptr_read(emu, A_SPDIF_SAMPLERATE, 0);
 		tmp &= 0xfffff1ff;
@@ -723,7 +723,7 @@ static int emu1010_firmware_thread(void
 		if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
 			/* Audio Dock attached */
 			/* Return to Audio Dock programming mode */
-			snd_printk(KERN_INFO "emu1010: Loading Audio Dock Firmware\n");
+			pr_info("emu1010: Loading Audio Dock Firmware\n");
 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, EMU_HANA_FPGA_CONFIG_AUDIODOCK);
 
 			if (!emu->dock_fw) {
@@ -756,19 +756,19 @@ static int emu1010_firmware_thread(void
 
 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0);
 			snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &reg);
-			snd_printk(KERN_INFO "emu1010: EMU_HANA+DOCK_IRQ_STATUS = 0x%x\n", reg);
+			pr_info("emu1010: EMU_HANA+DOCK_IRQ_STATUS = 0x%x\n", reg);
 			/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
 			snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
-			snd_printk(KERN_INFO "emu1010: EMU_HANA+DOCK_ID = 0x%x\n", reg);
+			pr_info("emu1010: EMU_HANA+DOCK_ID = 0x%x\n", reg);
 			if ((reg & 0x1f) != 0x15) {
 				/* FPGA failed to be programmed */
-				snd_printk(KERN_INFO "emu1010: Loading Audio Dock Firmware file failed, reg = 0x%x\n", reg);
+				pr_info("emu1010: Loading Audio Dock Firmware file failed, reg = 0x%x\n", reg);
 				continue;
 			}
-			snd_printk(KERN_INFO "emu1010: Audio Dock Firmware loaded\n");
+			pr_info("emu1010: Audio Dock Firmware loaded\n");
 			snd_emu1010_fpga_read(emu, EMU_DOCK_MAJOR_REV, &tmp);
 			snd_emu1010_fpga_read(emu, EMU_DOCK_MINOR_REV, &tmp2);
-			snd_printk(KERN_INFO "Audio Dock ver: %u.%u\n",
+			pr_info("Audio Dock ver: %u.%u\n",
 				   tmp, tmp2);
 			/* Sync clocking between 1010 and Dock */
 			/* Allow DLL to settle */
@@ -777,7 +777,7 @@ static int emu1010_firmware_thread(void
 			snd_emu1010_fpga_write(emu, EMU_HANA_UNMUTE, EMU_UNMUTE);
 		}
 	}
-	snd_printk(KERN_INFO "emu1010: firmware thread stopping\n");
+	pr_info("emu1010: firmware thread stopping\n");
 	return 0;
 }
 
@@ -818,7 +818,7 @@ static int snd_emu10k1_emu1010_init(stru
 	u32 tmp, tmp2, reg;
 	int err;
 
-	snd_printk(KERN_INFO "emu1010: Special config.\n");
+	pr_info("emu1010: Special config.\n");
 	/* AC97 2.1, Any 16Meg of 4Gig address, Auto-Mute, EMU32 Slave,
 	 * Lock Sound Memory Cache, Lock Tank Memory Cache,
 	 * Mute all codecs.
@@ -854,10 +854,10 @@ static int snd_emu10k1_emu1010_init(stru
 	snd_printdd("reg2 = 0x%x\n", reg);
 	if ((reg & 0x3f) == 0x15) {
 		/* FPGA failed to return to programming mode */
-		snd_printk(KERN_INFO "emu1010: FPGA failed to return to programming mode\n");
+		pr_info("emu1010: FPGA failed to return to programming mode\n");
 		return -ENODEV;
 	}
-	snd_printk(KERN_INFO "emu1010: EMU_HANA_ID = 0x%x\n", reg);
+	pr_info("emu1010: EMU_HANA_ID = 0x%x\n", reg);
 
 	if (!emu->firmware) {
 		const char *filename;
@@ -883,13 +883,13 @@ static int snd_emu10k1_emu1010_init(stru
 			snd_printk(KERN_ERR "emu1010: firmware: %s not found. Err = %d\n", filename, err);
 			return err;
 		}
-		snd_printk(KERN_INFO "emu1010: firmware file = %s, size = 0x%zx\n",
+		pr_info("emu1010: firmware file = %s, size = 0x%zx\n",
 			   filename, emu->firmware->size);
 	}
 
 	err = snd_emu1010_load_firmware(emu, emu->firmware);
 	if (err != 0) {
-		snd_printk(KERN_INFO "emu1010: Loading Firmware failed\n");
+		pr_info("emu1010: Loading Firmware failed\n");
 		return err;
 	}
 
@@ -897,21 +897,21 @@ static int snd_emu10k1_emu1010_init(stru
 	snd_emu1010_fpga_read(emu, EMU_HANA_ID, &reg);
 	if ((reg & 0x3f) != 0x15) {
 		/* FPGA failed to be programmed */
-		snd_printk(KERN_INFO "emu1010: Loading Hana Firmware file failed, reg = 0x%x\n", reg);
+		pr_info("emu1010: Loading Hana Firmware file failed, reg = 0x%x\n", reg);
 		return -ENODEV;
 	}
 
-	snd_printk(KERN_INFO "emu1010: Hana Firmware loaded\n");
+	pr_info("emu1010: Hana Firmware loaded\n");
 	snd_emu1010_fpga_read(emu, EMU_HANA_MAJOR_REV, &tmp);
 	snd_emu1010_fpga_read(emu, EMU_HANA_MINOR_REV, &tmp2);
-	snd_printk(KERN_INFO "emu1010: Hana version: %u.%u\n", tmp, tmp2);
+	pr_info("emu1010: Hana version: %u.%u\n", tmp, tmp2);
 	/* Enable 48Volt power to Audio Dock */
 	snd_emu1010_fpga_write(emu, EMU_HANA_DOCK_PWR, EMU_HANA_DOCK_PWR_ON);
 
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
-	snd_printk(KERN_INFO "emu1010: Card options = 0x%x\n", reg);
+	pr_info("emu1010: Card options = 0x%x\n", reg);
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
-	snd_printk(KERN_INFO "emu1010: Card options = 0x%x\n", reg);
+	pr_info("emu1010: Card options = 0x%x\n", reg);
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTICAL_TYPE, &tmp);
 	/* Optical -> ADAT I/O  */
 	/* 0 : SPDIF
@@ -950,7 +950,7 @@ static int snd_emu10k1_emu1010_init(stru
 	snd_emu1010_fpga_write(emu, EMU_HANA_IRQ_ENABLE, 0x00);
 
 	snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
-	snd_printk(KERN_INFO "emu1010: Card options3 = 0x%x\n", reg);
+	pr_info("emu1010: Card options3 = 0x%x\n", reg);
 	/* Default WCLK set to 48kHz. */
 	snd_emu1010_fpga_write(emu, EMU_HANA_DEFCLOCK, 0x00);
 	/* Word Clock source, Internal 48kHz x1 */
Index: usb-3.10/sound/pci/emu10k1/emu10k1x.c
===================================================================
--- usb-3.10.orig/sound/pci/emu10k1/emu10k1x.c
+++ usb-3.10/sound/pci/emu10k1/emu10k1x.c
@@ -369,7 +369,7 @@ static void snd_emu10k1x_pcm_interrupt(s
 	if (epcm->substream == NULL)
 		return;
 #if 0
-	snd_printk(KERN_INFO "IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
+	pr_info("IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
 		   epcm->substream->ops->pointer(epcm->substream),
 		   snd_pcm_lib_period_bytes(epcm->substream),
 		   snd_pcm_lib_buffer_bytes(epcm->substream));
@@ -487,7 +487,7 @@ static int snd_emu10k1x_pcm_trigger(stru
 	int channel = epcm->voice->number;
 	int result = 0;
 
-//	snd_printk(KERN_INFO "trigger - emu10k1x = 0x%x, cmd = %i, pointer = %d\n", (int)emu, cmd, (int)substream->ops->pointer(substream));
+//	pr_info("trigger - emu10k1x = 0x%x, cmd = %i, pointer = %d\n", (int)emu, cmd, (int)substream->ops->pointer(substream));
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -826,7 +826,7 @@ static irqreturn_t snd_emu10k1x_interrup
 	// acknowledge the interrupt if necessary
 	outl(status, chip->port + IPR);
 
-	// snd_printk(KERN_INFO "interrupt %08x\n", status);
+	// pr_info("interrupt %08x\n", status);
 	return IRQ_HANDLED;
 }
 
@@ -964,7 +964,7 @@ static int snd_emu10k1x_create(struct sn
 	chip->revision = pci->revision;
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
-	snd_printk(KERN_INFO "Model %04x Rev %08x Serial %08x\n", chip->model,
+	pr_info("Model %04x Rev %08x Serial %08x\n", chip->model,
 		   chip->revision, chip->serial);
 
 	outl(0, chip->port + INTE);	
Index: usb-3.10/sound/pci/emu10k1/emufx.c
===================================================================
--- usb-3.10.orig/sound/pci/emu10k1/emufx.c
+++ usb-3.10/sound/pci/emu10k1/emufx.c
@@ -1542,7 +1542,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_G
 	/* A_PUT_STEREO_OUTPUT(A_EXTOUT_FRONT_L, A_EXTOUT_FRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS); */
 	if (emu->card_capabilities->emu_model) {
 		/* EMU1010 Outputs from PCM Front, Rear, Center, LFE, Side */
-		snd_printk(KERN_INFO "EMU outputs on\n");
+		pr_info("EMU outputs on\n");
 		for (z = 0; z < 8; z++) {
 			if (emu->card_capabilities->ca0108_chip) {
 				A_OP(icode, &ptr, iACC3, A3_EMU32OUT(z), A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + z), A_C_00000000, A_C_00000000);
@@ -1566,7 +1566,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_G
 		A_SWITCH(icode, &ptr, tmp + 1, playback + SND_EMU10K1_PLAYBACK_CHANNELS + z, tmp + 1);
 		if ((z==1) && (emu->card_capabilities->spdif_bug)) {
 			/* Due to a SPDIF output bug on some Audigy cards, this code delays the Right channel by 1 sample */
-			snd_printk(KERN_INFO "Installing spdif_bug patch: %s\n", emu->card_capabilities->name);
+			pr_info("Installing spdif_bug patch: %s\n", emu->card_capabilities->name);
 			A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(gpr - 3), A_C_00000000, A_C_00000000);
 			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 3), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
 		} else {
@@ -1590,7 +1590,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_G
 
 	if (emu->card_capabilities->emu_model) {
 		if (emu->card_capabilities->ca0108_chip) {
-			snd_printk(KERN_INFO "EMU2 inputs on\n");
+			pr_info("EMU2 inputs on\n");
 			for (z = 0; z < 0x10; z++) {
 				snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, 
 									bit_shifter16,
@@ -1598,7 +1598,7 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_G
 									A_FXBUS2(z*2) );
 			}
 		} else {
-			snd_printk(KERN_INFO "EMU inputs on\n");
+			pr_info("EMU inputs on\n");
 			/* Capture 16 (originally 8) channels of S32_LE sound */
 
 			/*
Index: usb-3.10/sound/pci/emu10k1/irq.c
===================================================================
--- usb-3.10.orig/sound/pci/emu10k1/irq.c
+++ usb-3.10/sound/pci/emu10k1/irq.c
@@ -41,7 +41,7 @@ irqreturn_t snd_emu10k1_interrupt(int ir
 		orig_status = status;
 		handled = 1;
 		if ((status & 0xffffffff) == 0xffffffff) {
-			snd_printk(KERN_INFO "snd-emu10k1: Suspected sound card removal\n");
+			pr_info("snd-emu10k1: Suspected sound card removal\n");
 			break;
 		}
 		if (status & IPR_PCIERROR) {
@@ -202,7 +202,7 @@ irqreturn_t snd_emu10k1_interrupt(int ir
 		outl(orig_status, emu->port + IPR); /* ack all */
 	}
 	if (timeout == 1000)
-		snd_printk(KERN_INFO "emu10k1 irq routine failure\n");
+		pr_info("emu10k1 irq routine failure\n");
 
 	return IRQ_RETVAL(handled);
 }
Index: usb-3.10/sound/pci/es1968.c
===================================================================
--- usb-3.10.orig/sound/pci/es1968.c
+++ usb-3.10/sound/pci/es1968.c
@@ -2109,7 +2109,7 @@ static void snd_es1968_ac97_reset(struct
 	outw(inw(ioaddr + 0x3c) & 0xfffc, ioaddr + 0x3c);
 
 #if 0				/* the loop here needs to be much better if we want it.. */
-	snd_printk(KERN_INFO "trying software reset\n");
+	pr_info("trying software reset\n");
 	/* try and do a software reset */
 	outb(0x80 | 0x7c, ioaddr + 0x30);
 	for (w = 0;; w++) {
Index: usb-3.10/sound/pci/fm801.c
===================================================================
--- usb-3.10.orig/sound/pci/fm801.c
+++ usb-3.10/sound/pci/fm801.c
@@ -1100,7 +1100,7 @@ static int snd_fm801_chip_init(struct fm
 
 	if (wait_for_codec(chip, 0, AC97_RESET, msecs_to_jiffies(750)) < 0)
 		if (!resume) {
-			snd_printk(KERN_INFO "Primary AC'97 codec not found, "
+			pr_info("Primary AC'97 codec not found, "
 					    "assume SF64-PCR (tuner-only)\n");
 			chip->tea575x_tuner = 3 | TUNER_ONLY;
 			goto __ac97_ok;
@@ -1276,7 +1276,7 @@ static int snd_fm801_create(struct snd_c
 		for (tea575x_tuner = 1; tea575x_tuner <= 3; tea575x_tuner++) {
 			chip->tea575x_tuner = tea575x_tuner;
 			if (!snd_tea575x_init(&chip->tea, THIS_MODULE)) {
-				snd_printk(KERN_INFO "detected TEA575x radio type %s\n",
+				pr_info("detected TEA575x radio type %s\n",
 					   get_tea575x_gpio(chip)->name);
 				break;
 			}
Index: usb-3.10/sound/pci/hda/hda_hwdep.c
===================================================================
--- usb-3.10.orig/sound/pci/hda/hda_hwdep.c
+++ usb-3.10/sound/pci/hda/hda_hwdep.c
@@ -218,7 +218,7 @@ static int reconfig_codec(struct hda_cod
 	int err;
 
 	snd_hda_power_up(codec);
-	snd_printk(KERN_INFO "hda-codec: reconfiguring\n");
+	pr_info("hda-codec: reconfiguring\n");
 	err = snd_hda_codec_reset(codec);
 	if (err < 0) {
 		snd_printk(KERN_ERR
Index: usb-3.10/sound/pci/hda/hda_intel.c
===================================================================
--- usb-3.10.orig/sound/pci/hda/hda_intel.c
+++ usb-3.10/sound/pci/hda/hda_intel.c
@@ -3030,8 +3030,7 @@ static void azx_vs_set_state(struct pci_
 	if (!chip->bus) {
 		chip->disabled = disabled;
 		if (!disabled) {
-			snd_printk(KERN_INFO SFX
-				   "%s: Start delayed initialization\n",
+			pr_info(SFX "%s: Start delayed initialization\n",
 				   pci_name(chip->pci));
 			if (azx_first_init(chip) < 0 ||
 			    azx_probe_continue(chip) < 0) {
@@ -3042,8 +3041,7 @@ static void azx_vs_set_state(struct pci_
 			}
 		}
 	} else {
-		snd_printk(KERN_INFO SFX
-			   "%s: %s via VGA-switcheroo\n", pci_name(chip->pci),
+		pr_info(SFX "%s: %s via VGA-switcheroo\n", pci_name(chip->pci),
 			   disabled ? "Disabling" : "Enabling");
 		if (disabled) {
 			azx_suspend(&pci->dev);
@@ -3079,8 +3077,7 @@ static void init_vga_switcheroo(struct a
 {
 	struct pci_dev *p = get_bound_vga(chip->pci);
 	if (p) {
-		snd_printk(KERN_INFO SFX
-			   "%s: Handle VGA-switcheroo audio client\n",
+		pr_info(SFX "%s: Handle VGA-switcheroo audio client\n",
 			   pci_name(chip->pci));
 		chip->use_vga_switcheroo = 1;
 		pci_dev_put(p);
@@ -3392,7 +3389,7 @@ static void azx_check_snoop_available(st
 	}
 
 	if (snoop != chip->snoop) {
-		snd_printk(KERN_INFO SFX "%s: Force to %s mode\n",
+		pr_info(SFX "%s: Force to %s mode\n",
 			   pci_name(chip->pci), snoop ? "snoop" : "non-snoop");
 		chip->snoop = snoop;
 	}
@@ -3723,9 +3720,9 @@ static int azx_probe(struct pci_dev *pci
 	}
 
 	if (check_hdmi_disabled(pci)) {
-		snd_printk(KERN_INFO SFX "%s: VGA controller is disabled\n",
+		pr_info(SFX "%s: VGA controller is disabled\n",
 			   pci_name(pci));
-		snd_printk(KERN_INFO SFX "%s: Delaying initialization\n", pci_name(pci));
+		pr_info(SFX "%s: Delaying initialization\n", pci_name(pci));
 		chip->disabled = true;
 	}
 
Index: usb-3.10/sound/pci/hda/patch_analog.c
===================================================================
--- usb-3.10.orig/sound/pci/hda/patch_analog.c
+++ usb-3.10/sound/pci/hda/patch_analog.c
@@ -3289,7 +3289,7 @@ static int patch_ad1988(struct hda_codec
 	spec = codec->spec;
 
 	if (is_rev2(codec))
-		snd_printk(KERN_INFO "patch_analog: AD1988A rev.2 is detected, enable workarounds\n");
+		pr_info("patch_analog: AD1988A rev.2 is detected, enable workarounds\n");
 
 	err = snd_hda_attach_beep_device(codec, 0x10);
 	if (err < 0) {
Index: usb-3.10/sound/pci/ice1712/aureon.c
===================================================================
--- usb-3.10.orig/sound/pci/ice1712/aureon.c
+++ usb-3.10/sound/pci/ice1712/aureon.c
@@ -1937,9 +1937,9 @@ static int aureon_add_controls(struct sn
 		snd_ice1712_save_gpio_status(ice);
 		id = aureon_cs8415_get(ice, CS8415_ID);
 		if (id != 0x41)
-			snd_printk(KERN_INFO "No CS8415 chip. Skipping CS8415 controls.\n");
+			pr_info("No CS8415 chip. Skipping CS8415 controls.\n");
 		else if ((id & 0x0F) != 0x01)
-			snd_printk(KERN_INFO "Detected unsupported CS8415 rev. (%c)\n", (char)((id & 0x0F) + 'A' - 1));
+			pr_info("Detected unsupported CS8415 rev. (%c)\n", (char)((id & 0x0F) + 'A' - 1));
 		else {
 			for (i = 0; i < ARRAY_SIZE(cs8415_controls); i++) {
 				struct snd_kcontrol *kctl;
Index: usb-3.10/sound/pci/oxygen/oxygen_lib.c
===================================================================
--- usb-3.10.orig/sound/pci/oxygen/oxygen_lib.c
+++ usb-3.10/sound/pci/oxygen/oxygen_lib.c
@@ -313,7 +313,7 @@ static void oxygen_restore_eeprom(struct
 		oxygen_clear_bits8(chip, OXYGEN_MISC,
 				   OXYGEN_MISC_WRITE_PCI_SUBID);
 
-		snd_printk(KERN_INFO "EEPROM ID restored\n");
+		pr_info("EEPROM ID restored\n");
 	}
 }
 
Index: usb-3.10/sound/pci/rme9652/hdsp.c
===================================================================
--- usb-3.10.orig/sound/pci/rme9652/hdsp.c
+++ usb-3.10/sound/pci/rme9652/hdsp.c
@@ -770,7 +770,7 @@ static int snd_hdsp_load_firmware_from_c
 
 	}
 	if (hdsp->state & HDSP_InitializationComplete) {
-		snd_printk(KERN_INFO "Hammerfall-DSP: firmware loaded from cache, restoring defaults\n");
+		pr_info("Hammerfall-DSP: firmware loaded from cache, restoring defaults\n");
 		spin_lock_irqsave(&hdsp->lock, flags);
 		snd_hdsp_set_defaults(hdsp);
 		spin_unlock_irqrestore(&hdsp->lock, flags);
@@ -1153,11 +1153,11 @@ static int hdsp_set_rate(struct hdsp *hd
 			int spdif_freq = hdsp_spdif_sample_rate(hdsp);
 
 			if ((spdif_freq == external_freq*2) && (hdsp_autosync_ref(hdsp) >= HDSP_AUTOSYNC_FROM_ADAT1))
-				snd_printk(KERN_INFO "Hammerfall-DSP: Detected ADAT in double speed mode\n");
+				pr_info("Hammerfall-DSP: Detected ADAT in double speed mode\n");
 			else if (hdsp->io_type == H9632 && (spdif_freq == external_freq*4) && (hdsp_autosync_ref(hdsp) >= HDSP_AUTOSYNC_FROM_ADAT1))
-				snd_printk(KERN_INFO "Hammerfall-DSP: Detected ADAT in quad speed mode\n");
+				pr_info("Hammerfall-DSP: Detected ADAT in quad speed mode\n");
 			else if (rate != external_freq) {
-				snd_printk(KERN_INFO "Hammerfall-DSP: No AutoSync source for requested rate\n");
+				pr_info("Hammerfall-DSP: No AutoSync source for requested rate\n");
 				return -1;
 			}
 		}
@@ -4863,7 +4863,7 @@ static int snd_hdsp_hwdep_ioctl(struct s
 		if (hdsp->state & (HDSP_FirmwareCached | HDSP_FirmwareLoaded))
 			return -EBUSY;
 
-		snd_printk(KERN_INFO "Hammerfall-DSP: initializing firmware upload\n");
+		pr_info("Hammerfall-DSP: initializing firmware upload\n");
 		firmware = (struct hdsp_firmware __user *)argp;
 
 		if (get_user(firmware_data, &firmware->firmware_data))
@@ -5291,12 +5291,12 @@ static int snd_hdsp_create(struct snd_ca
 				/* init is complete, we return */
 				return 0;
 			/* we defer initialization */
-			snd_printk(KERN_INFO "Hammerfall-DSP: card initialization pending : waiting for firmware\n");
+			pr_info("Hammerfall-DSP: card initialization pending : waiting for firmware\n");
 			if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0)
 				return err;
 			return 0;
 		} else {
-			snd_printk(KERN_INFO "Hammerfall-DSP: Firmware already present, initializing card.\n");
+			pr_info("Hammerfall-DSP: Firmware already present, initializing card.\n");
 			if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version2)
 				hdsp->io_type = RPM;
 			else if (hdsp_read(hdsp, HDSP_status2Register) & HDSP_version1)
Index: usb-3.10/sound/pci/rme9652/hdspm.c
===================================================================
--- usb-3.10.orig/sound/pci/rme9652/hdspm.c
+++ usb-3.10/sound/pci/rme9652/hdspm.c
@@ -5143,7 +5143,7 @@ static irqreturn_t snd_hdspm_interrupt(i
 	 *          0         64     ~3998231       ~8191558
 	 **/
 	/*
-	   snd_printk(KERN_INFO "snd_hdspm_interrupt %llu @ %llx\n",
+	   pr_info("snd_hdspm_interrupt %llu @ %llx\n",
 	   now-hdspm->last_interrupt, status & 0xFFC0);
 	   hdspm->last_interrupt = now;
 	*/
@@ -5280,7 +5280,7 @@ static int snd_hdspm_hw_params(struct sn
 	spin_lock_irq(&hdspm->lock);
 	err = hdspm_set_rate(hdspm, params_rate(params), 0);
 	if (err < 0) {
-		snd_printk(KERN_INFO "err on hdspm_set_rate: %d\n", err);
+		pr_info("err on hdspm_set_rate: %d\n", err);
 		spin_unlock_irq(&hdspm->lock);
 		_snd_pcm_hw_param_setempty(params,
 				SNDRV_PCM_HW_PARAM_RATE);
@@ -5291,7 +5291,7 @@ static int snd_hdspm_hw_params(struct sn
 	err = hdspm_set_interrupt_interval(hdspm,
 			params_period_size(params));
 	if (err < 0) {
-		snd_printk(KERN_INFO "err on hdspm_set_interrupt_interval: %d\n", err);
+		pr_info("err on hdspm_set_interrupt_interval: %d\n", err);
 		_snd_pcm_hw_param_setempty(params,
 				SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
 		return err;
@@ -5307,7 +5307,7 @@ static int snd_hdspm_hw_params(struct sn
 	err =
 		snd_pcm_lib_malloc_pages(substream, HDSPM_DMA_AREA_BYTES);
 	if (err < 0) {
-		snd_printk(KERN_INFO "err on snd_pcm_lib_malloc_pages: %d\n", err);
+		pr_info("err on snd_pcm_lib_malloc_pages: %d\n", err);
 		return err;
 	}
 
@@ -5354,12 +5354,12 @@ static int snd_hdspm_hw_params(struct sn
 	/* Switch to native float format if requested */
 	if (SNDRV_PCM_FORMAT_FLOAT_LE == params_format(params)) {
 		if (!(hdspm->control_register & HDSPe_FLOAT_FORMAT))
-			snd_printk(KERN_INFO "hdspm: Switching to native 32bit LE float format.\n");
+			pr_info("hdspm: Switching to native 32bit LE float format.\n");
 
 		hdspm->control_register |= HDSPe_FLOAT_FORMAT;
 	} else if (SNDRV_PCM_FORMAT_S32_LE == params_format(params)) {
 		if (hdspm->control_register & HDSPe_FLOAT_FORMAT)
-			snd_printk(KERN_INFO "hdspm: Switching to native 32bit LE integer format.\n");
+			pr_info("hdspm: Switching to native 32bit LE integer format.\n");
 
 		hdspm->control_register &= ~HDSPe_FLOAT_FORMAT;
 	}
@@ -5402,12 +5402,12 @@ static int snd_hdspm_channel_info(struct
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (snd_BUG_ON(info->channel >= hdspm->max_channels_out)) {
-			snd_printk(KERN_INFO "snd_hdspm_channel_info: output channel out of range (%d)\n", info->channel);
+			pr_info("snd_hdspm_channel_info: output channel out of range (%d)\n", info->channel);
 			return -EINVAL;
 		}
 
 		if (hdspm->channel_map_out[info->channel] < 0) {
-			snd_printk(KERN_INFO "snd_hdspm_channel_info: output channel %d mapped out\n", info->channel);
+			pr_info("snd_hdspm_channel_info: output channel %d mapped out\n", info->channel);
 			return -EINVAL;
 		}
 
@@ -5415,12 +5415,12 @@ static int snd_hdspm_channel_info(struct
 			HDSPM_CHANNEL_BUFFER_BYTES;
 	} else {
 		if (snd_BUG_ON(info->channel >= hdspm->max_channels_in)) {
-			snd_printk(KERN_INFO "snd_hdspm_channel_info: input channel out of range (%d)\n", info->channel);
+			pr_info("snd_hdspm_channel_info: input channel out of range (%d)\n", info->channel);
 			return -EINVAL;
 		}
 
 		if (hdspm->channel_map_in[info->channel] < 0) {
-			snd_printk(KERN_INFO "snd_hdspm_channel_info: input channel %d mapped out\n", info->channel);
+			pr_info("snd_hdspm_channel_info: input channel %d mapped out\n", info->channel);
 			return -EINVAL;
 		}
 
@@ -6460,7 +6460,7 @@ static int snd_hdspm_create(struct snd_c
 
 	case AIO:
 		if (0 == (hdspm_read(hdspm, HDSPM_statusRegister2) & HDSPM_s2_AEBI_D)) {
-			snd_printk(KERN_INFO "HDSPM: AEB input board found, but not supported\n");
+			pr_info("HDSPM: AEB input board found, but not supported\n");
 		}
 
 		hdspm->ss_in_channels = AIO_IN_SS_CHANNELS;
@@ -6531,7 +6531,7 @@ static int snd_hdspm_create(struct snd_c
 			if (NULL != hdspm->tco) {
 				hdspm_tco_write(hdspm);
 			}
-			snd_printk(KERN_INFO "HDSPM: AIO/RayDAT TCO module found\n");
+			pr_info("HDSPM: AIO/RayDAT TCO module found\n");
 		} else {
 			hdspm->tco = NULL;
 		}
@@ -6545,7 +6545,7 @@ static int snd_hdspm_create(struct snd_c
 			if (NULL != hdspm->tco) {
 				hdspm_tco_write(hdspm);
 			}
-			snd_printk(KERN_INFO "HDSPM: MADI TCO module found\n");
+			pr_info("HDSPM: MADI TCO module found\n");
 		} else {
 			hdspm->tco = NULL;
 		}
Index: usb-3.10/sound/pci/sonicvibes.c
===================================================================
--- usb-3.10.orig/sound/pci/sonicvibes.c
+++ usb-3.10/sound/pci/sonicvibes.c
@@ -1310,12 +1310,12 @@ static int snd_sonicvibes_create(struct
 	if (!dmaa) {
 		dmaa = dmaio;
 		dmaio += 0x10;
-		snd_printk(KERN_INFO "BIOS did not allocate DDMA channel A i/o, allocated at 0x%x\n", dmaa);
+		pr_info("BIOS did not allocate DDMA channel A i/o, allocated at 0x%x\n", dmaa);
 	}
 	if (!dmac) {
 		dmac = dmaio;
 		dmaio += 0x10;
-		snd_printk(KERN_INFO "BIOS did not allocate DDMA channel C i/o, allocated at 0x%x\n", dmac);
+		pr_info("BIOS did not allocate DDMA channel C i/o, allocated at 0x%x\n", dmac);
 	}
 	pci_write_config_dword(pci, 0x40, dmaa);
 	pci_write_config_dword(pci, 0x48, dmac);
Index: usb-3.10/sound/usb/card.c
===================================================================
--- usb-3.10.orig/sound/usb/card.c
+++ usb-3.10/sound/usb/card.c
@@ -227,7 +227,7 @@ static int snd_usb_create_streams(struct
 		struct uac1_ac_header_descriptor *h1 = control_header;
 
 		if (!h1->bInCollection) {
-			snd_printk(KERN_INFO "skipping empty audio interface (v1)\n");
+			pr_info("skipping empty audio interface (v1)\n");
 			return -EINVAL;
 		}
 
Index: usb-3.10/sound/usb/clock.c
===================================================================
--- usb-3.10.orig/sound/usb/clock.c
+++ usb-3.10/sound/usb/clock.c
@@ -237,8 +237,7 @@ static int __uac_clock_find_source(struc
 			if (err < 0)
 				continue;
 
-			snd_printk(KERN_INFO
-				"usb-audio:%d: found and selected valid clock source %d\n",
+			pr_info("usb-audio:%d: found and selected valid clock source %d\n",
 				chip->dev->devnum, ret);
 			return ret;
 		}
Index: usb-3.10/sound/usb/format.c
===================================================================
--- usb-3.10.orig/sound/usb/format.c
+++ usb-3.10/sound/usb/format.c
@@ -84,7 +84,7 @@ static u64 parse_audio_format_i_type(str
 		    sample_width == 24 && sample_bytes == 2)
 			sample_bytes = 3;
 		else if (sample_width > sample_bytes * 8) {
-			snd_printk(KERN_INFO "%d:%u:%d : sample bitwidth %d in over sample bytes %d\n",
+			pr_info("%d:%u:%d : sample bitwidth %d in over sample bytes %d\n",
 				   chip->dev->devnum, fp->iface, fp->altsetting,
 				   sample_width, sample_bytes);
 		}
@@ -109,7 +109,7 @@ static u64 parse_audio_format_i_type(str
 			pcm_formats |= SNDRV_PCM_FMTBIT_S32_LE;
 			break;
 		default:
-			snd_printk(KERN_INFO "%d:%u:%d : unsupported sample bitwidth %d in %d bytes\n",
+			pr_info("%d:%u:%d : unsupported sample bitwidth %d in %d bytes\n",
 				   chip->dev->devnum, fp->iface, fp->altsetting,
 				   sample_width, sample_bytes);
 			break;
@@ -133,7 +133,7 @@ static u64 parse_audio_format_i_type(str
 		pcm_formats |= SNDRV_PCM_FMTBIT_MU_LAW;
 	}
 	if (format & ~0x3f) {
-		snd_printk(KERN_INFO "%d:%u:%d : unsupported format bits %#x\n",
+		pr_info("%d:%u:%d : unsupported format bits %#x\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting, format);
 	}
 
Index: usb-3.10/sound/usb/mixer.c
===================================================================
--- usb-3.10.orig/sound/usb/mixer.c
+++ usb-3.10/sound/usb/mixer.c
@@ -839,8 +839,7 @@ static void volume_control_quirks(struct
 	case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
 	case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra */
 		if (strcmp(kctl->id.name, "Effect Duration") == 0) {
-			snd_printk(KERN_INFO
-				"usb-audio: set quirk for FTU Effect Duration\n");
+			pr_info("usb-audio: set quirk for FTU Effect Duration\n");
 			cval->min = 0x0000;
 			cval->max = 0x7f00;
 			cval->res = 0x0100;
@@ -848,8 +847,7 @@ static void volume_control_quirks(struct
 		}
 		if (strcmp(kctl->id.name, "Effect Volume") == 0 ||
 		    strcmp(kctl->id.name, "Effect Feedback Volume") == 0) {
-			snd_printk(KERN_INFO
-				"usb-audio: set quirks for FTU Effect Feedback/Volume\n");
+			pr_info("usb-audio: set quirks for FTU Effect Feedback/Volume\n");
 			cval->min = 0x00;
 			cval->max = 0x7f;
 			break;
@@ -867,16 +865,14 @@ static void volume_control_quirks(struct
 	 */
 		if (!strcmp(kctl->id.name, "PCM Playback Volume") &&
 		    cval->min == -15616) {
-			snd_printk(KERN_INFO
-				 "set volume quirk for UDA1321/N101 chip\n");
+			pr_info("set volume quirk for UDA1321/N101 chip\n");
 			cval->max = -256;
 		}
 		break;
 
 	case USB_ID(0x046d, 0x09a4):
 		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
-			snd_printk(KERN_INFO
-				"set volume quirk for QuickCam E3500\n");
+			pr_info("set volume quirk for QuickCam E3500\n");
 			cval->min = 6080;
 			cval->max = 8768;
 			cval->res = 192;
@@ -892,8 +888,7 @@ static void volume_control_quirks(struct
 	 * Proboly there is some logitech magic behind this number --fishor
 	 */
 		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
-			snd_printk(KERN_INFO
-				"set resolution quirk: cval->res = 384\n");
+			pr_info("set resolution quirk: cval->res = 384\n");
 			cval->res = 384;
 		}
 		break;
@@ -1366,14 +1361,12 @@ static int parse_audio_feature_unit(stru
 	/* master configuration quirks */
 	switch (state->chip->usb_id) {
 	case USB_ID(0x08bb, 0x2702):
-		snd_printk(KERN_INFO
-			   "usbmixer: master volume quirk for PCM2702 chip\n");
+		pr_info("usbmixer: master volume quirk for PCM2702 chip\n");
 		/* disable non-functional volume control */
 		master_bits &= ~UAC_CONTROL_BIT(UAC_FU_VOLUME);
 		break;
 	case USB_ID(0x1130, 0xf211):
-		snd_printk(KERN_INFO
-			   "usbmixer: volume control quirk for Tenx TP6911 Audio Headset\n");
+		pr_info("usbmixer: volume control quirk for Tenx TP6911 Audio Headset\n");
 		/* disable non-functional volume control */
 		channels = 0;
 		break;
Index: usb-3.10/sound/usb/quirks.c
===================================================================
--- usb-3.10.orig/sound/usb/quirks.c
+++ usb-3.10/sound/usb/quirks.c
@@ -381,7 +381,7 @@ static int snd_usb_fasttrackpro_boot_qui
 	int err;
 
 	if (dev->actconfig->desc.bConfigurationValue == 1) {
-		snd_printk(KERN_INFO "usb-audio: "
+		pr_info("usb-audio: "
 			   "Fast Track Pro switching to config #2\n");
 		/* This function has to be available by the usb core module.
 		 * if it is not avialable the boot quirk has to be left out
@@ -397,7 +397,7 @@ static int snd_usb_fasttrackpro_boot_qui
 		   configuration */
 		return -ENODEV;
 	} else
-		snd_printk(KERN_INFO "usb-audio: Fast Track Pro config OK\n");
+		pr_info("usb-audio: Fast Track Pro config OK\n");
 
 	return 0;
 }
@@ -593,7 +593,7 @@ static int snd_usb_mbox2_boot_quirk(stru
 
 	mbox2_setup_48_24_magic(dev);
 
-	snd_printk(KERN_INFO "usb-audio: Digidesign Mbox 2: 24bit 48kHz");
+	pr_info("usb-audio: Digidesign Mbox 2: 24bit 48kHz");
 
 	return 0; /* Successful boot */
 }
Index: usb-3.10/sound/isa/wavefront/wavefront.c
===================================================================
--- usb-3.10.orig/sound/isa/wavefront/wavefront.c
+++ usb-3.10/sound/isa/wavefront/wavefront.c
@@ -195,7 +195,7 @@ snd_wavefront_pnp (int dev, snd_wavefron
 			cs4232_mpu_irq[dev] = pnp_irq(pdev, 0);
 		}
 
-		snd_printk (KERN_INFO "CS4232 MPU: port=0x%lx, irq=%i\n", 
+		pr_info("CS4232 MPU: port=0x%lx, irq=%i\n",
 			    cs4232_mpu_port[dev], 
 			    cs4232_mpu_irq[dev]);
 	}
