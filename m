From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] YMF754 direct recording
Date: Fri, 17 Oct 2003 09:25:12 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310170922230.4146-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This patch adds a control to enable S/PDIF direct recording (without
resampling) on the YMF754.


Index: alsa-kernel/pci/ymfpci/ymfpci_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci_main.c,v
retrieving revision 1.43
diff -u -r1.43 ymfpci_main.c
--- alsa-kernel/pci/ymfpci/ymfpci_main.c	14 Oct 2003 13:59:21 -0000	1.43
+++ alsa-kernel/pci/ymfpci/ymfpci_main.c	17 Oct 2003 06:49:00 -0000
@@ -1136,7 +1136,7 @@

 	if (rpcm)
 		*rpcm = NULL;
-	if ((err = snd_pcm_new(chip->card, "YMFPCI - AC'97", device, 0, 1, &pcm)) < 0)
+	if ((err = snd_pcm_new(chip->card, "YMFPCI - PCM2", device, 0, 1, &pcm)) < 0)
 		return err;
 	pcm->private_data = chip;
 	pcm->private_free = snd_ymfpci_pcm2_free;
@@ -1145,7 +1145,8 @@

 	/* global setup */
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "YMFPCI - AC'97");
+	sprintf(pcm->name, "YMFPCI - %s",
+		chip->device_id == PCI_DEVICE_ID_YAMAHA_754 ? "Direct Recording" : "AC'97");
 	chip->pcm2 = pcm;

 	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
@@ -1369,6 +1370,61 @@
 	.put =		snd_ymfpci_spdif_stream_put
 };

+static int snd_ymfpci_drec_source_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *info)
+{
+	static char *texts[3] = {"AC'97", "IEC958", "ZV Port"};
+
+	info->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	info->count = 1;
+	info->value.enumerated.items = 3;
+	if (info->value.enumerated.item > 2)
+		info->value.enumerated.item = 2;
+	strcpy(info->value.enumerated.name, texts[info->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_ymfpci_drec_source_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *value)
+{
+	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	u16 reg;
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	reg = snd_ymfpci_readw(chip, YDSXGR_GLOBALCTRL);
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	if (!(reg & 0x100))
+		value->value.enumerated.item[0] = 0;
+	else
+		value->value.enumerated.item[0] = 1 + ((reg & 0x200) != 0);
+	return 0;
+}
+
+static int snd_ymfpci_drec_source_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *value)
+{
+	ymfpci_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	u16 reg, old_reg;
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	old_reg = snd_ymfpci_readw(chip, YDSXGR_GLOBALCTRL);
+	if (value->value.enumerated.item[0] == 0)
+		reg = old_reg & ~0x100;
+	else
+		reg = (old_reg & ~0x300) | 0x100 | ((value->value.enumerated.item[0] == 2) << 9);
+	snd_ymfpci_writew(chip, YDSXGR_GLOBALCTRL, reg);
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	return reg != old_reg;
+}
+
+static snd_kcontrol_new_t snd_ymfpci_drec_source __devinitdata = {
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Direct Recording Source",
+	.info =		snd_ymfpci_drec_source_info,
+	.get =		snd_ymfpci_drec_source_get,
+	.put =		snd_ymfpci_drec_source_put
+};
+
 /*
  *  Mixer controls
  */
@@ -1690,6 +1746,11 @@
 		return err;
 	kctl->id.device = chip->pcm_spdif->device;
 	chip->spdif_pcm_ctl = kctl;
+
+	/* direct recording source */
+	if (chip->device_id == PCI_DEVICE_ID_YAMAHA_754 &&
+	    (err = snd_ctl_add(chip->card, kctl = snd_ctl_new1(&snd_ymfpci_drec_source, chip))) < 0)
+		return err;

 	/*
 	 * shared rear/line-in




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
