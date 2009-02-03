From: =?ISO-8859-1?Q?Jean-Pierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Tue, 03 Feb 2009 14:49:39 +0100
Message-ID: <49884B73.7050906@wanadoo.fr>
References: <4983FE7A.1040201@wanadoo.fr> <49840333.2080303@wanadoo.fr>
	<200902021620.52104.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060105050901090604070609"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2a.orange.fr (smtp2a.orange.fr [80.12.242.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E7C310382A
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 14:49:43 +0100 (CET)
In-Reply-To: <200902021620.52104.herton@mandriva.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, tim.barnette@gmail.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060105050901090604070609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Herton,

Thank you for trying to sort his out,

Herton Ronaldo Krzesinski wrote:
> Em S=E1bado 31 Janeiro 2009, =E0s 05:52:19, Jean-Pierre Andr=E9 escreve=
u:
>  =20
>> Hi,
>>
>>    =20
>>> Hi all, I have an HP DV4 1155-SE, I've been unable to get sound worki=
ng
>>> through the speakers, although it does work through the headhpones. I=
 ran
>>> alsa-.upgrade which downloaded compiled, and installed 1.0.19 - still=
 no
>>> luck.
>>>  =20
>>>      =20
>> I have the same IDT codec 92HD71B7X on another
>> HP DV4 model, and I have tracked the problem to be
>> the kernel configuring IRQ 22 through the APIC, but
>> interrupts triggerring IRQ 20 (on kernel 2.6.27 and
>> alsa 1.0.19). It would be interesting if you could
>> confirm this by analyzing /proc/interrupts.
>>
>> The workarounds I know of are :
>> - adding irqpoll to the boot options,
>> - or adding noapic to the boot options,
>> - using mplayer to play music.
>>
>> There are with option "snd-hda-intel model=3Dhp-m4"
>> (this option is for HP DV5/DV7, but HP DV4
>> is probably different)
>>
>> I have not enough knowledge to tell where the problem
>> lies : kernel, apic, alsa.
>>    =20
>
> It looks like some of these HP laptops have some sort of IRQ issue inde=
ed, to=20
> me it was reported that enabling pci MSI (both system wide and with=20
> enable_msi=3D1 given to snd-hda-intel) cured issues in some cases, alon=
g with=20
> some changes to sigmatel codec handling code in snd-hda-intel
>
> I have a ticked opened where people started to complain about sound iss=
ues=20
> with hda-intel+sigmatel codec starting with alsa 1.0.18rc3 (sorry, it's=
 a=20
> great mess, type of the ticket everyone says sound doesn't work and rep=
ort in,=20
> but where I tried to filter some things out):=20
> https://qa.mandriva.com/show_bug.cgi?id=3D44855
> Also some reports are hard to understand sometimes.
> With alsa 1.0.18 final in 2.6.27 (or 2.6.28) many issues related on the=
 ticket=20
> were fixed, but issues with HP laptops remained.
>
> I don't have any of affected HP laptops for test, but based on sigmatel=
=20
> datasheets, reports of users and pin cfgs used in .ini files of sigmate=
l=20
> windows drivers I made some changes to sigmatel code, plus added patch =
to set=20
> enable_msi. The only issue I have with the changes, and that's why I di=
dn't=20
> submit yet, is that I should have split them, don't know if everything =
is=20
> really required, and ask here to clarify some things below; also the ch=
anges=20
> are outdated compared to current sound git tree.
>  =20

Thank you for your suggested patches. I had some difficulties in
applying them as your reference version is not from the lasted build.
(for instance from alsa-driver-1.0.19.0.g5aa59.6.gb162b.tar.bz2)
Actually, to get patch_sigmatel to compile, I had to reintegrate
old deprecated code. Attached are the patches I really applied.

And the result is worse than before : no sound at all, using option
"model hp-m4-2", as I see in the patch that this was designed for
my sound device (subsystem id 0x30f7). I am also using option
enable_msi=3D1.

And still no IRQ 22 seen, IRQ 20 instead, could be another problem,
but what can I do to clarify this ?

With the original code, this is what I get in the syslog,

Feb  3 12:27:18 pavilion2 kernel: HDA Intel 0000:00:1b.0: power state=20
changed by ACPI to D0
Feb  3 12:27:18 pavilion2 kernel: HDA Intel 0000:00:1b.0: PCI INT B ->=20
GSI 22 (level, low) -> IRQ 22
Feb  3 12:27:19 pavilion2 kernel: ALSA=20
/var/tmp/bach-build/BUILD/alsa-driver-1.0.19/pci/hda/hda_intel.c:634:=20
hda_intel: azx_get_response timeout, switching to polling mode: last=20
cmd=3D0x000f0000
Feb  3 12:27:19 pavilion2 kernel: input: HDA Digital PCBeep as=20
/devices/pci0000:00/0000:00:1b.0/input/input38
Feb  3 12:27:19 pavilion2 kernel: input: HDA Intel at 0xdf300000 irq 22=20
Line In at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/input/input3=
9
Feb  3 12:27:19 pavilion2 kernel: input: HDA Intel at 0xdf300000 irq 22=20
Mic at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/input/input40
Feb  3 12:27:19 pavilion2 kernel: input: HDA Intel at 0xdf300000 irq 22=20
HP Out at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/input/input4=
1

With the patched one, the last line does not appear, this should
lead to the point where the patch has broken something :

Feb  3 11:23:47 pavilion2 kernel: HDA Intel 0000:00:1b.0: power state=20
changed by ACPI to D0
Feb  3 11:23:47 pavilion2 kernel: HDA Intel 0000:00:1b.0: PCI INT B ->=20
GSI 22 (level, low) -> IRQ 22
Feb  3 11:23:48 pavilion2 kernel: ALSA=20
/home/linux/rpmbuild/BUILD/alsa-driver-1.0.19/pci/hda/hda_intel.c:634:=20
hda_intel: azx_get_response timeout, switching to polling mode: last=20
cmd=3D0x000f0000
Feb  3 11:23:48 pavilion2 kernel: input: HDA Digital PCBeep as=20
/devices/pci0000:00/0000:00:1b.0/input/input19
Feb  3 11:23:48 pavilion2 kernel: input: HDA Intel at 0xdf300000 irq 22=20
Mic at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/input/input20
Feb  3 11:23:48 pavilion2 kernel: input: HDA Intel at 0xdf300000 irq 22=20
HP Out at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/input/input2=
1

I am open to any further test which you might suggest

Regards

Jean-Pierre


--------------060105050901090604070609
Content-Type: text/plain;
 name="herton-sigmatel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="herton-sigmatel.patch"

--- alsa-driver-1.0.19/alsa-kernel/pci/hda/patch_sigmatel.c.old	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/alsa-kernel/pci/hda/patch_sigmatel.c	2009-02-03 12:37:12.000000000 +0100
@@ -85,12 +85,26 @@
 };
 
 enum {
+	STAC_92HD71B5_REF,
+	STAC_92HD71B5_MODELS
+};
+
+enum {
+	STAC_92HD75B_5PORT_REF,
+	STAC_HP_M4,
+	STAC_92HD75B_5PORT_MODELS
+};
+
+enum {
 	STAC_92HD71BXX_REF,
 	STAC_DELL_M4_1,
 	STAC_DELL_M4_2,
 	STAC_DELL_M4_3,
-	STAC_HP_M4,
-	STAC_HP_DV5,
+	STAC_HP_M4_1,
+	STAC_HP_M4_2,
+	STAC_HP_M4_3,
+	STAC_HP_M4_4,
+	STAC_HP_M4_5,
 	STAC_92HD71BXX_MODELS
 };
 
@@ -224,6 +238,7 @@
 	hda_nid_t *pin_nids;
 	unsigned int num_pins;
 	unsigned int *pin_configs;
+	unsigned int *bios_pin_configs;
 
 	/* codec specific stuff */
 	struct hda_verb *init;
@@ -341,10 +356,6 @@
 	0xc,
 };
 
-static hda_nid_t stac92hd71bxx_pwr_nids[3] = {
-	0x0a, 0x0d, 0x0f
-};
-
 static hda_nid_t stac92hd71bxx_adc_nids[2] = {
 	0x12, 0x13,
 };
@@ -353,6 +364,10 @@
 	0x1a, 0x1b
 };
 
+static hda_nid_t stac92hd71bxx_dac_nids[2] = {
+	0x10, /*0x11, */
+};
+
 static hda_nid_t stac92hd71bxx_dmux_nids[2] = {
 	0x1c, 0x1d,
 };
@@ -361,6 +376,11 @@
 	0x24, 0x25,
 };
 
+#define STAC92HD75B_5PORT_NUM_DMICS 1
+static hda_nid_t stac92hd75b_5port_dmic_nids[STAC92HD75B_5PORT_NUM_DMICS + 1] = {
+	0x18, 0
+};
+
 #define STAC92HD71BXX_NUM_DMICS	2
 static hda_nid_t stac92hd71bxx_dmic_nids[STAC92HD71BXX_NUM_DMICS + 1] = {
 	0x18, 0x19, 0
@@ -476,10 +496,22 @@
 	0x0f, 0x10, 0x11, 0x12, 0x13,
 	0x1d, 0x1e, 0x1f, 0x20
 };
-static hda_nid_t stac92hd71bxx_pin_nids[11] = {
+
+static hda_nid_t stac92hd71b5_pin_nids[11] = {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x14,
+	0x18, 0x19, 0x1e, 0x1f, 0x20,
+	0x27
+};
+
+static hda_nid_t stac92hd75b_5port_pin_nids[10] = {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+	0x14, 0x18, 0x1e, 0x1f, 0x20
+};
+
+static hda_nid_t stac92hd71bxx_pin_nids[13] = {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x14, 0x18, 0x19, 0x1e,
-	0x1f,
+	0x1f, 0x20, 0x27
 };
 
 static hda_nid_t stac927x_pin_nids[14] = {
@@ -857,10 +889,17 @@
 static struct hda_verb stac92hd71bxx_core_init[] = {
 	/* set master volume and direct control */
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
-	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
+  	/* connect headphone jack to dac1 */
+  	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
+ 	/* connect port D/mono out to dac0 */
+ 	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 	{ 0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 	/* make sure dmuxes are initially connected to analog muxes */
+ 	{ 0x1c, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 	{ 0x1d, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 	/* unmute right and left channels for nodes 0x0a, 0xd */
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{}
 };
 
@@ -876,6 +915,14 @@
 
 	/* set master volume and direct control */
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+  	/* connect headphone jack to dac1 */
+  	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
+ 	/* connect port D/mono out to dac0 */
+ 	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 	{ 0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+ 	/* unmute and max step for dac0/dac1 inputs in mixer */
+ 	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0x701f},
+ 	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0x711f},
 	/* unmute right and left channels for nodes 0x0a, 0xd */
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
@@ -1098,7 +1145,6 @@
 
 static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	STAC_INPUT_SOURCE(2),
-	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A0, 2),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -1127,7 +1173,6 @@
 
 static struct snd_kcontrol_new stac92hd71bxx_mixer[] = {
 	STAC_INPUT_SOURCE(2),
-	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A0, 2),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -1751,28 +1796,107 @@
 	{} /* terminator */
 };
 
-static unsigned int ref92hd71bxx_pin_configs[11] = {
+static unsigned int ref92hd71b5_pin_configs[] = {
+	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
+	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x01452050,
+	0x98560060, 0x40f000f0, 0x40f000f0,
+};
+
+static unsigned int *stac92hd71b5_brd_tbl[STAC_92HD71B5_MODELS] = {
+	[STAC_92HD71B5_REF] = ref92hd71b5_pin_configs,
+};
+
+static const char *stac92hd71b5_models[STAC_92HD71B5_MODELS] = {
+	[STAC_92HD71B5_REF] = "ref",
+};
+
+static struct snd_pci_quirk stac92hd71b5_cfg_tbl[] = {
+	{} /* terminator */
+};
+
+static unsigned int ref92hd75b_5port_pin_configs[] = {
+	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
+	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x01452050,
+	0x98560060, 0x40f000f0,
+};
+
+static unsigned int *stac92hd75b_5port_brd_tbl[STAC_92HD75B_5PORT_MODELS] = {
+	[STAC_92HD75B_5PORT_REF]	= ref92hd75b_5port_pin_configs,
+	[STAC_HP_M4]			= NULL,
+};
+
+static const char *stac92hd75b_5port_models[STAC_92HD75B_5PORT_MODELS] = {
+	[STAC_92HD75B_5PORT_REF] = "ref",
+	[STAC_HP_M4]		 = "hp-m4",
+};
+
+static struct snd_pci_quirk stac92hd75b_5port_cfg_tbl[] = {
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x361a,
+				"unknown HP", STAC_HP_M4),
+	{} /* terminator */
+};
+
+static unsigned int ref92hd71bxx_pin_configs[13] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
 	0x0181302e, 0x01014010, 0x01019020, 0x90a000f0,
-	0x90a000f0, 0x01452050, 0x01452050,
+	0x90a000f0, 0x01452050, 0x01452050, 0x00000000,
+	0x00000000,
 };
 
-static unsigned int dell_m4_1_pin_configs[11] = {
+static unsigned int dell_m4_1_pin_configs[13] = {
 	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x90a000f0,
-	0x40f000f0, 0x4f0000f0, 0x4f0000f0,
+	0x40f000f0, 0x4f0000f0, 0x4f0000f0, 0x00000000,
+	0x00000000,
 };
 
-static unsigned int dell_m4_2_pin_configs[11] = {
+static unsigned int dell_m4_2_pin_configs[13] = {
 	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
-	0x40f000f0, 0x044413b0, 0x044413b0,
+	0x40f000f0, 0x044413b0, 0x044413b0, 0x00000000,
+	0x00000000,
 };
 
-static unsigned int dell_m4_3_pin_configs[11] = {
+static unsigned int dell_m4_3_pin_configs[13] = {
 	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
 	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x90a000f0,
-	0x40f000f0, 0x044413b0, 0x044413b0,
+	0x40f000f0, 0x044413b0, 0x044413b0, 0x00000000,
+	0x00000000,
+};
+
+static unsigned int hp_m4_1_pin_configs[13] = {
+	0x0221201f, 0x02a12050, 0x40f000f0, 0x90170010,
+	0x40f000f1, 0x0221201f, 0x40f000f2, 0x90a60040,
+	0x50f000f3, 0x28466060, 0x50f000f4, 0x00000000,
+	0x90300041,
+};
+
+static unsigned int hp_m4_2_pin_configs[13] = {
+	0x0221201f, 0x02a1205e, 0x40f000f1, 0x90170010,
+	0x4080005f, 0x40f000f5, 0x40f000f2, 0x90a60070,
+	0x50f000f3, 0x50f000f4, 0x50f000f5, 0x28466060,
+	0x9030005a,
+};
+
+static unsigned int hp_m4_3_pin_configs[13] = {
+	0x0221201f, 0x02a1205e, 0x40f000f1, 0x90170010,
+	0x4080005f, 0x40f000f5, 0x40f000f2, 0x90a60070,
+	0x50f000f3, 0x28466060, 0x50f000f4, 0x40f000f0,
+	0x9030005a,
+};
+
+static unsigned int hp_m4_4_pin_configs[13] = {
+	0x0221201f, 0x02a12050, 0x90a70040, 0x90170010,
+	0x40f000f1, 0x40f000f5, 0x40f000f2, 0x50f000f6,
+	0x50f000f3, 0x50f000f7, 0x50f000f4, 0x28466060,
+	0x9030005a,
+};
+
+static unsigned int hp_m4_5_pin_configs[13] = {
+	0x0221201f, 0x02a1205e, 0x90a70070, 0x90170010,
+	0x4080005f, 0x40f000f5, 0x40f000f2, 0x50f000f1,
+	0x50f000f3, 0x50f000f6, 0x50f000f4, 0x28466060,
+	0x9030005a,
 };
 
 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
@@ -1780,8 +1904,11 @@
 	[STAC_DELL_M4_1]	= dell_m4_1_pin_configs,
 	[STAC_DELL_M4_2]	= dell_m4_2_pin_configs,
 	[STAC_DELL_M4_3]	= dell_m4_3_pin_configs,
-	[STAC_HP_M4]		= NULL,
-	[STAC_HP_DV5]		= NULL,
+	[STAC_HP_M4_1]		= hp_m4_1_pin_configs,
+	[STAC_HP_M4_2]		= hp_m4_2_pin_configs,
+	[STAC_HP_M4_3]		= hp_m4_3_pin_configs,
+	[STAC_HP_M4_4]		= hp_m4_4_pin_configs,
+	[STAC_HP_M4_5]		= hp_m4_5_pin_configs,
 };
 
 static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
@@ -1789,24 +1916,59 @@
 	[STAC_DELL_M4_1] = "dell-m4-1",
 	[STAC_DELL_M4_2] = "dell-m4-2",
 	[STAC_DELL_M4_3] = "dell-m4-3",
-	[STAC_HP_M4] = "hp-m4",
-	[STAC_HP_DV5] = "hp-dv5",
+	[STAC_HP_M4_1] = "hp-m4-1",
+	[STAC_HP_M4_2] = "hp-m4-2",
+	[STAC_HP_M4_3] = "hp-m4-3",
+	[STAC_HP_M4_4] = "hp-m4-4",
+	[STAC_HP_M4_5] = "hp-m4-5",
 };
 
 static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_92HD71BXX_REF),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f2,
-		      "HP dv5", STAC_HP_M4),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30de,
+		      "unknown HP", STAC_HP_M4_1),
+	SND_PCI_QUIRK(0x30de, 0x103c,
+		      "unknown HP", STAC_HP_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1505,
+		      "unknown HP", STAC_HP_M4_1),
+	SND_PCI_QUIRK(0x1505, 0x103c,
+		      "unknown HP", STAC_HP_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f3,
+		      "unknown HP", STAC_HP_M4_2),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f4,
-		      "HP dv7", STAC_HP_M4),
+		      "HP dv7", STAC_HP_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f7,
+		      "unknown HP", STAC_HP_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fb,
+		      "unknown HP", STAC_HP_M4_2),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fc,
-		      "HP dv7", STAC_HP_M4),
+		      "unknown HP", STAC_HP_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fd,
+		      "unknown HP", STAC_HP_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f2,
+		      "HP dv5", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3600,
+		      "unknown HP", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3602,
+		      "unknown HP", STAC_HP_M4_3),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3603,
-		      "HP dv5", STAC_HP_DV5),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x361a,
-				"unknown HP", STAC_HP_M4),
+		      "unknown HP", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x360f,
+		      "unknown HP", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3610,
+		      "unknown HP", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30ff,
+		      "unknown HP", STAC_HP_M4_4),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3601,
+		      "unknown HP", STAC_HP_M4_4),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3607,
+		      "unknown HP", STAC_HP_M4_4),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f8,
+		      "unknown HP", STAC_HP_M4_5),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fe,
+		      "unknown HP", STAC_HP_M4_5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
 				"unknown Dell", STAC_DELL_M4_1),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0234,
@@ -2339,9 +2501,11 @@
  	if (!spec->pin_configs)
  		return;
 
-	for (i = 0; i < spec->num_pins; i++)
-		stac92xx_set_config_reg(codec, spec->pin_nids[i],
-					spec->pin_configs[i]);
+	for (i = 0; i < spec->num_pins; i++) {
+		if (spec->pin_configs[i])
+			stac92xx_set_config_reg(codec, spec->pin_nids[i],
+						spec->pin_configs[i]);
+	}
 }
 
 static int stac_save_pin_cfgs(struct hda_codec *codec, unsigned int *pins)
@@ -4583,6 +4747,50 @@
 	return 0;
 }
 
+#ifdef SND_HDA_NEEDS_RESUME  /* JPA reinserting old code, had been removed */
+static void stac92hd71xx_set_power_state(struct hda_codec *codec, int pwr)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int i;
+	snd_hda_codec_write_cache(codec, codec->afg, 0,
+		AC_VERB_SET_POWER_STATE, pwr);
+
+	msleep(1);
+	for (i = 0; i < spec->num_adcs; i++) {
+		snd_hda_codec_write_cache(codec,
+			spec->adc_nids[i], 0,
+			AC_VERB_SET_POWER_STATE, pwr);
+	}
+};
+
+static int stac92hd71xx_resume(struct hda_codec *codec)
+{
+	stac92hd71xx_set_power_state(codec, AC_PWRST_D0);
+	return stac92xx_resume(codec);
+}
+
+static int stac92hd71xx_suspend(struct hda_codec *codec, pm_message_t state)
+{
+	stac92hd71xx_set_power_state(codec, AC_PWRST_D3);
+	return stac92xx_suspend(codec, state);
+};
+
+#endif
+
+static struct hda_codec_ops stac92hd71bxx_patch_ops = {
+	.build_controls = stac92xx_build_controls,
+	.build_pcms = stac92xx_build_pcms,
+	.init = stac92xx_init,
+	.free = stac92xx_free,
+	.unsol_event = stac92xx_unsol_event,
+#ifdef SND_HDA_NEEDS_RESUME
+	.suspend = stac92hd71xx_suspend,
+	.resume = stac92hd71xx_resume,
+#endif
+};
+/* JPA end of old code */
+
+
 static struct hda_input_mux stac92hd73xx_dmux = {
 	.num_items = 4,
 	.items = {
@@ -4830,6 +5038,282 @@
 	return 0;
 }
 
+static int stac92hd71bxx_connected_ports(struct hda_codec *codec,
+					 hda_nid_t *nids, int num_nids)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int idx, num;
+	unsigned int def_conf;
+
+	for (num = 0; num < num_nids; num++) {
+		for (idx = 0; idx < spec->num_pins; idx++)
+			if (spec->pin_nids[idx] == nids[num])
+				break;
+		if (idx >= spec->num_pins)
+			break;
+		def_conf = get_defcfg_connect(spec->pin_configs[idx]);
+		if (def_conf == AC_JACK_PORT_NONE) 
+			break;
+	}
+	return num;
+}
+
+static int stac92hd71bxx_connected_smuxes(struct hda_codec *codec,
+					  hda_nid_t dig0pin)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int idx;
+
+	for (idx = 0; idx < spec->num_pins; idx++)
+		if (spec->pin_nids[idx] == dig0pin)
+			break;
+	if ((idx + 2) >= spec->num_pins)
+		return 0;
+
+	/* dig1pin case */
+	if (get_defcfg_connect(spec->pin_configs[idx+1]) != AC_JACK_PORT_NONE)
+		return 2;
+
+	/* dig0pin + dig2pin case */
+	if (get_defcfg_connect(spec->pin_configs[idx+2]) != AC_JACK_PORT_NONE)
+		return 2;
+	if (get_defcfg_connect(spec->pin_configs[idx]) != AC_JACK_PORT_NONE)
+		return 1;
+	else
+		return 0;
+}
+
+static struct hda_input_mux stac92hd71b5_dmux = {
+	.num_items = 3,
+	.items = {
+		{ "Analog Inputs", 0x00 },
+		{ "Digital Mic 1", 0x02 },
+		{ "Digital Mic 2", 0x03 },
+	}
+};
+
+static int patch_stac92hd71b5(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err = 0;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	codec->patch_ops = stac92xx_patch_ops;
+	spec->num_pins = ARRAY_SIZE(stac92hd71b5_pin_nids);
+	spec->pin_nids = stac92hd71b5_pin_nids;
+
+	memcpy(&spec->private_dimux, &stac92hd71b5_dmux,
+			sizeof(stac92hd71b5_dmux));
+	spec->board_config = snd_hda_check_board_config(codec,
+							STAC_92HD71B5_MODELS,
+							stac92hd71b5_models,
+							stac92hd71b5_cfg_tbl);
+again:
+	if (spec->board_config < 0) {
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for"
+			" STAC92HD71B5, using BIOS defaults\n");
+		err = stac92xx_save_bios_config_regs(codec);
+		if (err < 0) {
+			stac92xx_free(codec);
+			return err;
+		}
+		spec->pin_configs = spec->bios_pin_configs;
+	} else {
+		spec->pin_configs = stac92hd71b5_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
+
+	if (spec->board_config > STAC_92HD71B5_REF) {
+		/* GPIO0 = EAPD */
+		spec->gpio_mask = 0x01;
+		spec->gpio_dir = 0x01;
+		spec->gpio_data = 0x01;
+		spec->eapd_mask = 0x01; /* needed? */
+		spec->eapd_switch = 1;  /* needed? */
+	}
+
+	spec->mixer = stac92hd71bxx_mixer;
+	spec->init = stac92hd71bxx_core_init;
+	codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
+
+	spec->num_pwrs = 0;
+	spec->powerdown_adcs = 1;
+	spec->digbeep_nid = 0x26;
+
+	spec->mux_nids = stac92hd71bxx_mux_nids;
+	spec->adc_nids = stac92hd71bxx_adc_nids;
+	spec->dmic_nids = stac92hd71bxx_dmic_nids;
+	spec->dmux_nids = stac92hd71bxx_dmux_nids;
+	spec->smux_nids = stac92hd71bxx_smux_nids;
+	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
+	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
+	spec->num_dmics = stac92hd71bxx_connected_ports(codec,
+				stac92hd71bxx_dmic_nids,
+				STAC92HD71BXX_NUM_DMICS);
+	if (spec->num_dmics) {
+		spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
+		spec->dinput_mux = &spec->private_dimux;
+		spec->private_dimux.num_items += spec->num_dmics -
+			(ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1);
+	}
+	spec->num_smuxes = stac92hd71bxx_connected_smuxes(codec, 0x1e);
+
+	spec->multiout.num_dacs = 1;
+	spec->multiout.hp_nid = 0x11;
+	spec->multiout.dac_nids = stac92hd71bxx_dac_nids;
+
+	err = stac92xx_parse_auto_config(codec, 0x21, 0);
+	if (!err) {
+		if (spec->board_config < 0) {
+			printk(KERN_WARNING "hda_codec: No auto-config is "
+			       "available, default to model=ref\n");
+			spec->board_config = STAC_92HD71B5_REF;
+			goto again;
+		}
+		err = -EINVAL;
+	}
+
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct hda_input_mux stac92hd75b_5port_dmux = {
+	.num_items = 3,
+	.items = {
+		{ "Analog Inputs", 0x00 },
+		{ "Mixer", 0x01 },
+		{ "Digital Mic 1", 0x02 },
+	}
+};
+
+static int patch_stac92hd75b_5port(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err = 0;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	codec->patch_ops = stac92xx_patch_ops;
+	spec->num_pins = ARRAY_SIZE(stac92hd75b_5port_pin_nids);
+	spec->pin_nids = stac92hd75b_5port_pin_nids;
+
+	memcpy(&spec->private_dimux, &stac92hd75b_5port_dmux,
+			sizeof(stac92hd75b_5port_dmux));
+	spec->board_config = snd_hda_check_board_config(codec,
+							STAC_92HD75B_5PORT_MODELS,
+							stac92hd75b_5port_models,
+							stac92hd75b_5port_cfg_tbl);
+again:
+	if (spec->board_config < 0) {
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for"
+			" STAC92HD75B_5PORT, using BIOS defaults\n");
+		err = stac92xx_save_bios_config_regs(codec);
+		if (err < 0) {
+			stac92xx_free(codec);
+			return err;
+		}
+		spec->pin_configs = spec->bios_pin_configs;
+	} else {
+		spec->pin_configs = stac92hd75b_5port_brd_tbl[spec->board_config];
+		if (!spec->pin_configs) {
+			err = stac92xx_save_bios_config_regs(codec);
+			if (err < 0) {
+				stac92xx_free(codec);
+				return err;
+			}
+			spec->pin_configs = spec->bios_pin_configs;
+		} else
+			stac92xx_set_config_regs(codec);
+	}
+
+	if (spec->board_config > STAC_92HD75B_5PORT_REF) {
+		/* GPIO0 = EAPD */
+		spec->gpio_mask = 0x01;
+		spec->gpio_dir = 0x01;
+		spec->gpio_data = 0x01;
+		spec->eapd_mask = 0x01; /* needed? */
+		spec->eapd_switch = 1;  /* needed? */
+	}
+
+	if (spec->board_config == STAC_HP_M4) {
+		/* Enable VREF power saving on GPIO1 detect */
+		snd_hda_codec_write_cache(codec, codec->afg, 0,
+			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
+		snd_hda_codec_write_cache(codec, codec->afg, 0,
+				AC_VERB_SET_UNSOLICITED_ENABLE,
+				(AC_USRSP_EN | STAC_VREF_EVENT | 0x01));
+		spec->gpio_mask |= 0x02;
+		stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
+					stac92xx_auto_set_pinctl(codec, 0x0e,
+					AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
+		spec->pin_configs[4] = 0x01813040;
+	}
+	if ((codec->revision_id & 0xf) == 0 ||
+			(codec->revision_id & 0xf) == 1) {
+#ifdef SND_HDA_NEEDS_RESUME
+		codec->patch_ops = stac92hd71bxx_patch_ops;
+#endif
+		spec->stream_delay = 40; /* 40 milliseconds */
+	}
+
+	spec->mixer = stac92hd71bxx_analog_mixer;
+	spec->dinput_mux = &spec->private_dimux;
+	spec->init = &stac92hd71bxx_analog_core_init[HD_DISABLE_PORTF];
+	codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
+
+	spec->num_pwrs = 0;
+	spec->powerdown_adcs = 1;
+	spec->digbeep_nid = 0x26;
+
+	spec->mux_nids = stac92hd71bxx_mux_nids;
+	spec->adc_nids = stac92hd71bxx_adc_nids;
+	spec->dmic_nids = stac92hd75b_5port_dmic_nids;
+	spec->dmux_nids = stac92hd71bxx_dmux_nids;
+	spec->smux_nids = stac92hd71bxx_smux_nids;
+	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
+	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
+	spec->num_dmics = stac92hd71bxx_connected_ports(codec,
+				stac92hd75b_5port_dmic_nids,
+				STAC92HD75B_5PORT_NUM_DMICS);
+	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
+	spec->num_smuxes = stac92hd71bxx_connected_smuxes(codec, 0x1e);
+
+	spec->multiout.num_dacs = 1;
+	spec->multiout.hp_nid = 0x11;
+	spec->multiout.dac_nids = stac92hd71bxx_dac_nids;
+	spec->private_dimux.num_items += spec->num_dmics -
+		(ARRAY_SIZE(stac92hd75b_5port_dmic_nids) - 1);
+
+	err = stac92xx_parse_auto_config(codec, 0x21, 0);
+	if (!err) {
+		if (spec->board_config < 0) {
+			printk(KERN_WARNING "hda_codec: No auto-config is "
+			       "available, default to model=ref\n");
+			spec->board_config = STAC_92HD75B_5PORT_REF;
+			goto again;
+		}
+		err = -EINVAL;
+	}
+
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
+
+	return 0;
+}
+
 static struct hda_input_mux stac92hd71bxx_dmux = {
 	.num_items = 4,
 	.items = {
@@ -4852,10 +5336,12 @@
 	codec->spec = spec;
 	codec->patch_ops = stac92xx_patch_ops;
 	spec->num_pins = ARRAY_SIZE(stac92hd71bxx_pin_nids);
-	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
 	spec->pin_nids = stac92hd71bxx_pin_nids;
-	memcpy(&spec->private_dimux, &stac92hd71bxx_dmux,
-			sizeof(stac92hd71bxx_dmux));
+
+	/* On 92HD75B3/92HD75B4 0x27 isn't a pin nid */
+	if (codec->vendor_id == 0x111d7603)
+		spec->num_pins--;
+
 	spec->board_config = snd_hda_check_board_config(codec,
 							STAC_92HD71BXX_MODELS,
 							stac92hd71bxx_models,
@@ -4875,112 +5361,73 @@
 
 	if (spec->board_config > STAC_92HD71BXX_REF) {
 		/* GPIO0 = EAPD */
+/* JPA start of patch from Herton Ronaldo, manually applied */
 		spec->gpio_mask = 0x01;
 		spec->gpio_dir = 0x01;
 		spec->gpio_data = 0x01;
+		spec->eapd_mask = 0x01; /* needed? */
+		spec->eapd_switch = 1;  /* needed? */
 	}
 
+	spec->mux_nids = stac92hd71bxx_mux_nids;
+	spec->adc_nids = stac92hd71bxx_adc_nids;
+	spec->dmic_nids = stac92hd71bxx_dmic_nids;
+	spec->dmux_nids = stac92hd71bxx_dmux_nids;
+	spec->smux_nids = stac92hd71bxx_smux_nids;
+	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
+	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
+	spec->num_dmics = stac92hd71bxx_connected_ports(codec,
+				stac92hd71bxx_dmic_nids,
+				STAC92HD71BXX_NUM_DMICS);
+	spec->num_smuxes = stac92hd71bxx_connected_smuxes(codec, 0x1e);
+
 	switch (codec->vendor_id) {
-	case 0x111d76b6: /* 4 Port without Analog Mixer */
-	case 0x111d76b7:
 	case 0x111d76b4: /* 6 Port without Analog Mixer */
 	case 0x111d76b5:
+		memcpy(&spec->private_dimux, &stac92hd71b5_dmux,
+			sizeof(stac92hd71b5_dmux));
+		if (spec->num_dmics) {
+			spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
+			spec->dinput_mux = &spec->private_dimux;
+		}
 		spec->mixer = stac92hd71bxx_mixer;
 		spec->init = stac92hd71bxx_core_init;
 		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 		break;
-	case 0x111d7608: /* 5 Port with Analog Mixer */
-		switch (spec->board_config) {
-		case STAC_HP_M4:
-			/* Enable VREF power saving on GPIO1 detect */
-			err = stac_add_event(spec, codec->afg,
-					     STAC_VREF_EVENT, 0x02);
-			if (err < 0)
-				return err;
-			snd_hda_codec_write_cache(codec, codec->afg, 0,
-				AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
-			snd_hda_codec_write_cache(codec, codec->afg, 0,
-				AC_VERB_SET_UNSOLICITED_ENABLE,
-				AC_USRSP_EN | err);
-			spec->gpio_mask |= 0x02;
-			break;
-		}
-		if ((codec->revision_id & 0xf) == 0 ||
-		    (codec->revision_id & 0xf) == 1)
-			spec->stream_delay = 40; /* 40 milliseconds */
-
-		/* no output amps */
-		spec->num_pwrs = 0;
-		spec->mixer = stac92hd71bxx_analog_mixer;
-		spec->dinput_mux = &spec->private_dimux;
-
-		/* disable VSW */
-		spec->init = &stac92hd71bxx_analog_core_init[HD_DISABLE_PORTF];
-		stac_change_pin_config(codec, 0xf, 0x40f000f0);
-		break;
 	case 0x111d7603: /* 6 Port with Analog Mixer */
-		if ((codec->revision_id & 0xf) == 1)
+		if ((codec->revision_id & 0xf) == 1) {
+#ifdef SND_HDA_NEEDS_RESUME
+		codec->patch_ops = stac92hd71bxx_patch_ops; /* JPA guessed code */
+#endif
 			spec->stream_delay = 40; /* 40 milliseconds */
-
-		/* no output amps */
-		spec->num_pwrs = 0;
+		}
 		/* fallthru */
 	default:
+		memcpy(&spec->private_dimux, &stac92hd71bxx_dmux,
+			sizeof(stac92hd71bxx_dmux));
 		spec->dinput_mux = &spec->private_dimux;
+		spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
 		spec->mixer = stac92hd71bxx_analog_mixer;
 		spec->init = stac92hd71bxx_analog_core_init;
 		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 	}
 
-	spec->aloopback_mask = 0x50;
-	spec->aloopback_shift = 0;
-
+	spec->num_pwrs = 0;
 	spec->powerdown_adcs = 1;
 	spec->digbeep_nid = 0x26;
-	spec->mux_nids = stac92hd71bxx_mux_nids;
-	spec->adc_nids = stac92hd71bxx_adc_nids;
-	spec->dmic_nids = stac92hd71bxx_dmic_nids;
-	spec->dmux_nids = stac92hd71bxx_dmux_nids;
-	spec->smux_nids = stac92hd71bxx_smux_nids;
-	spec->pwr_nids = stac92hd71bxx_pwr_nids;
 
-	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
-	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
-
-	switch (spec->board_config) {
-	case STAC_HP_M4:
-		/* enable internal microphone */
-		stac_change_pin_config(codec, 0x0e, 0x01813040);
-		stac92xx_auto_set_pinctl(codec, 0x0e,
-			AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
-		/* fallthru */
-	case STAC_DELL_M4_2:
-		spec->num_dmics = 0;
-		spec->num_smuxes = 0;
-		spec->num_dmuxes = 0;
-		break;
-	case STAC_DELL_M4_1:
-	case STAC_DELL_M4_3:
-		spec->num_dmics = 1;
-		spec->num_smuxes = 0;
-		spec->num_dmuxes = 0;
-		break;
-	default:
-		spec->num_dmics = STAC92HD71BXX_NUM_DMICS;
-		spec->num_smuxes = ARRAY_SIZE(stac92hd71bxx_smux_nids);
-		spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
-	};
-
-	spec->multiout.dac_nids = spec->dac_nids;
-	if (spec->dinput_mux)
-		spec->private_dimux.num_items +=
+	spec->multiout.num_dacs = 1;
+	spec->multiout.hp_nid = 0x11;
+	spec->multiout.dac_nids = stac92hd71bxx_dac_nids;
+	spec->private_dimux.num_items +=
 			spec->num_dmics -
 				(ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1);
 
-	err = stac92xx_parse_auto_config(codec, 0x21, 0x23);
+	err = stac92xx_parse_auto_config(codec, 0x21, 0);
 	if (!err) {
 		if (spec->board_config < 0) {
 			printk(KERN_WARNING "hda_codec: No auto-config is "
+/* JPA en dof patch from Herton Ronaldo, manually applied */
 			       "available, default to model=ref\n");
 			spec->board_config = STAC_92HD71BXX_REF;
 			goto again;
@@ -4996,7 +5443,7 @@
 	codec->proc_widget_hook = stac92hd7x_proc_hook;
 
 	return 0;
-};
+}
 
 static int patch_stac922x(struct hda_codec *codec)
 {
@@ -5616,10 +6063,10 @@
  	{ .id = 0x838476a5, .name = "STAC9255D", .patch = patch_stac9205 },
  	{ .id = 0x838476a6, .name = "STAC9254", .patch = patch_stac9205 },
  	{ .id = 0x838476a7, .name = "STAC9254D", .patch = patch_stac9205 },
-	{ .id = 0x111d7603, .name = "92HD75B3X5", .patch = patch_stac92hd71bxx},
-	{ .id = 0x111d7604, .name = "92HD83C1X5", .patch = patch_stac92hd83xxx},
-	{ .id = 0x111d7605, .name = "92HD81B1X5", .patch = patch_stac92hd83xxx},
-	{ .id = 0x111d7608, .name = "92HD75B2X5", .patch = patch_stac92hd71bxx},
+	{ .id = 0x111d7603, .name = "92HD75B3/4", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d7604, .name = "92HD83C1X5", .patch = patch_stac92hd83xxx },
+	{ .id = 0x111d7605, .name = "92HD81B1X5", .patch = patch_stac92hd83xxx },
+	{ .id = 0x111d7608, .name = "92HD75B1/2", .patch = patch_stac92hd75b_5port },
 	{ .id = 0x111d7674, .name = "92HD73D1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7675, .name = "92HD73C1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7676, .name = "92HD73E1X5", .patch = patch_stac92hd73xx },
@@ -5629,8 +6076,8 @@
 	{ .id = 0x111d76b3, .name = "92HD71B7X", .patch = patch_stac92hd71bxx },
 	{ .id = 0x111d76b4, .name = "92HD71B6X", .patch = patch_stac92hd71bxx },
 	{ .id = 0x111d76b5, .name = "92HD71B6X", .patch = patch_stac92hd71bxx },
-	{ .id = 0x111d76b6, .name = "92HD71B5X", .patch = patch_stac92hd71bxx },
-	{ .id = 0x111d76b7, .name = "92HD71B5X", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b6, .name = "92HD71B5X", .patch = patch_stac92hd71b5 },
+	{ .id = 0x111d76b7, .name = "92HD71B5X", .patch = patch_stac92hd71b5 },
 	{} /* terminator */
 };
 
--- alsa-driver-1.0.19/alsa-kernel/pci/hda/hda_intel.c.old	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/alsa-kernel/pci/hda/hda_intel.c	2009-02-03 09:40:11.000000000 +0100
@@ -2049,6 +2049,30 @@
 }
 
 /*
+ * white/black-listing for enable_msi
+ */
+static struct snd_pci_quirk msi_list[] __devinitdata = {
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f4, "HP dv7", 0x01),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fc, "HP dv7", 0x01),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fd, "HP dv7", 0x01),
+	{}
+};
+
+static void __devinit check_msi(struct azx *chip)
+{
+	const struct snd_pci_quirk *q;
+
+	q = snd_pci_quirk_lookup(chip->pci, msi_list);
+	if (q) {
+		printk(KERN_INFO
+		       "hda_intel: enable_msi set to 0x%x "
+		       "for device %04x:%04x\n",
+		       q->value, q->subvendor, q->subdevice);
+		enable_msi = q->value;
+	}
+}
+
+/*
  * white/black-listing for position_fix
  */
 static struct snd_pci_quirk position_fix_list[] __devinitdata = {
@@ -2151,6 +2175,7 @@
 	chip->pci = pci;
 	chip->irq = -1;
 	chip->driver_type = driver_type;
+	check_msi(chip);
 	chip->msi = enable_msi;
 	chip->dev_index = dev;
 	INIT_WORK(&chip->irq_pending_work, azx_irq_pending_work);

--------------060105050901090604070609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060105050901090604070609--
