From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 4/5] Echoaudio - add suspend/resume support
Date: Sat, 30 Jan 2010 16:32:26 +0100
Message-ID: <20100130163226.02010ead@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EB5010385A
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 16:33:07 +0100 (CET)
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


4/5 Add suspend support #2:
	This patch adds suspend and resume callbacks.
	It also rearranges parts of the initialization code so it can be
	used in both the first initialization (when the module is loaded we
	also have to load default settings) and the resume callback (where
	we have to restore the previous settings).
	P.S. I'll fix "rettings" later.

Short description:

This patch adds rearranges parts of the initialization code and adds
suspend and resume callbacks.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>


diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio.c	2010-01-29 23:09:09.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c	2010-01-29 23:11:43.000000000 +0100
@@ -753,6 +753,8 @@ static int pcm_trigger(struct snd_pcm_su
 
 	spin_lock(&chip->lock);
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+		DE_ACT(("pcm_trigger resume\n"));
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		DE_ACT(("pcm_trigger start\n"));
@@ -776,6 +778,8 @@ static int pcm_trigger(struct snd_pcm_su
 		err = start_transport(chip, channelmask,
 				      chip->pipe_cyclic_mask);
 		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		DE_ACT(("pcm_trigger suspend\n"));
 	case SNDRV_PCM_TRIGGER_STOP:
 		DE_ACT(("pcm_trigger stop\n"));
 		for (i = 0; i < DSP_MAXPIPES; i++) {
@@ -1951,18 +1955,27 @@ static __devinit int snd_echo_create(str
 		return err;
 	pci_set_master(pci);
 
-	/* allocate a chip-specific data */
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (!chip) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+	/* Allocate chip if needed */
+	if (!*rchip) {
+		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+		if (!chip) {
+			pci_disable_device(pci);
+			return -ENOMEM;
+		}
+		DE_INIT(("chip=%p\n", chip));
+		spin_lock_init(&chip->lock);
+		chip->card = card;
+		chip->pci = pci;
+		chip->irq = -1;
+		atomic_set(&chip->opencount, 0);
+		mutex_init(&chip->mode_mutex);
+		chip->can_set_rate = 1;
+	} else {
+		/* If this was called from the resume function, chip is
+		 * already allocated and it contains current card settings.
+		 */
+		chip = *rchip;
 	}
-	DE_INIT(("chip=%p\n", chip));
-
-	spin_lock_init(&chip->lock);
-	chip->card = card;
-	chip->pci = pci;
-	chip->irq = -1;
 
 	/* PCI resource allocation */
 	chip->dsp_registers_phys = pci_resource_start(pci, 0);
@@ -2002,7 +2015,9 @@ static __devinit int snd_echo_create(str
 	chip->comm_page = (struct comm_page *)chip->commpage_dma_buf.area;
 
 	err = init_hw(chip, chip->pci->device, chip->pci->subsystem_device);
-	if (err) {
+	if (err >= 0)
+		err = set_mixer_defaults(chip);
+	if (err < 0) {
 		DE_INIT(("init_hw err=%d\n", err));
 		snd_echo_free(chip);
 		return err;
@@ -2013,9 +2028,6 @@ static __devinit int snd_echo_create(str
 		snd_echo_free(chip);
 		return err;
 	}
-	atomic_set(&chip->opencount, 0);
-	mutex_init(&chip->mode_mutex);
-	chip->can_set_rate = 1;
 	*rchip = chip;
 	/* Init done ! */
 	return 0;
@@ -2048,6 +2060,7 @@ static int __devinit snd_echo_probe(stru
 
 	snd_card_set_dev(card, &pci->dev);
 
+	chip = NULL;	/* Tells snd_echo_create to allocate chip */
 	if ((err = snd_echo_create(card, pci, &chip)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -2187,6 +2200,112 @@ ctl_error:
 
 
 
+#if defined(CONFIG_PM)
+
+static int snd_echo_suspend(struct pci_dev *pci, pm_message_t state)
+{
+	struct echoaudio *chip = pci_get_drvdata(pci);
+
+	DE_INIT(("suspend start\n"));
+	snd_pcm_suspend_all(chip->analog_pcm);
+	snd_pcm_suspend_all(chip->digital_pcm);
+
+#ifdef ECHOCARD_HAS_MIDI
+	/* This call can sleep */
+	if (chip->midi_out)
+		snd_echo_midi_output_trigger(chip->midi_out, 0);
+#endif
+	spin_lock_irq(&chip->lock);
+	if (wait_handshake(chip)) {
+		spin_unlock_irq(&chip->lock);
+		return -EIO;
+	}
+	clear_handshake(chip);
+	if (send_vector(chip, DSP_VC_GO_COMATOSE) < 0) {
+		spin_unlock_irq(&chip->lock);
+		return -EIO;
+	}
+	spin_unlock_irq(&chip->lock);
+
+	chip->dsp_code = NULL;
+	free_irq(chip->irq, chip);
+	chip->irq = -1;
+	pci_save_state(pci);
+	pci_disable_device(pci);
+
+	DE_INIT(("suspend done\n"));
+	return 0;
+}
+
+
+
+static int snd_echo_resume(struct pci_dev *pci)
+{
+	struct echoaudio *chip = pci_get_drvdata(pci);
+	struct comm_page *commpage, *commpage_bak;
+	u32 pipe_alloc_mask;
+	int err;
+
+	DE_INIT(("resume start\n"));
+	pci_restore_state(pci);
+	commpage_bak = kmalloc(sizeof(struct echoaudio), GFP_KERNEL);
+	commpage = chip->comm_page;
+	memcpy(commpage_bak, commpage, sizeof(struct comm_page));
+
+	err = init_hw(chip, chip->pci->device, chip->pci->subsystem_device);
+	if (err < 0) {
+		kfree(commpage_bak);
+		DE_INIT(("resume init_hw err=%d\n", err));
+		snd_echo_free(chip);
+		return err;
+	}
+	DE_INIT(("resume init OK\n"));
+
+	/* Temporarily set chip->pipe_alloc_mask=0 otherwise
+	 * restore_dsp_settings() fails.
+	 */
+	pipe_alloc_mask = chip->pipe_alloc_mask;
+	chip->pipe_alloc_mask = 0;
+	err = restore_dsp_rettings(chip);
+	chip->pipe_alloc_mask = pipe_alloc_mask;
+	if (err < 0) {
+		kfree(commpage_bak);
+		return err;
+	}
+	DE_INIT(("resume restore OK\n"));
+
+	memcpy(&commpage->audio_format, &commpage_bak->audio_format,
+		sizeof(commpage->audio_format));
+	memcpy(&commpage->sglist_addr, &commpage_bak->sglist_addr,
+		sizeof(commpage->sglist_addr));
+	memcpy(&commpage->midi_output, &commpage_bak->midi_output,
+		sizeof(commpage->midi_output));
+	kfree(commpage_bak);
+
+	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
+			ECHOCARD_NAME, chip)) {
+		snd_echo_free(chip);
+		snd_printk(KERN_ERR "cannot grab irq\n");
+		return -EBUSY;
+	}
+	chip->irq = pci->irq;
+	DE_INIT(("resume irq=%d\n", chip->irq));
+
+#ifdef ECHOCARD_HAS_MIDI
+	if (chip->midi_input_enabled)
+		enable_midi_input(chip, TRUE);
+	if (chip->midi_out)
+		snd_echo_midi_output_trigger(chip->midi_out, 1);
+#endif
+
+	DE_INIT(("resume done\n"));
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
+
+
 static void __devexit snd_echo_remove(struct pci_dev *pci)
 {
 	struct echoaudio *chip;
@@ -2209,6 +2328,10 @@ static struct pci_driver driver = {
 	.id_table = snd_echo_ids,
 	.probe = snd_echo_probe,
 	.remove = __devexit_p(snd_echo_remove),
+#ifdef CONFIG_PM
+	.suspend = snd_echo_suspend,
+	.resume = snd_echo_resume,
+#endif /* CONFIG_PM */
 };
 
 
Only in alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/: echoaudio.c.orig
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -497,9 +497,6 @@ static int load_firmware(struct echoaudi
 	if ((box_type = load_asic(chip)) < 0)
 		return box_type;	/* error */
 
-	if ((err = restore_dsp_rettings(chip)) < 0)
-		return err;
-
 	return box_type;
 }
 
@@ -659,51 +656,106 @@ static void get_audio_meters(struct echo
 
 static int restore_dsp_rettings(struct echoaudio *chip)
 {
-	int err;
+	int i, o, err;
 	DE_INIT(("restore_dsp_settings\n"));
 
 	if ((err = check_asic_status(chip)) < 0)
 		return err;
 
-	/* @ Gina20/Darla20 only. Should be harmless for other cards. */
+	/* Gina20/Darla20 only. Should be harmless for other cards. */
 	chip->comm_page->gd_clock_state = GD_CLOCK_UNDEF;
 	chip->comm_page->gd_spdif_status = GD_SPDIF_STATUS_UNDEF;
 	chip->comm_page->handshake = 0xffffffff;
 
-	if ((err = set_sample_rate(chip, chip->sample_rate)) < 0)
+	/* Restore output busses */
+	for (i = 0; i < num_busses_out(chip); i++) {
+		err = set_output_gain(chip, i, chip->output_gain[i]);
+		if (err < 0)
+			return err;
+	}
+
+#ifdef ECHOCARD_HAS_VMIXER
+	for (i = 0; i < num_pipes_out(chip); i++)
+		for (o = 0; o < num_busses_out(chip); o++) {
+			err = set_vmixer_gain(chip, o, i,
+						chip->vmixer_gain[o][i]);
+			if (err < 0)
+				return err;
+		}
+	if (update_vmixer_level(chip) < 0)
+		return -EIO;
+#endif /* ECHOCARD_HAS_VMIXER */
+
+#ifdef ECHOCARD_HAS_MONITOR
+	for (o = 0; o < num_busses_out(chip); o++)
+		for (i = 0; i < num_busses_in(chip); i++) {
+			err = set_monitor_gain(chip, o, i,
+						chip->monitor_gain[o][i]);
+			if (err < 0)
+				return err;
+		}
+#endif /* ECHOCARD_HAS_MONITOR */
+
+#ifdef ECHOCARD_HAS_INPUT_GAIN
+	for (i = 0; i < num_busses_in(chip); i++) {
+		err = set_input_gain(chip, i, chip->input_gain[i]);
+		if (err < 0)
+			return err;
+	}
+#endif /* ECHOCARD_HAS_INPUT_GAIN */
+
+	err = update_output_line_level(chip);
+	if (err < 0)
 		return err;
 
-	if (chip->meters_enabled)
-		if (send_vector(chip, DSP_VC_METERS_ON) < 0)
-			return -EIO;
+	err = update_input_line_level(chip);
+	if (err < 0)
+		return err;
 
-#ifdef ECHOCARD_HAS_EXTERNAL_CLOCK
-	if (set_input_clock(chip, chip->input_clock) < 0)
+	err = set_sample_rate(chip, chip->sample_rate);
+	if (err < 0)
+		return err;
+
+	if (chip->meters_enabled) {
+		err = send_vector(chip, DSP_VC_METERS_ON);
+		if (err < 0)
+			return err;
+	}
+
+#ifdef ECHOCARD_HAS_DIGITAL_MODE_SWITCH
+	if (set_digital_mode(chip, chip->digital_mode) < 0)
 		return -EIO;
 #endif
 
-#ifdef ECHOCARD_HAS_OUTPUT_CLOCK_SWITCH
-	if (set_output_clock(chip, chip->output_clock) < 0)
+#ifdef ECHOCARD_HAS_DIGITAL_IO
+	if (set_professional_spdif(chip, chip->professional_spdif) < 0)
 		return -EIO;
 #endif
 
-	if (update_output_line_level(chip) < 0)
+#ifdef ECHOCARD_HAS_PHANTOM_POWER
+	if (set_phantom_power(chip, chip->phantom_power) < 0)
 		return -EIO;
+#endif
 
-	if (update_input_line_level(chip) < 0)
+#ifdef ECHOCARD_HAS_EXTERNAL_CLOCK
+	/* set_input_clock() also restores automute setting */
+	if (set_input_clock(chip, chip->input_clock) < 0)
 		return -EIO;
+#endif
 
-#ifdef ECHOCARD_HAS_VMIXER
-	if (update_vmixer_level(chip) < 0)
+#ifdef ECHOCARD_HAS_OUTPUT_CLOCK_SWITCH
+	if (set_output_clock(chip, chip->output_clock) < 0)
 		return -EIO;
 #endif
 
 	if (wait_handshake(chip) < 0)
 		return -EIO;
 	clear_handshake(chip);
+	if (send_vector(chip, DSP_VC_UPDATE_FLAGS) < 0)
+		return -EIO;
 
 	DE_INIT(("restore_dsp_rettings done\n"));
-	return send_vector(chip, DSP_VC_UPDATE_FLAGS);
+	return 0;
 }
 
 
@@ -920,9 +972,6 @@ static int init_dsp_comm_page(struct ech
 	chip->card_name = ECHOCARD_NAME;
 	chip->bad_board = TRUE;	/* Set TRUE until DSP loaded */
 	chip->dsp_code = NULL;	/* Current DSP code not loaded */
-	chip->digital_mode = DIGITAL_MODE_NONE;
-	chip->input_clock = ECHO_CLOCK_INTERNAL;
-	chip->output_clock = ECHO_CLOCK_WORD;
 	chip->asic_loaded = FALSE;
 	memset(chip->comm_page, 0, sizeof(struct comm_page));
 
@@ -933,7 +982,6 @@ static int init_dsp_comm_page(struct ech
 	chip->comm_page->midi_out_free_count =
 		cpu_to_le32(DSP_MIDI_OUT_FIFO_SIZE);
 	chip->comm_page->sample_rate = cpu_to_le32(44100);
-	chip->sample_rate = 44100;
 
 	/* Set line levels so we don't blast any inputs on startup */
 	memset(chip->comm_page->monitors, ECHOGAIN_MUTED, MONITOR_ARRAY_SIZE);
@@ -944,50 +992,21 @@ static int init_dsp_comm_page(struct ech
 
 
 
-/* This function initializes the several volume controls for busses and pipes.
-This MUST be called after the DSP is up and running ! */
+/* This function initializes the chip structure with default values, ie. all
+ * muted and internal clock source. Then it copies the settings to the DSP.
+ * This MUST be called after the DSP is up and running !
+ */
 static int init_line_levels(struct echoaudio *chip)
 {
-	int st, i, o;
-
 	DE_INIT(("init_line_levels\n"));
-
-	/* Mute output busses */
-	for (i = 0; i < num_busses_out(chip); i++)
-		if ((st = set_output_gain(chip, i, ECHOGAIN_MUTED)))
-			return st;
-	if ((st = update_output_line_level(chip)))
-		return st;
-
-#ifdef ECHOCARD_HAS_VMIXER
-	/* Mute the Vmixer */
-	for (i = 0; i < num_pipes_out(chip); i++)
-		for (o = 0; o < num_busses_out(chip); o++)
-			if ((st = set_vmixer_gain(chip, o, i, ECHOGAIN_MUTED)))
-				return st;
-	if ((st = update_vmixer_level(chip)))
-		return st;
-#endif /* ECHOCARD_HAS_VMIXER */
-
-#ifdef ECHOCARD_HAS_MONITOR
-	/* Mute the monitor mixer */
-	for (o = 0; o < num_busses_out(chip); o++)
-		for (i = 0; i < num_busses_in(chip); i++)
-			if ((st = set_monitor_gain(chip, o, i, ECHOGAIN_MUTED)))
-				return st;
-	if ((st = update_output_line_level(chip)))
-		return st;
-#endif /* ECHOCARD_HAS_MONITOR */
-
-#ifdef ECHOCARD_HAS_INPUT_GAIN
-	for (i = 0; i < num_busses_in(chip); i++)
-		if ((st = set_input_gain(chip, i, ECHOGAIN_MUTED)))
-			return st;
-	if ((st = update_input_line_level(chip)))
-		return st;
-#endif /* ECHOCARD_HAS_INPUT_GAIN */
-
-	return 0;
+	memset(chip->output_gain, ECHOGAIN_MUTED, sizeof(chip->output_gain));
+	memset(chip->input_gain, ECHOGAIN_MUTED, sizeof(chip->input_gain));
+	memset(chip->monitor_gain, ECHOGAIN_MUTED, sizeof(chip->monitor_gain));
+	memset(chip->vmixer_gain, ECHOGAIN_MUTED, sizeof(chip->vmixer_gain));
+	chip->input_clock = ECHO_CLOCK_INTERNAL;
+	chip->output_clock = ECHO_CLOCK_WORD;
+	chip->sample_rate = 44100;
+	return restore_dsp_rettings(chip);
 }
 
 
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio.h alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.h
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio.h	2010-01-29 23:08:36.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.h	2010-01-29 23:11:43.000000000 +0100
@@ -472,6 +472,8 @@ static void free_firmware(const struct f
 
 #ifdef ECHOCARD_HAS_MIDI
 static int enable_midi_input(struct echoaudio *chip, char enable);
+static void snd_echo_midi_output_trigger(
+			struct snd_rawmidi_substream *substream, int up);
 static int midi_service_irq(struct echoaudio *chip);
 static int __devinit snd_echo_midi_create(struct snd_card *card,
 					  struct echoaudio *chip);


-- 
Giuliano.
