From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: /proc cleanup
Date: Tue, 15 Feb 2005 15:02:42 -0500
Message-ID: <1108497762.7826.37.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-FSphHAsHAWcjEp0XUlvm"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-FSphHAsHAWcjEp0XUlvm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds a "voices" /proc entry for debugging the voice
allocator.  It also increases the size of the ptr_regs files to display
the values for all channels.  Finally it updates the names of the EFX
recording inputs from "???" to "FXBUS2_*".

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Lee



--=-FSphHAsHAWcjEp0XUlvm
Content-Disposition: attachment; filename=pre-011-proc-cleanup.patch
Content-Type: text/x-patch; name=pre-011-proc-cleanup.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-old/alsa-kernel/pci/emu10k1/emuproc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emuproc.c,v
retrieving revision 1.23
diff -u -r1.23 emuproc.c
--- alsa-old/alsa-kernel/pci/emu10k1/emuproc.c	23 Nov 2004 15:06:17 -0000	1.23
+++ alsa-old/alsa-kernel/pci/emu10k1/emuproc.c	13 Feb 2005 04:13:38 -0000
@@ -140,38 +140,38 @@
 		/* 29 */ "???",
 		/* 30 */ "???",
 		/* 31 */ "???",
-		/* 32 */ "???",
-		/* 33 */ "???",
-		/* 34 */ "???",
-		/* 35 */ "???",
-		/* 36 */ "???",
-		/* 37 */ "???",
-		/* 38 */ "???",
-		/* 39 */ "???",
-		/* 40 */ "???",
-		/* 41 */ "???",
-		/* 42 */ "???",
-		/* 43 */ "???",
-		/* 44 */ "???",
-		/* 45 */ "???",
-		/* 46 */ "???",
-		/* 47 */ "???",
-		/* 48 */ "???",
-		/* 49 */ "???",
-		/* 50 */ "???",
-		/* 51 */ "???",
-		/* 52 */ "???",
-		/* 53 */ "???",
-		/* 54 */ "???",
-		/* 55 */ "???",
-		/* 56 */ "???",
-		/* 57 */ "???",
-		/* 58 */ "???",
-		/* 59 */ "???",
-		/* 60 */ "???",
-		/* 61 */ "???",
-		/* 62 */ "???",
-		/* 33 */ "???"
+		/* 32 */ "FXBUS2_0",
+		/* 33 */ "FXBUS2_1",
+		/* 34 */ "FXBUS2_2",
+		/* 35 */ "FXBUS2_3",
+		/* 36 */ "FXBUS2_4",
+		/* 37 */ "FXBUS2_5",
+		/* 38 */ "FXBUS2_6",
+		/* 39 */ "FXBUS2_7",
+		/* 40 */ "FXBUS2_8",
+		/* 41 */ "FXBUS2_9",
+		/* 42 */ "FXBUS2_10",
+		/* 43 */ "FXBUS2_11",
+		/* 44 */ "FXBUS2_12",
+		/* 45 */ "FXBUS2_13",
+		/* 46 */ "FXBUS2_14",
+		/* 47 */ "FXBUS2_15",
+		/* 48 */ "FXBUS2_16",
+		/* 49 */ "FXBUS2_17",
+		/* 50 */ "FXBUS2_18",
+		/* 51 */ "FXBUS2_19",
+		/* 52 */ "FXBUS2_20",
+		/* 53 */ "FXBUS2_21",
+		/* 54 */ "FXBUS2_22",
+		/* 55 */ "FXBUS2_23",
+		/* 56 */ "FXBUS2_24",
+		/* 57 */ "FXBUS2_25",
+		/* 58 */ "FXBUS2_26",
+		/* 59 */ "FXBUS2_27",
+		/* 60 */ "FXBUS2_28",
+		/* 61 */ "FXBUS2_29",
+		/* 62 */ "FXBUS2_30",
+		/* 63 */ "FXBUS2_31"
 	};
 
 	emu10k1_t *emu = entry->private_data;
@@ -221,7 +221,7 @@
 			snd_iprintf(buffer, "  Output %02i [%s]\n", idx, outputs[idx]);
 	}
 	snd_iprintf(buffer, "\nAll FX Outputs        :\n");
-	for (idx = 0; idx < 32; idx++)
+	for (idx = 0; idx < (emu->audigy ? 64 : 32); idx++)
 		snd_iprintf(buffer, "  Output %02i [%s]\n", idx, outputs[idx]);
 	snd_emu10k1_proc_spdif_status(emu, buffer, "S/PDIF Output 0", SPCS0, -1);
 	snd_emu10k1_proc_spdif_status(emu, buffer, "S/PDIF Output 1", SPCS1, -1);
@@ -322,6 +322,26 @@
 	return 0;
 }
 
+static void snd_emu10k1_proc_voices_read(snd_info_entry_t *entry, 
+				  snd_info_buffer_t * buffer)
+{
+	emu10k1_t *emu = entry->private_data;
+	emu10k1_voice_t *voice;
+	int idx;
+	
+	snd_iprintf(buffer, "ch\tuse\tpcm\tefx\tsynth\tmidi\n");
+	for (idx = 0; idx < NUM_G; idx++) {
+		voice = &emu->voices[idx];
+		snd_iprintf(buffer, "%i\t%i\t%i\t%i\t%i\t%i\n",
+			idx,
+			voice->use,
+			voice->pcm,
+			voice->efx,
+			voice->synth,
+			voice->midi);
+	}
+}
+
 #ifdef CONFIG_SND_DEBUG
 static void snd_emu_proc_io_reg_read(snd_info_entry_t *entry,
 				     snd_info_buffer_t * buffer)
@@ -405,7 +425,7 @@
 	snd_iprintf(buffer, "Registers 0x%x\n", iobase);
 	for(i = offset; i < offset+length; i++) {
 		snd_iprintf(buffer, "%02X: ",i);
-		for (j = 0; j < 4; j++) {
+		for (j = 0; j < 64; j++) {
 			if(iobase == 0)
                 		value = snd_ptr_read(emu, 0, i, j);
 			else
@@ -482,22 +502,22 @@
 		entry->c.text.write = snd_emu_proc_io_reg_write;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs00a", &entry)) {
-		snd_info_set_text_ops(entry, emu, 1024, snd_emu_proc_ptr_reg_read00a);
+		snd_info_set_text_ops(entry, emu, 65536, snd_emu_proc_ptr_reg_read00a);
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs00b", &entry)) {
-		snd_info_set_text_ops(entry, emu, 1024, snd_emu_proc_ptr_reg_read00b);
+		snd_info_set_text_ops(entry, emu, 65536, snd_emu_proc_ptr_reg_read00b);
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs20a", &entry)) {
-		snd_info_set_text_ops(entry, emu, 1024, snd_emu_proc_ptr_reg_read20a);
+		snd_info_set_text_ops(entry, emu, 65536, snd_emu_proc_ptr_reg_read20a);
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs20b", &entry)) {
-		snd_info_set_text_ops(entry, emu, 1024, snd_emu_proc_ptr_reg_read20b);
+		snd_info_set_text_ops(entry, emu, 65536, snd_emu_proc_ptr_reg_read20b);
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
 	}
@@ -506,6 +526,9 @@
 	if (! snd_card_proc_new(emu->card, "emu10k1", &entry))
 		snd_info_set_text_ops(entry, emu, 2048, snd_emu10k1_proc_read);
 
+	if (! snd_card_proc_new(emu->card, "voices", &entry))
+		snd_info_set_text_ops(entry, emu, 2048, snd_emu10k1_proc_voices_read);
+
 	if (! snd_card_proc_new(emu->card, "fx8010_gpr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;

--=-FSphHAsHAWcjEp0XUlvm--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
