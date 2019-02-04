From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/11] ALSA: pci: Clean up with new procfs
	helpers
Date: Mon,  4 Feb 2019 16:20:33 +0100
Message-ID: <20190204152036.14102-9-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DEE5226755D
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8D52DAF4A
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:40 +0000 (UTC)
In-Reply-To: <20190204152036.14102-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Simplify the proc fs creation code with new helper functions,
snd_card_ro_proc_new() and snd_card_rw_proc_new().
Just a code refactoring and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ad1889.c               |  6 +--
 sound/pci/ak4531_codec.c         |  5 +--
 sound/pci/ali5451/ali5451.c      |  4 +-
 sound/pci/asihpi/asihpi.c        |  6 +--
 sound/pci/atiixp.c               |  5 +--
 sound/pci/atiixp_modem.c         |  6 +--
 sound/pci/ca0106/ca0106_proc.c   | 40 ++++++++------------
 sound/pci/cmipci.c               |  5 +--
 sound/pci/cs4281.c               |  3 +-
 sound/pci/emu10k1/emu10k1x.c     | 12 ++----
 sound/pci/emu10k1/emuproc.c      | 81 +++++++++++++++-------------------------
 sound/pci/ens1370.c              |  6 +--
 sound/pci/hda/hda_proc.c         |  9 +----
 sound/pci/ice1712/ice1712.c      |  5 +--
 sound/pci/ice1712/ice1724.c      |  5 +--
 sound/pci/ice1712/pontis.c       | 12 ++----
 sound/pci/ice1712/prodigy192.c   |  5 +--
 sound/pci/ice1712/prodigy_hifi.c |  8 +---
 sound/pci/ice1712/quartet.c      |  4 +-
 sound/pci/intel8x0.c             |  6 +--
 sound/pci/intel8x0m.c            |  6 +--
 sound/pci/korg1212/korg1212.c    |  6 +--
 sound/pci/lola/lola_proc.c       | 16 +++-----
 sound/pci/lx6464es/lx6464es.c    |  8 +---
 sound/pci/mixart/mixart.c        |  6 +--
 sound/pci/oxygen/oxygen_lib.c    |  5 +--
 sound/pci/pcxhr/pcxhr.c          | 21 ++++-------
 sound/pci/riptide/riptide.c      |  6 +--
 sound/pci/rme32.c                |  5 +--
 sound/pci/rme96.c                |  5 +--
 sound/pci/rme9652/hdsp.c         |  5 +--
 sound/pci/rme9652/hdspm.c        | 55 ++++++++++++---------------
 sound/pci/rme9652/rme9652.c      |  6 +--
 sound/pci/sonicvibes.c           |  6 +--
 sound/pci/trident/trident_main.c |  4 +-
 sound/pci/via82xx.c              |  6 +--
 sound/pci/via82xx_modem.c        |  6 +--
 sound/pci/ymfpci/ymfpci_main.c   |  6 +--
 38 files changed, 133 insertions(+), 278 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index d9c54c08e2db..f333bbf41870 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -741,10 +741,8 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 static void
 snd_ad1889_proc_init(struct snd_ad1889 *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(chip->card, chip->card->driver, &entry))
-		snd_info_set_text_ops(entry, chip, snd_ad1889_proc_read);
+	snd_card_ro_proc_new(chip->card, chip->card->driver,
+			     chip, snd_ad1889_proc_read);
 }
 
 static const struct ac97_quirk ac97_quirks[] = {
diff --git a/sound/pci/ak4531_codec.c b/sound/pci/ak4531_codec.c
index 2fb1fbba3e5e..11e902cac71b 100644
--- a/sound/pci/ak4531_codec.c
+++ b/sound/pci/ak4531_codec.c
@@ -481,8 +481,5 @@ static void snd_ak4531_proc_read(struct snd_info_entry *entry,
 static void
 snd_ak4531_proc_init(struct snd_card *card, struct snd_ak4531 *ak4531)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(card, "ak4531", &entry))
-		snd_info_set_text_ops(entry, ak4531, snd_ak4531_proc_read);
+	snd_card_ro_proc_new(card, "ak4531", ak4531, snd_ak4531_proc_read);
 }
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index e781ccca1793..f7fbe05836b3 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2049,9 +2049,7 @@ static void snd_ali_proc_read(struct snd_info_entry *entry,
 
 static void snd_ali_proc_init(struct snd_ali *codec)
 {
-	struct snd_info_entry *entry;
-	if (!snd_card_proc_new(codec->card, "ali5451", &entry))
-		snd_info_set_text_ops(entry, codec, snd_ali_proc_read);
+	snd_card_ro_proc_new(codec->card, "ali5451", codec, snd_ali_proc_read);
 }
 
 static int snd_ali_resources(struct snd_ali *codec)
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index aad74e809797..32b2f9802479 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -2782,10 +2782,8 @@ snd_asihpi_proc_read(struct snd_info_entry *entry,
 
 static void snd_asihpi_proc_init(struct snd_card_asihpi *asihpi)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(asihpi->card, "info", &entry))
-		snd_info_set_text_ops(entry, asihpi, snd_asihpi_proc_read);
+	snd_card_ro_proc_new(asihpi->card, "info", asihpi,
+			     snd_asihpi_proc_read);
 }
 
 /*------------------------------------------------------------
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 7715d26916ac..169763c88f5e 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1543,10 +1543,7 @@ static void snd_atiixp_proc_read(struct snd_info_entry *entry,
 
 static void snd_atiixp_proc_init(struct atiixp *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "atiixp", &entry))
-		snd_info_set_text_ops(entry, chip, snd_atiixp_proc_read);
+	snd_card_ro_proc_new(chip->card, "atiixp", chip, snd_atiixp_proc_read);
 }
 
 
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index a357a8e2e73d..cece66bb3644 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1170,10 +1170,8 @@ static void snd_atiixp_proc_read(struct snd_info_entry *entry,
 
 static void snd_atiixp_proc_init(struct atiixp_modem *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "atiixp-modem", &entry))
-		snd_info_set_text_ops(entry, chip, snd_atiixp_proc_read);
+	snd_card_ro_proc_new(chip->card, "atiixp-modem", chip,
+			     snd_atiixp_proc_read);
 }
 
 
diff --git a/sound/pci/ca0106/ca0106_proc.c b/sound/pci/ca0106/ca0106_proc.c
index a2c85cc37972..f5b8934db735 100644
--- a/sound/pci/ca0106/ca0106_proc.c
+++ b/sound/pci/ca0106/ca0106_proc.c
@@ -424,30 +424,20 @@ static void snd_ca0106_proc_i2c_write(struct snd_info_entry *entry,
 
 int snd_ca0106_proc_init(struct snd_ca0106 *emu)
 {
-	struct snd_info_entry *entry;
-	
-	if(! snd_card_proc_new(emu->card, "iec958", &entry))
-		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_iec958);
-	if(! snd_card_proc_new(emu->card, "ca0106_reg32", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read32);
-		entry->c.text.write = snd_ca0106_proc_reg_write32;
-		entry->mode |= 0200;
-	}
-	if(! snd_card_proc_new(emu->card, "ca0106_reg16", &entry))
-		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read16);
-	if(! snd_card_proc_new(emu->card, "ca0106_reg8", &entry))
-		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read8);
-	if(! snd_card_proc_new(emu->card, "ca0106_regs1", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read1);
-		entry->c.text.write = snd_ca0106_proc_reg_write;
-		entry->mode |= 0200;
-	}
-	if(! snd_card_proc_new(emu->card, "ca0106_i2c", &entry)) {
-		entry->c.text.write = snd_ca0106_proc_i2c_write;
-		entry->private_data = emu;
-		entry->mode |= 0200;
-	}
-	if(! snd_card_proc_new(emu->card, "ca0106_regs2", &entry)) 
-		snd_info_set_text_ops(entry, emu, snd_ca0106_proc_reg_read2);
+	snd_card_ro_proc_new(emu->card, "iec958", emu, snd_ca0106_proc_iec958);
+	snd_card_rw_proc_new(emu->card, "ca0106_reg32", emu,
+			     snd_ca0106_proc_reg_read32,
+			     snd_ca0106_proc_reg_write32);
+	snd_card_ro_proc_new(emu->card, "ca0106_reg16", emu,
+			     snd_ca0106_proc_reg_read16);
+	snd_card_ro_proc_new(emu->card, "ca0106_reg8", emu,
+			     snd_ca0106_proc_reg_read8);
+	snd_card_rw_proc_new(emu->card, "ca0106_regs1", emu,
+			     snd_ca0106_proc_reg_read1,
+			     snd_ca0106_proc_reg_write);
+	snd_card_rw_proc_new(emu->card, "ca0106_i2c", emu, NULL,
+			     snd_ca0106_proc_i2c_write);
+	snd_card_ro_proc_new(emu->card, "ca0106_regs2", emu,
+			     snd_ca0106_proc_reg_read2);
 	return 0;
 }
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 5bbf31c1695c..701be04aed53 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -2792,10 +2792,7 @@ static void snd_cmipci_proc_read(struct snd_info_entry *entry,
 
 static void snd_cmipci_proc_init(struct cmipci *cm)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(cm->card, "cmipci", &entry))
-		snd_info_set_text_ops(entry, cm, snd_cmipci_proc_read);
+	snd_card_ro_proc_new(cm->card, "cmipci", cm, snd_cmipci_proc_read);
 }
 
 static const struct pci_device_id snd_cmipci_ids[] = {
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index a9fb819cad1d..15bbf9564c82 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1174,8 +1174,7 @@ static void snd_cs4281_proc_init(struct cs4281 *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "cs4281", &entry))
-		snd_info_set_text_ops(entry, chip, snd_cs4281_proc_read);
+	snd_card_ro_proc_new(chip->card, "cs4281", chip, snd_cs4281_proc_read);
 	if (! snd_card_proc_new(chip->card, "cs4281_BA0", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = chip;
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 611589cbdad6..576c7bd03a1a 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1065,15 +1065,9 @@ static void snd_emu10k1x_proc_reg_write(struct snd_info_entry *entry,
 
 static int snd_emu10k1x_proc_init(struct emu10k1x *emu)
 {
-	struct snd_info_entry *entry;
-	
-	if(! snd_card_proc_new(emu->card, "emu10k1x_regs", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_emu10k1x_proc_reg_read);
-		entry->c.text.write = snd_emu10k1x_proc_reg_write;
-		entry->mode |= 0200;
-		entry->private_data = emu;
-	}
-	
+	snd_card_rw_proc_new(emu->card, "emu10k1x_regs", emu,
+			     snd_emu10k1x_proc_reg_read,
+			     snd_emu10k1x_proc_reg_write);
 	return 0;
 }
 
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index b57008031792..a3d9f06e8e6a 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -568,55 +568,40 @@ int snd_emu10k1_proc_init(struct snd_emu10k1 *emu)
 	struct snd_info_entry *entry;
 #ifdef CONFIG_SND_DEBUG
 	if (emu->card_capabilities->emu_model) {
-		if (! snd_card_proc_new(emu->card, "emu1010_regs", &entry)) 
-			snd_info_set_text_ops(entry, emu, snd_emu_proc_emu1010_reg_read);
-	}
-	if (! snd_card_proc_new(emu->card, "io_regs", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_emu_proc_io_reg_read);
-		entry->c.text.write = snd_emu_proc_io_reg_write;
-		entry->mode |= 0200;
-	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs00a", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read00a);
-		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
-		entry->mode |= 0200;
-	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs00b", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read00b);
-		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
-		entry->mode |= 0200;
-	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs20a", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20a);
-		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
-		entry->mode |= 0200;
-	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs20b", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20b);
-		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
-		entry->mode |= 0200;
-	}
-	if (! snd_card_proc_new(emu->card, "ptr_regs20c", &entry)) {
-		snd_info_set_text_ops(entry, emu, snd_emu_proc_ptr_reg_read20c);
-		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
-		entry->mode |= 0200;
+		snd_card_ro_proc_new(emu->card, "emu1010_regs",
+				     emu, snd_emu_proc_emu1010_reg_read);
 	}
+	snd_card_rw_proc_new(emu->card, "io_regs", emu,
+			     snd_emu_proc_io_reg_read,
+			     snd_emu_proc_io_reg_write);
+	snd_card_rw_proc_new(emu->card, "ptr_regs00a", emu,
+			     snd_emu_proc_ptr_reg_read00a,
+			     snd_emu_proc_ptr_reg_write00);
+	snd_card_rw_proc_new(emu->card, "ptr_regs00b", emu,
+			     snd_emu_proc_ptr_reg_read00b,
+			     snd_emu_proc_ptr_reg_write00);
+	snd_card_rw_proc_new(emu->card, "ptr_regs20a", emu,
+			     snd_emu_proc_ptr_reg_read20a,
+			     snd_emu_proc_ptr_reg_write20);
+	snd_card_rw_proc_new(emu->card, "ptr_regs20b", emu,
+			     snd_emu_proc_ptr_reg_read20b,
+			     snd_emu_proc_ptr_reg_write20);
+	snd_card_rw_proc_new(emu->card, "ptr_regs20c", emu,
+			     snd_emu_proc_ptr_reg_read20c,
+			     snd_emu_proc_ptr_reg_write20);
 #endif
 	
-	if (! snd_card_proc_new(emu->card, "emu10k1", &entry))
-		snd_info_set_text_ops(entry, emu, snd_emu10k1_proc_read);
+	snd_card_ro_proc_new(emu->card, "emu10k1", emu, snd_emu10k1_proc_read);
 
-	if (emu->card_capabilities->emu10k2_chip) {
-		if (! snd_card_proc_new(emu->card, "spdif-in", &entry))
-			snd_info_set_text_ops(entry, emu, snd_emu10k1_proc_spdif_read);
-	}
-	if (emu->card_capabilities->ca0151_chip) {
-		if (! snd_card_proc_new(emu->card, "capture-rates", &entry))
-			snd_info_set_text_ops(entry, emu, snd_emu10k1_proc_rates_read);
-	}
+	if (emu->card_capabilities->emu10k2_chip)
+		snd_card_ro_proc_new(emu->card, "spdif-in", emu,
+				     snd_emu10k1_proc_spdif_read);
+	if (emu->card_capabilities->ca0151_chip)
+		snd_card_ro_proc_new(emu->card, "capture-rates", emu,
+				     snd_emu10k1_proc_rates_read);
 
-	if (! snd_card_proc_new(emu->card, "voices", &entry))
-		snd_info_set_text_ops(entry, emu, snd_emu10k1_proc_voices_read);
+	snd_card_ro_proc_new(emu->card, "voices", emu,
+			     snd_emu10k1_proc_voices_read);
 
 	if (! snd_card_proc_new(emu->card, "fx8010_gpr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
@@ -646,11 +631,7 @@ int snd_emu10k1_proc_init(struct snd_emu10k1 *emu)
 		entry->size = emu->audigy ? A_TOTAL_SIZE_CODE : TOTAL_SIZE_CODE;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
-	if (! snd_card_proc_new(emu->card, "fx8010_acode", &entry)) {
-		entry->content = SNDRV_INFO_CONTENT_TEXT;
-		entry->private_data = emu;
-		entry->mode = S_IFREG | 0444 /*| S_IWUSR*/;
-		entry->c.text.read = snd_emu10k1_proc_acode_read;
-	}
+	snd_card_ro_proc_new(emu->card, "fx8010_acode", emu,
+			     snd_emu10k1_proc_acode_read);
 	return 0;
 }
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 1f2960ecc57e..1cfff35e370e 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1902,10 +1902,8 @@ static void snd_ensoniq_proc_read(struct snd_info_entry *entry,
 
 static void snd_ensoniq_proc_init(struct ensoniq *ensoniq)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(ensoniq->card, "audiopci", &entry))
-		snd_info_set_text_ops(entry, ensoniq, snd_ensoniq_proc_read);
+	snd_card_ro_proc_new(ensoniq->card, "audiopci", ensoniq,
+			     snd_ensoniq_proc_read);
 }
 
 /*
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index a65740419650..853842987fa1 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -919,15 +919,8 @@ static void print_codec_info(struct snd_info_entry *entry,
 int snd_hda_codec_proc_new(struct hda_codec *codec)
 {
 	char name[32];
-	struct snd_info_entry *entry;
-	int err;
 
 	snprintf(name, sizeof(name), "codec#%d", codec->core.addr);
-	err = snd_card_proc_new(codec->card, name, &entry);
-	if (err < 0)
-		return err;
-
-	snd_info_set_text_ops(entry, codec, print_codec_info);
-	return 0;
+	return snd_card_ro_proc_new(codec->card, name, codec, print_codec_info);
 }
 
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index dda9b26192cb..fa7d90ee6e2d 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -1603,10 +1603,7 @@ static void snd_ice1712_proc_read(struct snd_info_entry *entry,
 
 static void snd_ice1712_proc_init(struct snd_ice1712 *ice)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(ice->card, "ice1712", &entry))
-		snd_info_set_text_ops(entry, ice, snd_ice1712_proc_read);
+	snd_card_ro_proc_new(ice->card, "ice1712", ice, snd_ice1712_proc_read);
 }
 
 /*
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 42994cf36156..a7d640ee4a17 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1571,10 +1571,7 @@ static void snd_vt1724_proc_read(struct snd_info_entry *entry,
 
 static void snd_vt1724_proc_init(struct snd_ice1712 *ice)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(ice->card, "ice1724", &entry))
-		snd_info_set_text_ops(entry, ice, snd_vt1724_proc_read);
+	snd_card_ro_proc_new(ice->card, "ice1724", ice, snd_vt1724_proc_read);
 }
 
 /*
diff --git a/sound/pci/ice1712/pontis.c b/sound/pci/ice1712/pontis.c
index 93b8cfc6636f..f499f1e8d0c9 100644
--- a/sound/pci/ice1712/pontis.c
+++ b/sound/pci/ice1712/pontis.c
@@ -659,12 +659,8 @@ static void wm_proc_regs_read(struct snd_info_entry *entry, struct snd_info_buff
 
 static void wm_proc_init(struct snd_ice1712 *ice)
 {
-	struct snd_info_entry *entry;
-	if (! snd_card_proc_new(ice->card, "wm_codec", &entry)) {
-		snd_info_set_text_ops(entry, ice, wm_proc_regs_read);
-		entry->mode |= 0200;
-		entry->c.text.write = wm_proc_regs_write;
-	}
+	snd_card_rw_proc_new(ice->card, "wm_codec", ice, wm_proc_regs_read,
+			     wm_proc_regs_write);
 }
 
 static void cs_proc_regs_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
@@ -684,9 +680,7 @@ static void cs_proc_regs_read(struct snd_info_entry *entry, struct snd_info_buff
 
 static void cs_proc_init(struct snd_ice1712 *ice)
 {
-	struct snd_info_entry *entry;
-	if (! snd_card_proc_new(ice->card, "cs_codec", &entry))
-		snd_info_set_text_ops(entry, ice, cs_proc_regs_read);
+	snd_card_ro_proc_new(ice->card, "cs_codec", ice, cs_proc_regs_read);
 }
 
 
diff --git a/sound/pci/ice1712/prodigy192.c b/sound/pci/ice1712/prodigy192.c
index 3919aed39ca0..d243309029d3 100644
--- a/sound/pci/ice1712/prodigy192.c
+++ b/sound/pci/ice1712/prodigy192.c
@@ -651,9 +651,8 @@ static void stac9460_proc_regs_read(struct snd_info_entry *entry,
 
 static void stac9460_proc_init(struct snd_ice1712 *ice)
 {
-	struct snd_info_entry *entry;
-	if (!snd_card_proc_new(ice->card, "stac9460_codec", &entry))
-		snd_info_set_text_ops(entry, ice, stac9460_proc_regs_read);
+	snd_card_ro_proc_new(ice->card, "stac9460_codec", ice,
+			     stac9460_proc_regs_read);
 }
 
 
diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index c97b5528e4b8..72f252c936e5 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -904,12 +904,8 @@ static void wm_proc_regs_read(struct snd_info_entry *entry,
 
 static void wm_proc_init(struct snd_ice1712 *ice)
 {
-	struct snd_info_entry *entry;
-	if (!snd_card_proc_new(ice->card, "wm_codec", &entry)) {
-		snd_info_set_text_ops(entry, ice, wm_proc_regs_read);
-		entry->mode |= 0200;
-		entry->c.text.write = wm_proc_regs_write;
-	}
+	snd_card_rw_proc_new(ice->card, "wm_codec", ice, wm_proc_regs_read,
+			     wm_proc_regs_write);
 }
 
 static int prodigy_hifi_add_controls(struct snd_ice1712 *ice)
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index 5bc836241c97..8ad964ee0b65 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -502,9 +502,7 @@ static void proc_regs_read(struct snd_info_entry *entry,
 
 static void proc_init(struct snd_ice1712 *ice)
 {
-	struct snd_info_entry *entry;
-	if (!snd_card_proc_new(ice->card, "quartet", &entry))
-		snd_info_set_text_ops(entry, ice, proc_regs_read);
+	snd_card_ro_proc_new(ice->card, "quartet", ice, proc_regs_read);
 }
 
 static int qtet_mute_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 885e1d488ed6..2784bf48cf5a 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2863,10 +2863,8 @@ static void snd_intel8x0_proc_read(struct snd_info_entry * entry,
 
 static void snd_intel8x0_proc_init(struct intel8x0 *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "intel8x0", &entry))
-		snd_info_set_text_ops(entry, chip, snd_intel8x0_proc_read);
+	snd_card_ro_proc_new(chip->card, "intel8x0", chip,
+			     snd_intel8x0_proc_read);
 }
 
 static int snd_intel8x0_dev_free(struct snd_device *device)
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 44eb9e28a1eb..43c654e15452 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1084,10 +1084,8 @@ static void snd_intel8x0m_proc_read(struct snd_info_entry * entry,
 
 static void snd_intel8x0m_proc_init(struct intel8x0m *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "intel8x0m", &entry))
-		snd_info_set_text_ops(entry, chip, snd_intel8x0m_proc_read);
+	snd_card_ro_proc_new(chip->card, "intel8x0m", chip,
+			     snd_intel8x0m_proc_read);
 }
 
 static int snd_intel8x0m_dev_free(struct snd_device *device)
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 4e189a93f475..fe4aba8a08ea 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2090,10 +2090,8 @@ static void snd_korg1212_proc_read(struct snd_info_entry *entry,
 
 static void snd_korg1212_proc_init(struct snd_korg1212 *korg1212)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(korg1212->card, "korg1212", &entry))
-		snd_info_set_text_ops(entry, korg1212, snd_korg1212_proc_read);
+	snd_card_ro_proc_new(korg1212->card, "korg1212", korg1212,
+			     snd_korg1212_proc_read);
 }
 
 static int
diff --git a/sound/pci/lola/lola_proc.c b/sound/pci/lola/lola_proc.c
index 904e3c4f4dfe..1603f9c81897 100644
--- a/sound/pci/lola/lola_proc.c
+++ b/sound/pci/lola/lola_proc.c
@@ -208,15 +208,9 @@ static void lola_proc_regs_read(struct snd_info_entry *entry,
 
 void lola_proc_debug_new(struct lola *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(chip->card, "codec", &entry))
-		snd_info_set_text_ops(entry, chip, lola_proc_codec_read);
-	if (!snd_card_proc_new(chip->card, "codec_rw", &entry)) {
-		snd_info_set_text_ops(entry, chip, lola_proc_codec_rw_read);
-		entry->mode |= 0200;
-		entry->c.text.write = lola_proc_codec_rw_write;
-	}
-	if (!snd_card_proc_new(chip->card, "regs", &entry))
-		snd_info_set_text_ops(entry, chip, lola_proc_regs_read);
+	snd_card_ro_proc_new(chip->card, "codec", chip, lola_proc_codec_read);
+	snd_card_rw_proc_new(chip->card, "codec_rw", chip,
+			     lola_proc_codec_rw_read,
+			     lola_proc_codec_rw_write);
+	snd_card_ro_proc_new(chip->card, "regs", chip, lola_proc_regs_read);
 }
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 54f6252faca6..198ccf9b5eb3 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -948,13 +948,7 @@ static void lx_proc_levels_read(struct snd_info_entry *entry,
 
 static int lx_proc_create(struct snd_card *card, struct lx6464es *chip)
 {
-	struct snd_info_entry *entry;
-	int err = snd_card_proc_new(card, "levels", &entry);
-	if (err < 0)
-		return err;
-
-	snd_info_set_text_ops(entry, chip, lx_proc_levels_read);
-	return 0;
+	return snd_card_ro_proc_new(card, "levels", chip, lx_proc_levels_read);
 }
 
 
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 9cd297a42f24..92f616df3863 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1220,10 +1220,8 @@ static void snd_mixart_proc_init(struct snd_mixart *chip)
 	struct snd_info_entry *entry;
 
 	/* text interface to read perf and temp meters */
-	if (! snd_card_proc_new(chip->card, "board_info", &entry)) {
-		entry->private_data = chip;
-		entry->c.text.read = snd_mixart_proc_read;
-	}
+	snd_card_ro_proc_new(chip->card, "board_info", chip,
+			     snd_mixart_proc_read);
 
 	if (! snd_card_proc_new(chip->card, "mixart_BA0", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
diff --git a/sound/pci/oxygen/oxygen_lib.c b/sound/pci/oxygen/oxygen_lib.c
index d4cfff7e49e1..3ae9dd4b39e8 100644
--- a/sound/pci/oxygen/oxygen_lib.c
+++ b/sound/pci/oxygen/oxygen_lib.c
@@ -244,10 +244,7 @@ static void oxygen_proc_read(struct snd_info_entry *entry,
 
 static void oxygen_proc_init(struct oxygen *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(chip->card, "oxygen", &entry))
-		snd_info_set_text_ops(entry, chip, oxygen_proc_read);
+	snd_card_ro_proc_new(chip->card, "oxygen", chip, oxygen_proc_read);
 }
 
 static const struct pci_device_id *
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index e57da4036231..4ab7efc6e9f7 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1454,21 +1454,14 @@ static void pcxhr_proc_ltc(struct snd_info_entry *entry,
 
 static void pcxhr_proc_init(struct snd_pcxhr *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "info", &entry))
-		snd_info_set_text_ops(entry, chip, pcxhr_proc_info);
-	if (! snd_card_proc_new(chip->card, "sync", &entry))
-		snd_info_set_text_ops(entry, chip, pcxhr_proc_sync);
+	snd_card_ro_proc_new(chip->card, "info", chip, pcxhr_proc_info);
+	snd_card_ro_proc_new(chip->card, "sync", chip, pcxhr_proc_sync);
 	/* gpio available on stereo sound cards only */
-	if (chip->mgr->is_hr_stereo &&
-	    !snd_card_proc_new(chip->card, "gpio", &entry)) {
-		snd_info_set_text_ops(entry, chip, pcxhr_proc_gpio_read);
-		entry->c.text.write = pcxhr_proc_gpo_write;
-		entry->mode |= 0200;
-	}
-	if (!snd_card_proc_new(chip->card, "ltc", &entry))
-		snd_info_set_text_ops(entry, chip, pcxhr_proc_ltc);
+	if (chip->mgr->is_hr_stereo)
+		snd_card_rw_proc_new(chip->card, "gpio", chip,
+				     pcxhr_proc_gpio_read,
+				     pcxhr_proc_gpo_write);
+	snd_card_ro_proc_new(chip->card, "ltc", chip, pcxhr_proc_ltc);
 }
 /* end of proc interface */
 
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 1d431c8052d6..8d1a56a9bcfd 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1973,10 +1973,8 @@ snd_riptide_proc_read(struct snd_info_entry *entry,
 
 static void snd_riptide_proc_init(struct snd_riptide *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(chip->card, "riptide", &entry))
-		snd_info_set_text_ops(entry, chip, snd_riptide_proc_read);
+	snd_card_ro_proc_new(chip->card, "riptide", chip,
+			     snd_riptide_proc_read);
 }
 
 static int snd_riptide_mixer(struct snd_riptide *chip)
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 3ac8c71d567c..c6bcc0715716 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1568,10 +1568,7 @@ snd_rme32_proc_read(struct snd_info_entry * entry, struct snd_info_buffer *buffe
 
 static void snd_rme32_proc_init(struct rme32 *rme32)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(rme32->card, "rme32", &entry))
-		snd_info_set_text_ops(entry, rme32, snd_rme32_proc_read);
+	snd_card_ro_proc_new(rme32->card, "rme32", rme32, snd_rme32_proc_read);
 }
 
 /*
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index c56702e6cb60..42c6b5e09072 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1868,10 +1868,7 @@ snd_rme96_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer
 
 static void snd_rme96_proc_init(struct rme96 *rme96)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(rme96->card, "rme96", &entry))
-		snd_info_set_text_ops(entry, rme96, snd_rme96_proc_read);
+	snd_card_ro_proc_new(rme96->card, "rme96", rme96, snd_rme96_proc_read);
 }
 
 /*
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index ba99ff0e93e0..29bef48a3af3 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3708,10 +3708,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 
 static void snd_hdsp_proc_init(struct hdsp *hdsp)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(hdsp->card, "hdsp", &entry))
-		snd_info_set_text_ops(entry, hdsp, snd_hdsp_proc_read);
+	snd_card_ro_proc_new(hdsp->card, "hdsp", hdsp, snd_hdsp_proc_read);
 }
 
 static void snd_hdsp_free_buffers(struct hdsp *hdsp)
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 679ad0415e3b..d485dd8a7b72 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -5287,44 +5287,35 @@ static void snd_hdspm_proc_ports_out(struct snd_info_entry *entry,
 
 static void snd_hdspm_proc_init(struct hdspm *hdspm)
 {
-	struct snd_info_entry *entry;
+	void (*read)(struct snd_info_entry *, struct snd_info_buffer *) = NULL;
 
-	if (!snd_card_proc_new(hdspm->card, "hdspm", &entry)) {
-		switch (hdspm->io_type) {
-		case AES32:
-			snd_info_set_text_ops(entry, hdspm,
-					snd_hdspm_proc_read_aes32);
-			break;
-		case MADI:
-			snd_info_set_text_ops(entry, hdspm,
-					snd_hdspm_proc_read_madi);
-			break;
-		case MADIface:
-			/* snd_info_set_text_ops(entry, hdspm,
-			 snd_hdspm_proc_read_madiface); */
-			break;
-		case RayDAT:
-			snd_info_set_text_ops(entry, hdspm,
-					snd_hdspm_proc_read_raydat);
-			break;
-		case AIO:
-			break;
-		}
-	}
-
-	if (!snd_card_proc_new(hdspm->card, "ports.in", &entry)) {
-		snd_info_set_text_ops(entry, hdspm, snd_hdspm_proc_ports_in);
+	switch (hdspm->io_type) {
+	case AES32:
+		read = snd_hdspm_proc_read_aes32;
+		break;
+	case MADI:
+		read = snd_hdspm_proc_read_madi;
+		break;
+	case MADIface:
+		/* read = snd_hdspm_proc_read_madiface; */
+		break;
+	case RayDAT:
+		read = snd_hdspm_proc_read_raydat;
+		break;
+	case AIO:
+		break;
 	}
 
-	if (!snd_card_proc_new(hdspm->card, "ports.out", &entry)) {
-		snd_info_set_text_ops(entry, hdspm, snd_hdspm_proc_ports_out);
-	}
+	snd_card_ro_proc_new(hdspm->card, "hdspm", hdspm, read);
+	snd_card_ro_proc_new(hdspm->card, "ports.in", hdspm,
+			     snd_hdspm_proc_ports_in);
+	snd_card_ro_proc_new(hdspm->card, "ports.out", hdspm,
+			     snd_hdspm_proc_ports_out);
 
 #ifdef CONFIG_SND_DEBUG
 	/* debug file to read all hdspm registers */
-	if (!snd_card_proc_new(hdspm->card, "debug", &entry))
-		snd_info_set_text_ops(entry, hdspm,
-				snd_hdspm_proc_read_debug);
+	snd_card_ro_proc_new(hdspm->card, "debug", hdspm,
+			     snd_hdspm_proc_read_debug);
 #endif
 }
 
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index edd765e22377..5228b982da5a 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -1737,10 +1737,8 @@ snd_rme9652_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buff
 
 static void snd_rme9652_proc_init(struct snd_rme9652 *rme9652)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(rme9652->card, "rme9652", &entry))
-		snd_info_set_text_ops(entry, rme9652, snd_rme9652_proc_read);
+	snd_card_ro_proc_new(rme9652->card, "rme9652", rme9652,
+			     snd_rme9652_proc_read);
 }
 
 static void snd_rme9652_free_buffers(struct snd_rme9652 *rme9652)
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 7218f38b59db..71d5ad3cffd6 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1171,10 +1171,8 @@ static void snd_sonicvibes_proc_read(struct snd_info_entry *entry,
 
 static void snd_sonicvibes_proc_init(struct sonicvibes *sonic)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(sonic->card, "sonicvibes", &entry))
-		snd_info_set_text_ops(entry, sonic, snd_sonicvibes_proc_read);
+	snd_card_ro_proc_new(sonic->card, "sonicvibes", sonic,
+			     snd_sonicvibes_proc_read);
 }
 
 /*
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index f271ea436cff..0ff32d3f5d3b 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3320,13 +3320,11 @@ static void snd_trident_proc_read(struct snd_info_entry *entry,
 
 static void snd_trident_proc_init(struct snd_trident *trident)
 {
-	struct snd_info_entry *entry;
 	const char *s = "trident";
 	
 	if (trident->device == TRIDENT_DEVICE_ID_SI7018)
 		s = "sis7018";
-	if (! snd_card_proc_new(trident->card, s, &entry))
-		snd_info_set_text_ops(entry, trident, snd_trident_proc_read);
+	snd_card_ro_proc_new(trident->card, s, trident, snd_trident_proc_read);
 }
 
 static int snd_trident_dev_free(struct snd_device *device)
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 736ac79901b3..dee1c487d6ba 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -2144,10 +2144,8 @@ static void snd_via82xx_proc_read(struct snd_info_entry *entry,
 
 static void snd_via82xx_proc_init(struct via82xx *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "via82xx", &entry))
-		snd_info_set_text_ops(entry, chip, snd_via82xx_proc_read);
+	snd_card_ro_proc_new(chip->card, "via82xx", chip,
+			     snd_via82xx_proc_read);
 }
 
 /*
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 3f59e0279058..848bf9dbf8cd 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -937,10 +937,8 @@ static void snd_via82xx_proc_read(struct snd_info_entry *entry, struct snd_info_
 
 static void snd_via82xx_proc_init(struct via82xx_modem *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "via82xx", &entry))
-		snd_info_set_text_ops(entry, chip, snd_via82xx_proc_read);
+	snd_card_ro_proc_new(chip->card, "via82xx", chip,
+			     snd_via82xx_proc_read);
 }
 
 /*
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index c688b7f481da..4d48877f211f 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1985,11 +1985,7 @@ static void snd_ymfpci_proc_read(struct snd_info_entry *entry,
 
 static int snd_ymfpci_proc_init(struct snd_card *card, struct snd_ymfpci *chip)
 {
-	struct snd_info_entry *entry;
-	
-	if (! snd_card_proc_new(card, "ymfpci", &entry))
-		snd_info_set_text_ops(entry, chip, snd_ymfpci_proc_read);
-	return 0;
+	return snd_card_ro_proc_new(card, "ymfpci", chip, snd_ymfpci_proc_read);
 }
 
 /*
-- 
2.16.4
