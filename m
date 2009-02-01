From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/2] [EXPERIMENTAL] Add support for the latest
 IndigoIOx and IndigoDJx cards
Date: Sun, 1 Feb 2009 23:03:20 +0100
Message-ID: <20090201230320.f665cc5e.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out25.alice.it (smtp-out25.alice.it [85.33.2.25])
	by alsa0.perex.cz (Postfix) with ESMTP id A7D371037EE
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 23:03:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: carmen <_@whats-your.name>
List-Id: alsa-devel@alsa-project.org


The following is a very beta patch and is not meant to be merged yet. It
has been compile-tested only because I haven't the those cards. Hopefully
I'll be able to test it myself soon.

As you can see, I reused the existing IndigoIO and IndigoDJ driver because
they are the same cards with a different interface. The firmware is
different, though. The driver registers the card as a plain -IO or -DJ
without the trailing "x" (I will fix it later if someone thinks it's
important).




diff -dup alsa-driver__orig/alsa-kernel/pci/echoaudio/echoaudio.h alsa-driver/alsa-kernel/pci/echoaudio/echoaudio.h
--- alsa-driver__orig/alsa-kernel/pci/echoaudio/echoaudio.h	2009-02-01 15:37:54.000000000 +0100
+++ alsa-driver/alsa-kernel/pci/echoaudio/echoaudio.h	2009-02-01 21:59:38.000000000 +0100
@@ -189,6 +189,9 @@
 #define INDIGO			0x0090
 #define INDIGO_IO		0x00a0
 #define INDIGO_DJ		0x00b0
+#define DC8			0x00c0
+#define INDIGO_IOX		0x00d0
+#define INDIGO_DJX		0x00e0
 #define ECHO3G			0x0100
 
 
diff -dup alsa-driver__orig/alsa-kernel/pci/echoaudio/indigodj.c alsa-driver/alsa-kernel/pci/echoaudio/indigodj.c
--- alsa-driver__orig/alsa-kernel/pci/echoaudio/indigodj.c	2009-02-01 15:37:54.000000000 +0100
+++ alsa-driver/alsa-kernel/pci/echoaudio/indigodj.c	2009-02-01 22:26:02.000000000 +0100
@@ -59,17 +59,21 @@
 
 MODULE_FIRMWARE("ea/loader_dsp.fw");
 MODULE_FIRMWARE("ea/indigo_dj_dsp.fw");
+MODULE_FIRMWARE("ea/indigo_djx_dsp.fw");
 
 #define FW_361_LOADER		0
 #define FW_INDIGO_DJ_DSP	1
+#define FW_INDIGO_DJX_DSP	2
 
 static const struct firmware card_fw[] = {
 	{0, "loader_dsp.fw"},
-	{0, "indigo_dj_dsp.fw"}
+	{0, "indigo_dj_dsp.fw"},
+	{0, "indigo_djx_dsp.fw"}
 };
 
 static struct pci_device_id snd_echo_ids[] = {
-	{0x1057, 0x3410, 0xECC0, 0x00B0, 0, 0, 0},	/* Indigo DJ*/
+	{0x1057, 0x3410, 0xECC0, 0x00B0, 0, 0, 0},	/* Indigo DJ */
+	{0x1057, 0x3410, 0xECC0, 0x00E0, 0, 0, 0},	/* Indigo DJx */
 	{0,}
 };
 
diff -dup alsa-driver__orig/alsa-kernel/pci/echoaudio/indigodj_dsp.c alsa-driver/alsa-kernel/pci/echoaudio/indigodj_dsp.c
--- alsa-driver__orig/alsa-kernel/pci/echoaudio/indigodj_dsp.c	2009-02-01 15:37:54.000000000 +0100
+++ alsa-driver/alsa-kernel/pci/echoaudio/indigodj_dsp.c	2009-02-01 21:53:55.000000000 +0100
@@ -37,9 +37,11 @@ static int update_vmixer_level(struct ec
 static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 {
 	int err;
+	u16 subdev;
 
 	DE_INIT(("init_hw() - Indigo DJ\n"));
-	if (snd_BUG_ON((subdevice_id & 0xfff0) != INDIGO_DJ))
+	subdev = subdevice_id & 0xfff0;
+	if (snd_BUG_ON(subdev != INDIGO_DJ && subdev != INDIGO_DJX))
 		return -ENODEV;
 
 	if ((err = init_dsp_comm_page(chip))) {
@@ -50,7 +52,10 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_INDIGO_DJ_DSP];
+	if (subdev == INDIGO_DJ)
+		chip->dsp_code_to_load = &card_fw[FW_INDIGO_DJ_DSP];
+	else
+		chip->dsp_code_to_load = &card_fw[FW_INDIGO_DJX_DSP];
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;
diff -dup alsa-driver__orig/alsa-kernel/pci/echoaudio/indigoio.c alsa-driver/alsa-kernel/pci/echoaudio/indigoio.c
--- alsa-driver__orig/alsa-kernel/pci/echoaudio/indigoio.c	2009-02-01 15:37:54.000000000 +0100
+++ alsa-driver/alsa-kernel/pci/echoaudio/indigoio.c	2009-02-01 22:26:11.000000000 +0100
@@ -60,17 +60,21 @@
 
 MODULE_FIRMWARE("ea/loader_dsp.fw");
 MODULE_FIRMWARE("ea/indigo_io_dsp.fw");
+MODULE_FIRMWARE("ea/indigo_iox_dsp.fw");
 
 #define FW_361_LOADER		0
 #define FW_INDIGO_IO_DSP	1
+#define FW_INDIGO_IOX_DSP	2
 
 static const struct firmware card_fw[] = {
 	{0, "loader_dsp.fw"},
-	{0, "indigo_io_dsp.fw"}
+	{0, "indigo_io_dsp.fw"},
+	{0, "indigo_iox_dsp.fw"}
 };
 
 static struct pci_device_id snd_echo_ids[] = {
-	{0x1057, 0x3410, 0xECC0, 0x00A0, 0, 0, 0},	/* Indigo IO*/
+	{0x1057, 0x3410, 0xECC0, 0x00A0, 0, 0, 0},	/* Indigo IO */
+	{0x1057, 0x3410, 0xECC0, 0x00D0, 0, 0, 0},	/* Indigo IOx */
 	{0,}
 };
 
diff -dup alsa-driver__orig/alsa-kernel/pci/echoaudio/indigoio_dsp.c alsa-driver/alsa-kernel/pci/echoaudio/indigoio_dsp.c
--- alsa-driver__orig/alsa-kernel/pci/echoaudio/indigoio_dsp.c	2009-02-01 15:37:54.000000000 +0100
+++ alsa-driver/alsa-kernel/pci/echoaudio/indigoio_dsp.c	2009-02-01 21:59:05.000000000 +0100
@@ -37,9 +37,11 @@ static int update_vmixer_level(struct ec
 static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 {
 	int err;
+	u16 subdev;
 
 	DE_INIT(("init_hw() - Indigo IO\n"));
-	if (snd_BUG_ON((subdevice_id & 0xfff0) != INDIGO_IO))
+	subdev = subdevice_id & 0xfff0;
+	if (snd_BUG_ON(subdev != INDIGO_IO && subdev != INDIGO_IOX))
 		return -ENODEV;
 
 	if ((err = init_dsp_comm_page(chip))) {
@@ -50,7 +52,10 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_INDIGO_IO_DSP];
+	if (subdev == INDIGO_IO)
+		chip->dsp_code_to_load = &card_fw[FW_INDIGO_IO_DSP];
+	else
+		chip->dsp_code_to_load = &card_fw[FW_INDIGO_IOX_DSP];
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;



--
Giuliano.
