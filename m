From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3 1/3] ALSA: mts64: whitespace fixes
Date: Thu,  4 Feb 2016 22:16:32 +0530
Message-ID: <1454604394-16055-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

To improve the readability and grep-ability of the code trailing
whitespace, multiple blank lines, space before start of a line and a
required space before opening brace have been removed. This patch takes
care of these issues related to whitespace changes and there was no
other change.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v3: changed commit message
v2: combined 3 patches of v1 series into this patch.

 sound/drivers/mts64.c | 112 ++++++++++++++++++++++++------------------=
--------
 1 file changed, 54 insertions(+), 58 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 2a008a9..f7d938d 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -1,14 +1,14 @@
-/*    =20
+/*
  *   ALSA Driver for Ego Systems Inc. (ESI) Miditerminal 4140
  *   Copyright (c) 2006 by Matthias K=C3=B6nig <mk@phasorlab.de>
  *
- *   This program is free software; you can redistribute it and/or mod=
ify=20
- *   it under the terms of the GNU General Public License as published=
 by=20
- *   the Free Software Foundation; either version 2 of the License, or=
=20
- *   (at your option) any later version.=20
+ *   This program is free software; you can redistribute it and/or mod=
ify
+ *   it under the terms of the GNU General Public License as published=
 by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,=20
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of=20
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *   GNU General Public License for more details.
  *
@@ -38,7 +38,7 @@ static int index[SNDRV_CARDS]  =3D SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS]   =3D SNDRV_DEFAULT_STR;
 static bool enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
=20
-static struct platform_device *platform_devices[SNDRV_CARDS];=20
+static struct platform_device *platform_devices[SNDRV_CARDS];
 static int device_count;
=20
 module_param_array(index, int, NULL, S_IRUGO);
@@ -92,7 +92,7 @@ static int snd_mts64_create(struct snd_card *card,
 	*rchip =3D NULL;
=20
 	mts =3D kzalloc(sizeof(struct mts64), GFP_KERNEL);
-	if (mts =3D=3D NULL)=20
+	if (mts =3D=3D NULL)
 		return -ENOMEM;
=20
 	/* Init chip specific data */
@@ -118,9 +118,9 @@ static int snd_mts64_create(struct snd_card *card,
=20
 /* Control Bits */
 #define MTS64_CTL_READOUT          0x08  /* enable readout */
-#define MTS64_CTL_WRITE_CMD        0x06 =20
-#define MTS64_CTL_WRITE_DATA       0x02 =20
-#define MTS64_CTL_STROBE           0x01 =20
+#define MTS64_CTL_WRITE_CMD        0x06
+#define MTS64_CTL_WRITE_DATA       0x02
+#define MTS64_CTL_STROBE           0x01
=20
 /* Command */
 #define MTS64_CMD_RESET            0xfe
@@ -130,7 +130,7 @@ static int snd_mts64_create(struct snd_card *card,
 #define MTS64_CMD_SMPTE_STOP       0xef
 #define MTS64_CMD_SMPTE_FPS_24     0xe3
 #define MTS64_CMD_SMPTE_FPS_25     0xe2
-#define MTS64_CMD_SMPTE_FPS_2997   0xe4=20
+#define MTS64_CMD_SMPTE_FPS_2997   0xe4
 #define MTS64_CMD_SMPTE_FPS_30D    0xe1
 #define MTS64_CMD_SMPTE_FPS_30     0xe0
 #define MTS64_CMD_COM_OPEN         0xf8  /* setting the communication =
mode */
@@ -159,7 +159,6 @@ static void mts64_write_command(struct parport *p, =
u8 c);
 static void mts64_write_data(struct parport *p, u8 c);
 static void mts64_write_midi(struct mts64 *mts, u8 c, int midiport);
=20
-
 /*  Enables the readout procedure
  *
  *  Before we can read a midi byte from the device, we have to set
@@ -171,10 +170,10 @@ static void mts64_enable_readout(struct parport *=
p)
=20
 	c =3D parport_read_control(p);
 	c |=3D MTS64_CTL_READOUT;
-	parport_write_control(p, c);=20
+	parport_write_control(p, c);
 }
=20
-/*  Disables readout=20
+/*  Disables readout
  *
  *  Readout is disabled by clearing bit 3 of control
  */
@@ -201,9 +200,9 @@ static int mts64_device_ready(struct parport *p)
 	for (i =3D 0; i < 0xffff; ++i) {
 		c =3D parport_read_status(p);
 		c &=3D MTS64_STAT_BSY;
-		if (c !=3D 0)=20
+		if (c !=3D 0)
 			return 1;
-	}=20
+	}
=20
 	return 0;
 }
@@ -234,7 +233,7 @@ static int mts64_device_init(struct parport *p)
 	return -EIO;
 }
=20
-/*=20
+/*
  *  Opens the device (set communication mode)
  */
 static int mts64_device_open(struct mts64 *mts)
@@ -248,7 +247,7 @@ static int mts64_device_open(struct mts64 *mts)
 	return 0;
 }
=20
-/* =20
+/*
  *  Close device (clear communication mode)
  */
 static int mts64_device_close(struct mts64 *mts)
@@ -265,14 +264,14 @@ static int mts64_device_close(struct mts64 *mts)
 }
=20
 /*  map hardware port to substream number
- *=20
+ *
  *  When reading a byte from the device, the device tells us
  *  on what port the byte is. This HW port has to be mapped to
  *  the midiport (substream number).
  *  substream 0-3 are Midiports 1-4
  *  substream 4 is SMPTE Timecode
  *  The mapping is done by the table:
- *  HW | 0 | 1 | 2 | 3 | 4=20
+ *  HW | 0 | 1 | 2 | 3 | 4
  *  SW | 0 | 1 | 4 | 2 | 3
  */
 static u8 mts64_map_midi_input(u8 c)
@@ -282,10 +281,9 @@ static u8 mts64_map_midi_input(u8 c)
 	return map[c];
 }
=20
-
 /*  Probe parport for device
  *
- *  Do we have a Miditerminal 4140 on parport?=20
+ *  Do we have a Miditerminal 4140 on parport?
  *  Returns:
  *  0       device found
  *  -ENODEV no device
@@ -298,13 +296,13 @@ static int mts64_probe(struct parport *p)
 	mts64_write_command(p, MTS64_CMD_PROBE);
=20
 	msleep(50);
-=09
+
 	c =3D mts64_read(p);
=20
 	c &=3D 0x00ff;
-	if (c !=3D MTS64_CMD_PROBE)=20
+	if (c !=3D MTS64_CMD_PROBE)
 		return -ENODEV;
-	else=20
+	else
 		return 0;
=20
 }
@@ -330,7 +328,7 @@ static u16 mts64_read(struct parport *p)
 /*  Read a byte from device
  *
  *  Note, that readout mode has to be enabled.
- *  readout procedure is as follows:=20
+ *  readout procedure is as follows:
  *  - Write number of the Bit to read to DATA
  *  - Read STATUS
  *  - Bit 5 of STATUS indicates if Bit is set
@@ -348,10 +346,10 @@ static u8 mts64_read_char(struct parport *p)
 		parport_write_data(p, i);
 		c >>=3D 1;
 		status =3D parport_read_status(p);
-		if (status & MTS64_STAT_BIT_SET)=20
+		if (status & MTS64_STAT_BIT_SET)
 			c |=3D 0x80;
 	}
-=09
+
 	return c;
 }
=20
@@ -369,9 +367,9 @@ static void mts64_smpte_start(struct parport *p,
 			      u8 seconds, u8 frames,
 			      u8 idx)
 {
-	static u8 fps[5] =3D { MTS64_CMD_SMPTE_FPS_24,=20
+	static u8 fps[5] =3D { MTS64_CMD_SMPTE_FPS_24,
 			     MTS64_CMD_SMPTE_FPS_25,
-			     MTS64_CMD_SMPTE_FPS_2997,=20
+			     MTS64_CMD_SMPTE_FPS_2997,
 			     MTS64_CMD_SMPTE_FPS_30D,
 			     MTS64_CMD_SMPTE_FPS_30    };
=20
@@ -405,7 +403,7 @@ static void mts64_write_command(struct parport *p, =
u8 c)
 	parport_write_control(p, MTS64_CTL_WRITE_CMD);
 }
=20
-/*  Write a data byte to device=20
+/*  Write a data byte to device
  */
 static void mts64_write_data(struct parport *p, u8 c)
 {
@@ -652,7 +650,6 @@ static struct snd_kcontrol_new mts64_ctl_smpte_fps =
=3D {
 	.put   =3D snd_mts64_ctl_smpte_fps_put
 };
=20
-
 static int snd_mts64_ctl_create(struct snd_card *card,
 				struct mts64 *mts)
 {
@@ -669,7 +666,7 @@ static int snd_mts64_ctl_create(struct snd_card *ca=
rd,
 	for (i =3D 0; control[i]; ++i) {
 		err =3D snd_ctl_add(card, snd_ctl_new1(control[i], mts));
 		if (err < 0) {
-			snd_printd("Cannot create control: %s\n",=20
+			snd_printd("Cannot create control: %s\n",
 				   control[i]->name);
 			return err;
 		}
@@ -688,8 +685,8 @@ static int snd_mts64_rawmidi_open(struct snd_rawmid=
i_substream *substream)
 	struct mts64 *mts =3D substream->rmidi->private_data;
=20
 	if (mts->open_count =3D=3D 0) {
-		/* We don't need a spinlock here, because this is just called=20
-		   if the device has not been opened before.=20
+		/* We don't need a spinlock here, because this is just called
+		   if the device has not been opened before.
 		   So there aren't any IRQs from the device */
 		mts64_device_open(mts);
=20
@@ -746,8 +743,8 @@ static void snd_mts64_rawmidi_input_trigger(struct =
snd_rawmidi_substream *substr
 	if (up)
 		mts->mode[substream->number] |=3D MTS64_MODE_INPUT_TRIGGERED;
 	else
- 		mts->mode[substream->number] &=3D ~MTS64_MODE_INPUT_TRIGGERED;
-=09
+		mts->mode[substream->number] &=3D ~MTS64_MODE_INPUT_TRIGGERED;
+
 	spin_unlock_irqrestore(&mts->lock, flags);
 }
=20
@@ -771,42 +768,42 @@ static int snd_mts64_rawmidi_create(struct snd_ca=
rd *card)
 	struct snd_rawmidi_substream *substream;
 	struct list_head *list;
 	int err;
-=09
-	err =3D snd_rawmidi_new(card, CARD_NAME, 0,=20
-			      MTS64_NUM_OUTPUT_PORTS,=20
-			      MTS64_NUM_INPUT_PORTS,=20
+
+	err =3D snd_rawmidi_new(card, CARD_NAME, 0,
+			      MTS64_NUM_OUTPUT_PORTS,
+			      MTS64_NUM_INPUT_PORTS,
 			      &rmidi);
-	if (err < 0)=20
+	if (err < 0)
 		return err;
=20
 	rmidi->private_data =3D mts;
 	strcpy(rmidi->name, CARD_NAME);
 	rmidi->info_flags =3D SNDRV_RAWMIDI_INFO_OUTPUT |
-		            SNDRV_RAWMIDI_INFO_INPUT |
-                            SNDRV_RAWMIDI_INFO_DUPLEX;
+			    SNDRV_RAWMIDI_INFO_INPUT |
+			    SNDRV_RAWMIDI_INFO_DUPLEX;
=20
 	mts->rmidi =3D rmidi;
=20
 	/* register rawmidi ops */
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,=20
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
 			    &snd_mts64_rawmidi_output_ops);
-	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,=20
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
 			    &snd_mts64_rawmidi_input_ops);
=20
 	/* name substreams */
 	/* output */
-	list_for_each(list,=20
+	list_for_each(list,
 		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substreams) {
 		substream =3D list_entry(list, struct snd_rawmidi_substream, list);
 		sprintf(substream->name,
 			"Miditerminal %d", substream->number+1);
 	}
 	/* input */
-	list_for_each(list,=20
+	list_for_each(list,
 		      &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams) {
 		substream =3D list_entry(list, struct snd_rawmidi_substream, list);
 		mts->midi_input_substream[substream->number] =3D substream;
-		switch(substream->number) {
+		switch (substream->number) {
 		case MTS64_SMPTE_SUBSTREAM:
 			strcpy(substream->name, "Miditerminal SMPTE");
 			break;
@@ -840,7 +837,7 @@ static void snd_mts64_interrupt(void *private)
 	if (status & MTS64_STAT_PORT) {
 		mts->current_midi_input_port =3D mts64_map_midi_input(data);
 	} else {
-		if (mts->current_midi_input_port =3D=3D -1)=20
+		if (mts->current_midi_input_port =3D=3D -1)
 			goto __out;
 		substream =3D mts->midi_input_substream[mts->current_midi_input_port=
];
 		if (mts->mode[substream->number] & MTS64_MODE_INPUT_TRIGGERED)
@@ -860,7 +857,7 @@ static int snd_mts64_probe_port(struct parport *p)
 					 0, NULL);
 	if (!pardev)
 		return -EIO;
-=09
+
 	if (parport_claim(pardev)) {
 		parport_unregister_device(pardev);
 		return -EIO;
@@ -944,7 +941,7 @@ static int snd_mts64_probe(struct platform_device *=
pdev)
=20
 	if (dev >=3D SNDRV_CARDS)
 		return -ENODEV;
-	if (!enable[dev])=20
+	if (!enable[dev])
 		return -ENOENT;
 	if ((err =3D snd_mts64_probe_port(p)) < 0)
 		return err;
@@ -957,7 +954,7 @@ static int snd_mts64_probe(struct platform_device *=
pdev)
 	}
 	strcpy(card->driver, DRIVER_NAME);
 	strcpy(card->shortname, "ESI " CARD_NAME);
-	sprintf(card->longname,  "%s at 0x%lx, irq %i",=20
+	sprintf(card->longname,  "%s at 0x%lx, irq %i",
 		card->shortname, p->base, p->irq);
=20
 	pardev =3D parport_register_device(p,                   /* port */
@@ -980,7 +977,7 @@ static int snd_mts64_probe(struct platform_device *=
pdev)
 	}
 	card->private_data =3D mts;
 	card->private_free =3D snd_mts64_card_private_free;
-=09
+
 	if ((err =3D snd_mts64_rawmidi_create(card)) < 0) {
 		snd_printd("Creating Rawmidi component failed\n");
 		goto __err;
@@ -1024,7 +1021,6 @@ static int snd_mts64_remove(struct platform_devic=
e *pdev)
 	return 0;
 }
=20
-
 static struct platform_driver snd_mts64_driver =3D {
 	.probe  =3D snd_mts64_probe,
 	.remove =3D snd_mts64_remove,
@@ -1045,7 +1041,7 @@ static void snd_mts64_unregister_all(void)
 			platform_device_unregister(platform_devices[i]);
 			platform_devices[i] =3D NULL;
 		}
-	}	=09
+	}
 	platform_driver_unregister(&snd_mts64_driver);
 	parport_unregister_driver(&mts64_parport_driver);
 }
--=20
1.9.1
