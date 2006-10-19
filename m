From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [PATCH] Asus A6RP and
	ALC861	headphones	problem	solved
Date: Thu, 19 Oct 2006 16:39:10 -0700
Message-ID: <1161301150.26400.24.camel@razman>
References: <005701c6eb15$be16e590$83030a54@MIREK>
	<s5hlknpr4y0.wl%tiwai@suse.de><015701c6ed53$575da060$83030a54@MIREK>
	<s5hk636kdhb.wl%tiwai@suse.de> <s5hejt66aaj.wl%tiwai@suse.de>
	<013c01c6f3cb$6dbde530$83030a54@MIREK>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xHkyrUjPIHTyd9GZI1pA"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <013c01c6f3cb$6dbde530$83030a54@MIREK>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: mariook@wp.pl
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-xHkyrUjPIHTyd9GZI1pA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

What Takashi needs is a summary and description for the repository.
Here's an example from one of my patches:

        Summery: hda-codec - Add toshiba model to ALC861 codec

         This patch adds support for Toshiba laptops. Code is from
         RealTek's alsa-driver-1.0.12-4.05b tree.
 
         Signed-off-by: Tobin Davis <tdavis@dsl-only.net>

Also, I made a minor revision to your patch, changing it from asus_a6rp
to just asus.  I have been working on a similar patch for another Asus
Laptop (F3J), and if this works for them, great (otherwise I'm back to
square one).  Still, better to be more generic than model specific.
Leave the model specific details for the config table array.  Attached
are my changes.

Tobin

On Fri, 2006-10-20 at 00:10 +0200, mariook@wp.pl wrote:
> ----- Original Message ----- 
> From: "Takashi Iwai" <tiwai@suse.de>
> To: <mariook@wp.pl>
> Cc: <alsa-devel@lists.sourceforge.net>
> Sent: Tuesday, October 17, 2006 8:56 PM
> Subject: Re: [Alsa-devel] [PATCH] Asus A6RP and ALC861 headphones problem 
> solved
> 
> 
> > At Wed, 11 Oct 2006 18:45:52 +0200,
> > I wrote:
> >>
> >> At Wed, 11 Oct 2006 18:36:02 +0200,
> >> <mariook@wp.pl> wrote:
> >> >
> >> > ----- Original Message ----- 
> >> > From: "Takashi Iwai" <tiwai@suse.de>
> >> > To: <mariook@wp.pl>
> >> > Cc: <alsa-devel@lists.sourceforge.net>
> >> > Sent: Monday, October 09, 2006 3:31 PM
> >> > Subject: Re: [Alsa-devel] [PATCH] Asus A6RP and ALC861 headphones 
> >> > problem
> >> > solved
> >> >
> >> > > At Sun, 8 Oct 2006 22:10:02 +0200,
> >> > > <mariook@wp.pl> wrote:
> >> > >>
> >> > >> Hi!
> >> > >>
> >> > >> I finally made it, now can use headphones with my laptop :)
> >> > >>
> >> > >> My last thread (started on 23 Sep 20:08) about my problem is quite 
> >> > >> long,
> >> > >> so
> >> > >> I decided to make a new one with result of my work - patched
> >> > >> patch_realtek.c
> >> > >> file.
> >> > >>
> >> > >> The patch I posted least time was good. The only thing that had to 
> >> > >> be
> >> > >> changed is to remove this line:
> >> > >> .need_dac_fix = 1,
> >> > >> from alc861_presets. With this line of code the patch doesn't want 
> >> > >> to
> >> > >> work.
> >> > >
> >> > > This implies that the headphone jack is connected to another DAC, 
> >> > > most
> >> > > likely the side one (0x04).  The right fix would to add .hp_nid = 
> >> > > 0x04
> >> > > in the preset table.  If 0x04 doesn't work, try 0x05 or 0x06 instead.
> >> >
> >> > .hp_nid = 0x06 worked (as I understood it's surround nid  - I wrote 
> >> > earlier
> >> > that in my case hp jack is surr-out (0x09))
> >> >
> >> > >> There is only one thing that I'm not sure...
> >> > >> When channel mode is changed to 6ch the sound is in built-in 
> >> > >> speakers,
> >> > >> line-in jack and mic jack, but not in hp jack (of course when i plug
> >> > >> something to hp jack the sound in built-in speakers disappears). Is 
> >> > >> that
> >> > >> correct?
> >> >
> >> > Even with fix described above this is still a problem - when channel 
> >> > mode is
> >> > set to 6ch the sound in hp jack is not present (the surround output 
> >> > goes to
> >> > line-in jack, there is also clfe output in mic jack and no output is in 
> >> > hp
> >> > jack).
> >>
> >> The stream is set up to hp_nid (0x06) too, regardless of the
> >> channel mode.  You can confirm this by compiling with
> >> --with-debug=detect option that will show more debug messages.
> >> So, it shouldn't be the problem of hp_nid but others.
> >>
> >> If the no sound comes out, it means either pin is reset to input, or
> >> a volume is muted in the route to DAC 0x06 -> hp-jack.  Check
> >> /proc/asound/card0/codec#* after ch6 mode.  You can comapre the status
> >> with ch6 mode, too, by simply diffing codec#* dumps in the different
> >> states.
> >
> > I still wonder whether the HP output works on 6-channel mode if you
> > remove .need_dac_fix = 1 in the preset...
> 
> As far as I remember it didn't work...
> 
> >> > >> Because each time I make a patch file it doesn't want to work (I 
> >> > >> make it
> >> > >> with this command: diff -Nuar old.file new.file), I'm sending in
> >> > >> attachment
> >> > >> compressed patch_realtek.c file (I patched final version 1.0.13 of
> >> > >> patch_realtek.c). The only important changes are those connected 
> >> > >> with
> >> > >> asus-a6rp model, please ignore changes made in parts of code 
> >> > >> connected
> >> > >> with
> >> > >> other models.
> >> > >
> >> > > Oh no, please send a patch instead.  Otherwise we cannot review and
> >> > > check your changes.
> >> > >
> >> > > What do you mean "it doesn't want to work"?  If you changed a single
> >> > > file, you can just create a diff for that file, simply by
> >> > > diff -u orig-alsa-kernel/pci/hda/patch_realtek.c \
> >> > > new-alsa-kernel/pci/hda/patch_realtek.c
> >> >
> >> > Ok, patch is in the attachment :)
> >>
> >> Thanks, but an uncompressed file would be more appreciated :)
> >
> > I checked the patch now and it looks good.
> >
> > Could you give a proper summary, changelog and signed-off-by line for
> > committing to the upstream?  The remaining small issues can be fixed
> > later, too.
> 
> Sorry but I don't understand, what changelog? Everything I have changed is 
> in patch file.
> The problem was with 3 things:
> 1) the hp jack is 0x09 not 0x0f (0x0f has to be set to vref)
> 2) hp_nid was wrong, it has to be set to 0x06
> 3) in 6ch mode surround output (hp jack output) 'jumps' to line-in jack, 
> leaving no output in hp jack
> What else should I write?
> 
> > Thanks,
> >
> > Takashi
> >
> 
> Thanks,
> Mariusz 
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-xHkyrUjPIHTyd9GZI1pA
Content-Disposition: attachment; filename=asus.patch
Content-Type: text/x-patch; name=asus.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r d7fe584f7395 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Thu Oct 19 20:35:56 2006 +0200
+++ b/pci/hda/patch_realtek.c	Thu Oct 19 16:31:24 2006 -0700
@@ -100,6 +100,7 @@ enum {
 	ALC861_6ST_DIG,
 	ALC861_UNIWILL_M31,
 	ALC861_TOSHIBA,
+	ALC861_ASUS.
 	ALC861_AUTO,
 	ALC861_MODEL_LAST,
 };
@@ -6650,6 +6651,44 @@ static struct hda_channel_mode alc861_un
 	{ 4, alc861_uniwill_m31_ch4_init },
 };
 
+/* Set mic1 and line-in as input and unmute the mixer */
+static struct hda_verb alc861_asus_ch2_init[] = {
+	/* set pin widget 1Ah (line in) for input */
+	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
+	/* set pin widget 18h (mic1/2) for input, for mic also enable the vref */
+	{ 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
+
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb00c },
+#if 0
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 << 8)) }, /*mic*/
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x02 << 8)) }, /*line-in*/
+#endif
+	{ } /* end */
+};
+/* Set mic1 nad line-in as output and mute mixer */
+static struct hda_verb alc861_asus_ch6_init[] = {
+	/* set pin widget 1Ah (line in) for output (Back Surround)*/
+	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
+	/* { 0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE }, */
+	/* set pin widget 18h (mic1) for output (CLFE)*/
+	{ 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
+	/* { 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE }, */
+	{ 0x0c, AC_VERB_SET_CONNECT_SEL, 0x00 },
+	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00 },
+
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080 },
+#if 0
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x01 << 8)) }, /*mic*/
+	{ 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x02 << 8)) }, /*line in*/
+#endif
+	{ } /* end */
+};
+
+static struct hda_channel_mode alc861_asus_modes[2] = {
+	{ 2, alc861_asus_ch2_init },
+	{ 6, alc861_asus_ch6_init },
+};
+
 /* patch-ALC861 */
 
 static struct snd_kcontrol_new alc861_base_mixer[] = {
@@ -6789,6 +6828,48 @@ static struct snd_kcontrol_new alc861_un
                 .private_value = ARRAY_SIZE(alc861_uniwill_m31_modes),
 	},
 	{ } /* end */
+};
+
+static struct snd_kcontrol_new alc861_asus_mixer[] = {
+        /* output mixer control */
+	HDA_CODEC_MUTE("Front Playback Switch", 0x03, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Surround Playback Switch", 0x06, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x05, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x05, 2, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Side Playback Switch", 0x04, 0x0, HDA_OUTPUT),
+
+	/* Input mixer control */
+	HDA_CODEC_VOLUME("Input Playback Volume", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Input Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x15, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x15, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x15, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x15, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x10, 0x01, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1a, 0x03, HDA_OUTPUT), /* was HDA_INPUT (why?) */
+ 
+	/* Capture mixer control */
+	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.count = 1,
+		.info = alc_mux_enum_info,
+		.get = alc_mux_enum_get,
+		.put = alc_mux_enum_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Channel Mode",
+		.info = alc_ch_mode_info,
+		.get = alc_ch_mode_get,
+		.put = alc_ch_mode_put,
+                .private_value = ARRAY_SIZE(alc861_asus_modes),
+	},
+	{ }
 };			
 	
 /*
@@ -6979,6 +7060,67 @@ static struct hda_verb alc861_uniwill_m3
 	{ }
 };
 
+static struct hda_verb alc861_asus_init_verbs[] = {
+	/*
+	 * Unmute ADC0 and set the default input to mic-in
+	 */
+	/* port-A for surround (rear panel) | according to codec#0 this is the HP jack*/
+	{ 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0 }, /* was 0x00 */
+	/* route front PCM to HP */
+	{ 0x0e, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	/* port-B for mic-in (rear panel) with vref */
+	{ 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
+	/* port-C for line-in (rear panel) */
+	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
+	/* port-D for Front */
+	{ 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
+	{ 0x0b, AC_VERB_SET_CONNECT_SEL, 0x00 },
+	/* port-E for HP out (front panel) */
+	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 }, /* this has to be set to VREF80 */
+	/* route front PCM to HP */
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	/* port-F for mic-in (front panel) with vref */
+	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
+	/* port-G for CLFE (rear panel) */
+	{ 0x1f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
+	/* port-H for side (rear panel) */
+	{ 0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
+	/* CD-in */
+	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
+	/* route front mic to ADC1*/
+	{0x08, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	/* Unmute DAC0~3 & spdif out*/
+	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x06, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Unmute Mixer 14 (mic) 1c (Line in)*/
+	{0x014, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+        {0x014, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x01c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+        {0x01c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	
+	/* Unmute Stereo Mixer 15 */
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb00c          }, /* Output 0~12 step */
+
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(3)}, /* hp used DAC 3 (Front) */
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},
+	{ }
+};
+
 /*
  * generic initialization of ADC, input mixers and output mixers
  */
@@ -7350,10 +7492,12 @@ static struct hda_board_config alc861_cf
 	{ .pci_subvendor = 0x1584, .pci_subdevice = 0x9072,
 	  .config = ALC861_UNIWILL_M31 },
 	{ .modelname = "toshiba", .config = ALC861_TOSHIBA },
-	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1338,
-	  .config = ALC861_TOSHIBA },
 	{ .pci_subvendor = 0x1179, .pci_subdevice = 0xff10,
 	  .config = ALC861_TOSHIBA },
+	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1338,
+	  .config = ALC861_ASUS },
+	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1393,
+	  .config = ALC861_ASUS },
 	{ .modelname = "auto", .config = ALC861_AUTO },
 	{}
 };
@@ -7434,6 +7578,20 @@ static struct alc_config_preset alc861_p
 		.unsol_event = alc861_toshiba_unsol_event,
 		.init_hook = alc861_toshiba_automute,
 	},
+	[ALC861_ASUS] = {
+ 		.mixers = { alc861_asus_mixer },
+ 		.init_verbs = { alc861_asus_init_verbs },
+ 		.num_dacs = ARRAY_SIZE(alc861_dac_nids),
+ 		.dac_nids = alc861_dac_nids,
+ 		.dig_out_nid = ALC861_DIGOUT_NID,
+ 		.num_channel_mode = ARRAY_SIZE(alc861_asus_modes),
+ 		.channel_mode = alc861_asus_modes,
+ 		.need_dac_fix = 1,
+ 		.hp_nid = 0x06,
+ 		.num_adc_nids = ARRAY_SIZE(alc861_adc_nids),
+ 		.adc_nids = alc861_adc_nids,
+ 		.input_mux = &alc861_capture_source,
+ 	},
 };	
 
 

--=-xHkyrUjPIHTyd9GZI1pA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-xHkyrUjPIHTyd9GZI1pA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-xHkyrUjPIHTyd9GZI1pA--
