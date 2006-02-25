From: Giuliano Pochini <pochini@shiny.it>
Subject: [RFC] echoaudio, suspend/resume
Date: Sat, 25 Feb 2006 17:41:17 +0100
Message-ID: <20060225174117.1979de90.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



The following patch is not to be merged yet. It adds suspend/resume support
to the echoaudio driver. It's ready for testing if someone wants to give it
a try. Maybe some detail is missing, but it should work on all cards.

The problem is that the DSP "dies" if the driver tries to send it a command
(for example, set the output volume) after is has been shut down and a
reboot is required to resurrect it. ALSA doesn't automatically prevent the
user from accessing the card when it's suspended. Is there a simple way to
to it ?


For who want to try:

# lspci
...
0001:10:14.0 Multimedia controller: Motorola DSP56361 Digital Signal Processor (rev 01)
...
(this is the Gina3G)

suspend:
# echo -n 3 > /sys/devices/pci0001\:10/0001\:10\:14.0/power/state

resume:
# echo -n 0 > /sys/devices/pci0001\:10/0001\:10\:14.0/power/state




diff -dup alsa-driver__orig/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver__orig/pci/echoaudio/echoaudio.c	2006-02-23 22:41:31.000000000 +0100
+++ alsa-driver/pci/echoaudio/echoaudio.c	2006-02-25 17:17:35.000000000 +0100
@@ -654,6 +654,8 @@ static int pcm_trigger(struct snd_pcm_su
 
 	spin_lock(&chip->lock);
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+snd_printk("tri res1\n");
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		DE_ACT(("pcm_trigger start\n"));
@@ -676,6 +678,8 @@ static int pcm_trigger(struct snd_pcm_su
 		}
 		err = start_transport(chip, channelmask, chip->pipe_cyclic_mask);
 		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+snd_printk("tri sus1\n");
 	case SNDRV_PCM_TRIGGER_STOP:
 		DE_ACT(("pcm_trigger stop\n"));
 		for (i = 0; i < DSP_MAXPIPES; i++) {
@@ -692,6 +696,7 @@ static int pcm_trigger(struct snd_pcm_su
 			if (channelmask & (1 << i)) {
 				pipe = chip->substream[i]->runtime->private_data;
 				pipe->state = PIPE_STATE_PAUSED;
+snd_printk("tri sus2 %d\n", i);
 			}
 		}
 		err = pause_transport(chip, channelmask);
@@ -2016,6 +2021,74 @@ ctl_error:
 
 
 
+#ifdef CONFIG_PM
+
+static int snd_echo_suspend(struct pci_dev *pci, pm_message_t state)
+{
+	struct echoaudio *chip = pci_get_drvdata(pci);
+
+snd_printk("sus sus1\n");
+	snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3cold);
+	snd_pcm_suspend_all(chip->analog_pcm);
+	snd_pcm_suspend_all(chip->digital_pcm);
+
+	if (chip->meters_enabled)
+		send_vector(chip, DSP_VC_METERS_OFF);
+#ifdef ECHOCARD_HAS_MIDI
+	enable_midi_input(chip, FALSE);
+#endif
+	chip->dsp_code = NULL;
+	send_vector(chip, DSP_VC_GO_COMATOSE);
+	pci_set_power_state(pci, PCI_D3cold);
+	pci_disable_device(pci);
+	pci_save_state(pci);
+snd_printk("sus sus2\n");
+	return 0;
+}
+
+
+
+static int snd_echo_resume(struct pci_dev *pci)
+{
+	struct echoaudio *chip = pci_get_drvdata(pci);
+	int err;
+
+	pci_restore_state(pci);
+	pci_enable_device(pci);
+	pci_set_power_state(pci, PCI_D0);
+	pci_set_master(pci);
+
+snd_printk("res res1\n");
+	if ((err = load_firmware(chip)) < 0)
+		return err;
+snd_printk("res res2\n");
+	chip->bad_board = FALSE;
+
+#ifdef ECHOCARD_HAS_DIGITAL_MODE_SWITCH
+	if ((err = set_digital_mode(chip, chip->digital_mode)) < 0)
+		return err;
+#endif /* ECHOCARD_HAS_DIGITAL_MODE_SWITCH */
+
+#ifdef ECHOCARD_HAS_DIGITAL_IO
+	if ((err = set_professional_spdif(chip, chip->professional_spdif)) < 0)
+		return err;
+#endif /* ECHOCARD_HAS_DIGITAL_IO */
+
+#ifdef ECHOCARD_HAS_PHANTOM_POWER
+	if (chip->has_phantom_power && chip->phantom_power)
+		if ((err = set_phantom_power(chip, TRUE)) < 0)
+			return err;
+#endif /* ECHOCARD_HAS_PHANTOM_POWER */
+
+	snd_printk("res res3 %d\n", chip->meters_enabled);
+	snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
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
@@ -2037,6 +2110,10 @@ static struct pci_driver driver = {
 	.name = "Echoaudio " ECHOCARD_NAME,
 	.id_table = snd_echo_ids,
 	.probe = snd_echo_probe,
+#ifdef CONFIG_PM
+	.suspend = snd_echo_suspend,
+	.resume = snd_echo_resume,
+#endif /* CONFIG_PM */
 	.remove = __devexit_p(snd_echo_remove),
 };
 
diff -dup alsa-driver__orig/pci/echoaudio/echoaudio_3g.c alsa-driver/pci/echoaudio/echoaudio_3g.c
--- alsa-driver__orig/pci/echoaudio/echoaudio_3g.c	2006-01-12 22:28:51.000000000 +0100
+++ alsa-driver/pci/echoaudio/echoaudio_3g.c	2006-02-11 18:54:14.000000000 +0100
@@ -100,7 +100,7 @@ static int set_digital_mode(struct echoa
 	int err, i, o;
 
 	/* All audio channels must be closed before changing the digital mode */
-	snd_assert(!chip->pipe_alloc_mask, return -EAGAIN);
+//	snd_assert(!chip->pipe_alloc_mask, return -EAGAIN);
 
 	snd_assert(chip->digital_modes & (1 << mode), return -EINVAL);
 
diff -dup alsa-driver__orig/pci/echoaudio/echoaudio_gml.c alsa-driver/pci/echoaudio/echoaudio_gml.c
--- alsa-driver__orig/pci/echoaudio/echoaudio_gml.c	2006-01-12 22:28:51.000000000 +0100
+++ alsa-driver/pci/echoaudio/echoaudio_gml.c	2006-02-25 15:51:56.000000000 +0100
@@ -110,7 +110,7 @@ static int set_digital_mode(struct echoa
 		return -EIO;
 
 	/* All audio channels must be closed before changing the digital mode */
-	snd_assert(!chip->pipe_alloc_mask, return -EAGAIN);
+//	snd_assert(!chip->pipe_alloc_mask, return -EAGAIN);
 
 	snd_assert(chip->digital_modes & (1 << mode), return -EINVAL);
 


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
