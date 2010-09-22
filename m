From: Vince Weaver <vweaver1@eecs.utk.edu>
Subject: MacBookPro 5,3 line-in support
Date: Wed, 22 Sep 2010 17:31:37 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1009221726230.18012@cl320.eecs.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aspirin.dii.utk.edu (aspirin.dii.utk.edu [160.36.0.81])
	by alsa0.perex.cz (Postfix) with ESMTP id E7402244C5
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 23:31:42 +0200 (CEST)
Received: from cl320.eecs.utk.edu (cl320.eecs.utk.edu [160.36.58.11])
	by aspirin.dii.utk.edu (8.13.6/8.13.4) with ESMTP id o8MLVbKH010089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2010 17:31:37 -0400
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

Hello

I've found the following patch is necessary to enable line-in on 
my MacBookPro 5,3 machine.  With the patch applied I've successfully 
recorded audio from the line-in jack.  This is based on the existing
5,5 support.

Below is the patch, plus the codec#0 file.

Vince
vweaver1@eecs.utk.edu

Signed-off-by: Vince Weaver <vweaver1@eecs.utk.edu>
diff -ur alsa-driver/alsa-kernel/pci/hda/patch_cirrus.c alsa-driver-vmw/alsa-kernel/pci/hda/patch_cirrus.c
--- alsa-driver/alsa-kernel/pci/hda/patch_cirrus.c	2010-09-17 08:50:05.000000000 -0400
+++ alsa-driver-vmw/alsa-kernel/pci/hda/patch_cirrus.c	2010-09-22 17:23:35.496024032 -0400
@@ -65,6 +65,7 @@
 
 /* available models */
 enum {
+	CS420X_MBP53,
 	CS420X_MBP55,
 	CS420X_IMAC27,
 	CS420X_AUTO,
@@ -839,8 +840,9 @@
 				    AC_VERB_SET_PIN_WIDGET_CONTROL,
 				    hp_present ? 0 : PIN_OUT);
 	}
-	if (spec->board_config == CS420X_MBP55 ||
-	    spec->board_config == CS420X_IMAC27) {
+	if (spec->board_config == CS420X_MBP53 ||
+	   spec->board_config == CS420X_MBP55 ||
+	   spec->board_config == CS420X_IMAC27) {
 		unsigned int gpio = hp_present ? 0x02 : 0x08;
 		snd_hda_codec_write(codec, 0x01, 0,
 				    AC_VERB_SET_GPIO_DATA, gpio);
@@ -1128,6 +1130,7 @@
 }
 
 static const char *cs420x_models[CS420X_MODELS] = {
+	[CS420X_MBP53] = "mbp53",
 	[CS420X_MBP55] = "mbp55",
 	[CS420X_IMAC27] = "imac27",
 	[CS420X_AUTO] = "auto",
@@ -1135,6 +1138,7 @@
 
 
 static struct snd_pci_quirk cs420x_cfg_tbl[] = {
+	SND_PCI_QUIRK(0x10de, 0x0ac0, "MacBookPro 5,3", CS420X_MBP53),
 	SND_PCI_QUIRK(0x10de, 0xcb79, "MacBookPro 5,5", CS420X_MBP55),
 	SND_PCI_QUIRK(0x8086, 0x7270, "IMac 27 Inch", CS420X_IMAC27),
 	{} /* terminator */
@@ -1145,6 +1149,20 @@
 	u32 val;
 };
 
+static struct cs_pincfg mbp53_pincfgs[] = {
+	{ 0x09, 0x012b4050 },
+	{ 0x0a, 0x90100141 },
+	{ 0x0b, 0x90100140 },
+	{ 0x0c, 0x018b3020 },
+	{ 0x0d, 0x90a00110 },
+	{ 0x0e, 0x400000f0 },
+	{ 0x0f, 0x01cbe030 },
+	{ 0x10, 0x014be060 },
+	{ 0x12, 0x400000f0 },
+	{ 0x15, 0x400000f0 },
+	{} /* terminator */
+};
+
 static struct cs_pincfg mbp55_pincfgs[] = {
 	{ 0x09, 0x012b4030 },
 	{ 0x0a, 0x90100121 },
@@ -1174,6 +1192,7 @@
 };
 
 static struct cs_pincfg *cs_pincfgs[CS420X_MODELS] = {
+	[CS420X_MBP53] = mbp53_pincfgs,
 	[CS420X_MBP55] = mbp55_pincfgs,
 	[CS420X_IMAC27] = imac27_pincfgs,
 };
@@ -1206,6 +1225,7 @@
 
 	switch (spec->board_config) {
 	case CS420X_IMAC27:
+	case CS420X_MBP53:
 	case CS420X_MBP55:
 		/* GPIO1 = headphones */
 		/* GPIO3 = speakers */




Codec: Cirrus Logic CS4206
Address: 0
Function Id: 0x1
Vendor Id: 0x10134206
Subsystem Id: 0x106b4b00
Revision Id: 0x100301
No Modem Function Group found
Default PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=4, o=0, i=0, unsolicited=0, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
Node 0x02 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x3c 0x3c]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x3c 0x3c]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x04 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x3c 0x3c]
  Converter: stream=0, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x05 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0xb3 0xb3] [0xb3 0xb3]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0c* 0x12
Node 0x06 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0x15 0x15] [0x15 0x15]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0d* 0x0e
Node 0x07 [Audio Input] wcaps 0x180791: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital: Preemphasis Copyright
  Digital category: 0x0
  PCM:
    rates [0x570]: 32000 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 1
     0x0f
Node 0x08 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x09 [Pin Complex] wcaps 0x410581: Stereo
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x012b4030: [Jack] HP Out at Ext Rear
    Conn = Comb, Color = Green
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x02
Node 0x0a [Pin Complex] wcaps 0x410581: Stereo
  Pincap 0x00000054: OUT Detect Balanced
  Pin Default 0x90100121: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x03
Node 0x0b [Pin Complex] wcaps 0x410101: Stereo
  Pincap 0x00000050: OUT Balanced
  Pin Default 0x90100120: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Delay: 1 samples
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0d [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001764: IN Detect Balanced
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x90a00110: [Fixed] Mic at Int N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0e [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x0f [Pin Complex] wcaps 0x410681: Stereo Digital
  Pincap 0x00000024: IN Detect
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x10 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014be040: [Jack] SPDIF Out at Ext Rear
    Conn = Comb, Color = White
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x08
Node 0x11 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=22
Node 0x12 [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x13 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x14 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x15 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x14
