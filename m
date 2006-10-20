From: <mariook@wp.pl>
Subject: Re: [PATCH] Asus A6RP and
	ALC861	headphones	problem	solved
Date: Fri, 20 Oct 2006 22:21:21 +0200
Message-ID: <003801c6f485$4ef87010$83030a54@MIREK>
References: <005701c6eb15$be16e590$83030a54@MIREK><s5hlknpr4y0.wl%tiwai@suse.de><015701c6ed53$575da060$83030a54@MIREK><s5hk636kdhb.wl%tiwai@suse.de><s5hejt66aaj.wl%tiwai@suse.de><013c01c6f3cb$6dbde530$83030a54@MIREK><1161301150.26400.24.camel@razman>
	<s5hejt32jtz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0035_01C6F496.122B7EF0"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0035_01C6F496.122B7EF0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de>
To: "Tobin Davis" <tdavis@dsl-only.net>
Cc: <mariook@wp.pl>; <alsa-devel@lists.sourceforge.net>
Sent: Friday, October 20, 2006 3:33 PM
Subject: Re: [Alsa-devel] [PATCH] Asus A6RP and ALC861 headphones problem 
solved


> At Thu, 19 Oct 2006 16:39:10 -0700,
> Tobin Davis wrote:
>>
>> What Takashi needs is a summary and description for the repository.
>> Here's an example from one of my patches:
>>
>>         Summery: hda-codec - Add toshiba model to ALC861 codec
>>
>>          This patch adds support for Toshiba laptops. Code is from
>>          RealTek's alsa-driver-1.0.12-4.05b tree.
>>
>>          Signed-off-by: Tobin Davis <tdavis@dsl-only.net>
>
> Yep, exactly.
>
>> Also, I made a minor revision to your patch, changing it from asus_a6rp
>> to just asus.  I have been working on a similar patch for another Asus
>> Laptop (F3J), and if this works for them, great (otherwise I'm back to
>> square one).  Still, better to be more generic than model specific.
>> Leave the model specific details for the config table array.  Attached
>> are my changes.
>
> Don't forget to add an entry with modelname="asus", and change
> ALSA-Configuration.txt appropriately, too.
>
>
> Thanks,
>
> Takashi

Ok, so here it is :)

Summary: hda-codec - Add asus model to ALC861 codec

          This patch adds support for Asus laptops (for example: Asus 
A6Rp-AP002).

          Signed-off-by: Mariusz Domanski <mariook@wp.pl>

I modified patch_realtek.c from the newest hg tree and made asus.patch 
basing on it (also included change made by Tobin - pci_subdevice for another 
asus laptop).
I also modified the newest ALSA-Configuration.txt and made patch.
Patches are in the attachment.

Thanks,
Mariusz 

------=_NextPart_000_0035_01C6F496.122B7EF0
Content-Type: application/octet-stream;
	name="asus.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="asus.patch"

--- patch_realtek.c	2006-10-20 20:58:06.000000000 +0200=0A=
+++ alsa-kernel/pci/hda/patch_realtek.c	2006-10-20 21:17:27.000000000 =
+0200=0A=
@@ -100,6 +100,7 @@=0A=
 	ALC861_6ST_DIG,=0A=
 	ALC861_UNIWILL_M31,=0A=
 	ALC861_TOSHIBA,=0A=
+	ALC861_ASUS,=0A=
 	ALC861_AUTO,=0A=
 	ALC861_MODEL_LAST,=0A=
 };=0A=
@@ -6650,6 +6651,44 @@=0A=
 	{ 4, alc861_uniwill_m31_ch4_init },=0A=
 };=0A=
 =0A=
+/* Set mic1 and line-in as input and unmute the mixer */=0A=
+static struct hda_verb alc861_asus_ch2_init[] =3D {=0A=
+	/* set pin widget 1Ah (line in) for input */=0A=
+	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },=0A=
+	/* set pin widget 18h (mic1/2) for input, for mic also enable the vref =
*/=0A=
+	{ 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },=0A=
+=0A=
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb00c },=0A=
+#if 0=0A=
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 << 8)) }, /*mic*/=0A=
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x02 << 8)) }, =
/*line-in*/=0A=
+#endif=0A=
+	{ } /* end */=0A=
+};=0A=
+/* Set mic1 nad line-in as output and mute mixer */=0A=
+static struct hda_verb alc861_asus_ch6_init[] =3D {=0A=
+	/* set pin widget 1Ah (line in) for output (Back Surround)*/=0A=
+	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },=0A=
+	/* { 0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE }, */=0A=
+	/* set pin widget 18h (mic1) for output (CLFE)*/=0A=
+	{ 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },=0A=
+	/* { 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE }, */=0A=
+	{ 0x0c, AC_VERB_SET_CONNECT_SEL, 0x00 },=0A=
+	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00 },=0A=
+=0A=
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080 },=0A=
+#if 0=0A=
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x01 << 8)) }, /*mic*/=0A=
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x02 << 8)) }, /*line =
in*/=0A=
+#endif=0A=
+	{ } /* end */=0A=
+};=0A=
+=0A=
+static struct hda_channel_mode alc861_asus_modes[2] =3D {=0A=
+	{ 2, alc861_asus_ch2_init },=0A=
+	{ 6, alc861_asus_ch6_init },=0A=
+};=0A=
+=0A=
 /* patch-ALC861 */=0A=
 =0A=
 static struct snd_kcontrol_new alc861_base_mixer[] =3D {=0A=
@@ -6790,6 +6829,49 @@=0A=
 	},=0A=
 	{ } /* end */=0A=
 };			=0A=
+=0A=
+static struct snd_kcontrol_new alc861_asus_mixer[] =3D {=0A=
+        /* output mixer control */=0A=
+	HDA_CODEC_MUTE("Front Playback Switch", 0x03, 0x0, HDA_OUTPUT),=0A=
+	HDA_CODEC_MUTE("Surround Playback Switch", 0x06, 0x0, HDA_OUTPUT),=0A=
+	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x05, 1, 0x0, =
HDA_OUTPUT),=0A=
+	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x05, 2, 0x0, HDA_OUTPUT),=0A=
+	HDA_CODEC_MUTE("Side Playback Switch", 0x04, 0x0, HDA_OUTPUT),=0A=
+=0A=
+	/* Input mixer control */=0A=
+	HDA_CODEC_VOLUME("Input Playback Volume", 0x15, 0x0, HDA_OUTPUT),=0A=
+	HDA_CODEC_MUTE("Input Playback Switch", 0x15, 0x0, HDA_OUTPUT),=0A=
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x15, 0x0, HDA_INPUT),=0A=
+	HDA_CODEC_MUTE("CD Playback Switch", 0x15, 0x0, HDA_INPUT),=0A=
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x15, 0x02, HDA_INPUT),=0A=
+	HDA_CODEC_MUTE("Line Playback Switch", 0x15, 0x02, HDA_INPUT),=0A=
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x15, 0x01, HDA_INPUT),=0A=
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x15, 0x01, HDA_INPUT),=0A=
+	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x10, 0x01, HDA_OUTPUT),=0A=
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1a, 0x03, HDA_OUTPUT), =
/* was HDA_INPUT (why?) */=0A=
+ =0A=
+	/* Capture mixer control */=0A=
+	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),=0A=
+	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),=0A=
+	{=0A=
+		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,=0A=
+		.name =3D "Capture Source",=0A=
+		.count =3D 1,=0A=
+		.info =3D alc_mux_enum_info,=0A=
+		.get =3D alc_mux_enum_get,=0A=
+		.put =3D alc_mux_enum_put,=0A=
+	},=0A=
+	{=0A=
+		.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,=0A=
+		.name =3D "Channel Mode",=0A=
+		.info =3D alc_ch_mode_info,=0A=
+		.get =3D alc_ch_mode_get,=0A=
+		.put =3D alc_ch_mode_put,=0A=
+                .private_value =3D ARRAY_SIZE(alc861_asus_modes),=0A=
+	},=0A=
+	{ }=0A=
+};			=0A=
+=0A=
 	=0A=
 /*=0A=
  * generic initialization of ADC, input mixers and output mixers=0A=
@@ -6979,6 +7061,68 @@=0A=
 	{ }=0A=
 };=0A=
 =0A=
+static struct hda_verb alc861_asus_init_verbs[] =3D {=0A=
+	/*=0A=
+	 * Unmute ADC0 and set the default input to mic-in=0A=
+	 */=0A=
+	/* port-A for surround (rear panel) | according to codec#0 this is the =
HP jack*/=0A=
+	{ 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0 }, /* was 0x00 */=0A=
+	/* route front PCM to HP */=0A=
+	{ 0x0e, AC_VERB_SET_CONNECT_SEL, 0x01 },=0A=
+	/* port-B for mic-in (rear panel) with vref */=0A=
+	{ 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },=0A=
+	/* port-C for line-in (rear panel) */=0A=
+	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },=0A=
+	/* port-D for Front */=0A=
+	{ 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },=0A=
+	{ 0x0b, AC_VERB_SET_CONNECT_SEL, 0x00 },=0A=
+	/* port-E for HP out (front panel) */=0A=
+	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 }, /* this has to be set =
to VREF80 */=0A=
+	/* route front PCM to HP */=0A=
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x01 },=0A=
+	/* port-F for mic-in (front panel) with vref */=0A=
+	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },=0A=
+	/* port-G for CLFE (rear panel) */=0A=
+	{ 0x1f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },=0A=
+	/* port-H for side (rear panel) */=0A=
+	{ 0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },=0A=
+	/* CD-in */=0A=
+	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },=0A=
+	/* route front mic to ADC1*/=0A=
+	{0x08, AC_VERB_SET_CONNECT_SEL, 0x00},=0A=
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},=0A=
+	/* Unmute DAC0~3 & spdif out*/=0A=
+	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},=0A=
+	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},=0A=
+	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},=0A=
+	{0x06, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},=0A=
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},=0A=
+	/* Unmute Mixer 14 (mic) 1c (Line in)*/=0A=
+	{0x014, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},=0A=
+        {0x014, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},=0A=
+	{0x01c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},=0A=
+        {0x01c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},=0A=
+	=0A=
+	/* Unmute Stereo Mixer 15 */=0A=
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},=0A=
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},=0A=
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},=0A=
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb00c          }, /* Output 0~12 =
step */=0A=
+=0A=
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},=0A=
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},=0A=
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},=0A=
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},=0A=
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},=0A=
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},=0A=
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},=0A=
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},=0A=
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(3)}, /* hp used DAC 3 =
(Front) */=0A=
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},=0A=
+	{ }=0A=
+};=0A=
+=0A=
+=0A=
 /*=0A=
  * generic initialization of ADC, input mixers and output mixers=0A=
  */=0A=
@@ -7350,10 +7494,13 @@=0A=
 	{ .pci_subvendor =3D 0x1584, .pci_subdevice =3D 0x9072,=0A=
 	  .config =3D ALC861_UNIWILL_M31 },=0A=
 	{ .modelname =3D "toshiba", .config =3D ALC861_TOSHIBA },=0A=
-	{ .pci_subvendor =3D 0x1043, .pci_subdevice =3D 0x1338,=0A=
-	  .config =3D ALC861_TOSHIBA },=0A=
 	{ .pci_subvendor =3D 0x1179, .pci_subdevice =3D 0xff10,=0A=
 	  .config =3D ALC861_TOSHIBA },=0A=
+	{ .modelname =3D "asus", .config =3D ALC861_ASUS},=0A=
+	{ .pci_subvendor =3D 0x1043, .pci_subdevice =3D 0x1393,=0A=
+	  .config =3D ALC861_ASUS },=0A=
+	{ .pci_subvendor =3D 0x1043, .pci_subdevice =3D 0x1338,=0A=
+	  .config =3D ALC861_ASUS },=0A=
 	{ .modelname =3D "auto", .config =3D ALC861_AUTO },=0A=
 	{}=0A=
 };=0A=
@@ -7434,6 +7581,20 @@=0A=
 		.unsol_event =3D alc861_toshiba_unsol_event,=0A=
 		.init_hook =3D alc861_toshiba_automute,=0A=
 	},=0A=
+	[ALC861_ASUS] =3D {=0A=
+		.mixers =3D { alc861_asus_mixer },=0A=
+		.init_verbs =3D { alc861_asus_init_verbs },=0A=
+		.num_dacs =3D ARRAY_SIZE(alc861_dac_nids),=0A=
+		.dac_nids =3D alc861_dac_nids,=0A=
+		.dig_out_nid =3D ALC861_DIGOUT_NID,=0A=
+		.num_channel_mode =3D ARRAY_SIZE(alc861_asus_modes),=0A=
+		.channel_mode =3D alc861_asus_modes,=0A=
+		.need_dac_fix =3D 1,=0A=
+		.hp_nid =3D 0x06,=0A=
+		.num_adc_nids =3D ARRAY_SIZE(alc861_adc_nids),=0A=
+		.adc_nids =3D alc861_adc_nids,=0A=
+		.input_mux =3D &alc861_capture_source,=0A=
+	},=0A=
 };	=0A=
 =0A=
 =0A=

------=_NextPart_000_0035_01C6F496.122B7EF0
Content-Type: application/octet-stream;
	name="ALSA-Configuration.txt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ALSA-Configuration.txt.patch"

--- ALSA-Configuration.txt	2006-10-20 20:58:05.000000000 +0200=0A=
+++ alsa-kernel/Documentation/ALSA-Configuration.txt	2006-10-20 =
21:21:54.000000000 +0200=0A=
@@ -836,6 +836,7 @@=0A=
 	  3stack-660	3-jack (for ALC660)=0A=
 	  uniwill-m31	Uniwill M31 laptop=0A=
 	  toshiba	Toshiba laptop support=0A=
+	  asus		Asus laptop support=0A=
 	  auto		auto-config reading BIOS (default)=0A=
 =0A=
 	CMI9880=0A=

------=_NextPart_000_0035_01C6F496.122B7EF0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_NextPart_000_0035_01C6F496.122B7EF0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_NextPart_000_0035_01C6F496.122B7EF0--
