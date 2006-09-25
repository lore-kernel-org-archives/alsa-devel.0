From: "Mariusz Domanski" <surfer.q3@gmail.com>
Subject: Re: hda-intel,
	ALC861 and Asus A6rp laptop - problem with headphones almost solved
Date: Mon, 25 Sep 2006 20:25:50 +0200
Message-ID: <b209ae1e0609251125k399f7897jcf4d33d96d55055f@mail.gmail.com>
References: <b209ae1e0609231108i634d41fm87012983b4b9b83e@mail.gmail.com>
	<s5hpsdjj4mp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643367830=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpsdjj4mp.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1643367830==
Content-Type: multipart/alternative;
	boundary="----=_Part_36062_16247085.1159208750945"

------=_Part_36062_16247085.1159208750945
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/9/25, Takashi Iwai <tiwai@suse.de>:
>
> >> Propably the sound will appear after (x)th compilation, but why? Why it
> is not working
> >> all the time?
>
> >No idea.  A weird hardware...
>
> >> And why the ALC861 is detected to be the ALC660?
>
> >Simply because they are almost compatible (according to Realtek).
>
> >The patch looks broken.  Could you regenerated it?
>
>
> >thanks,
>
> >Takashi


 Here is patch (now I'll write it as a part of email):

--- hda_old/patch_realtek.c 2006-09-12 15:40:56.000000000 +0200
+++ hda/patch_realtek.c 2006-09-23 19:25:45.000000000 +0200
@@ -91,6 +91,7 @@
ALC861_3ST_DIG,
ALC861_6ST_DIG,
ALC861_UNIWILL_M31,
+ ALC861_ASUS_A6RP,
ALC861_AUTO,
ALC861_MODEL_LAST,
};
@@ -6070,6 +6071,45 @@
{ 4, alc861_uniwill_m31_ch4_init },
};

+/* Set mic1 and line-in as input and unmute the mixer */
+static struct hda_verb alc861_asus_a6rp_ch2_init[] = {
+ /* set pin widget 1Ah (line in) for input */
+ { 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
+ /* set pin widget 18h (mic1/2) for input, for mic also enable the vref */
+ { 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
+
+ { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb00c },
+#if 0
+ { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 << 8)) }, /*mic*/
+ { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x02 << 8)) }, /*line-in*/
+#endif
+ { } /* end */
+};
+/* Set mic1 nad line-in as output and mute mixer */
+static struct hda_verb alc861_asus_a6rp_ch6_init[] = {
+ /* set pin widget 1Ah (line in) for output (Back Surround)*/
+ { 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
+// { 0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+ /* set pin widget 18h (mic1) for output (CLFE)*/
+ { 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
+// { 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+
+ { 0x0c, AC_VERB_SET_CONNECT_SEL, 0x00 },
+ { 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00 },
+
+ { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080 },
+//#if 0
+ { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x01 << 8)) }, /*mic*/
+ { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x02 << 8)) }, /*line in*/
+//#endif
+ { } /* end */
+};
+
+static struct hda_channel_mode alc861_asus_a6rp_modes[2] = {
+ { 2, alc861_asus_a6rp_ch2_init },
+ { 6, alc861_asus_a6rp_ch6_init },
+};
+
/* patch-ALC861 */

static struct snd_kcontrol_new alc861_base_mixer[] = {
@@ -6188,6 +6228,48 @@
},
{ } /* end */
};
+
+static struct snd_kcontrol_new alc861_asus_a6rp_mixer[] = {
+ /* output mixer control */
+ HDA_CODEC_MUTE("Front Playback Switch", 0x03, 0x0, HDA_OUTPUT),
+ HDA_CODEC_MUTE("Surround Playback Switch", 0x06, 0x0, HDA_OUTPUT),
+ HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x05, 1, 0x0, HDA_OUTPUT),
+ HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x05, 2, 0x0, HDA_OUTPUT),
+ /*HDA_CODEC_MUTE("Side Playback Switch", 0x04, 0x0, HDA_OUTPUT), */
+
+ /* Input mixer control */
+ /* HDA_CODEC_VOLUME("Input Playback Volume", 0x15, 0x0, HDA_OUTPUT),
+ HDA_CODEC_MUTE("Input Playback Switch", 0x15, 0x0, HDA_OUTPUT), */
+ HDA_CODEC_VOLUME("CD Playback Volume", 0x15, 0x0, HDA_INPUT),
+ HDA_CODEC_MUTE("CD Playback Switch", 0x15, 0x0, HDA_INPUT),
+ HDA_CODEC_VOLUME("Line Playback Volume", 0x15, 0x02, HDA_INPUT),
+ HDA_CODEC_MUTE("Line Playback Switch", 0x15, 0x02, HDA_INPUT),
+ HDA_CODEC_VOLUME("Mic Playback Volume", 0x15, 0x01, HDA_INPUT),
+ HDA_CODEC_MUTE("Mic Playback Switch", 0x15, 0x01, HDA_INPUT),
+ HDA_CODEC_MUTE("Front Mic Playback Switch", 0x10, 0x01, HDA_OUTPUT),
+ HDA_CODEC_MUTE("Headphone Playback Switch", 0x1a, 0x03, HDA_OUTPUT), //
was HDA_INPUT(?)
+
+ /* Capture mixer control */
+ HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
+ HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
+ {
+ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+ .name = "Capture Source",
+ .count = 1,
+ .info = alc_mux_enum_info,
+ .get = alc_mux_enum_get,
+ .put = alc_mux_enum_put,
+ },
+ {
+ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+ .name = "Channel Mode",
+ .info = alc_ch_mode_info,
+ .get = alc_ch_mode_get,
+ .put = alc_ch_mode_put,
+ .private_value = ARRAY_SIZE(alc861_asus_a6rp_modes),
+ },
+ { }
+};

/*
* generic initialization of ADC, input mixers and output mixers
@@ -6377,6 +6459,68 @@
{ }
};

+static struct hda_verb alc861_asus_a6rp_init_verbs[] = {
+ /*
+ * Unmute ADC0 and set the default input to mic-in
+ */
+ /* port-A for surround (rear panel) | according to my codec#0 this is the
HP jack*/
+ { 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0 }, // was 0x00
+ /* route front PCM to HP */
+ //{ 0x0e, AC_VERB_SET_CONNECT_SEL, 0x01 },
+ /* port-B for mic-in (rear panel) with vref */
+ { 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
+ /* port-C for line-in (rear panel) */
+ { 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
+ /* port-D for Front */
+ { 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
+ { 0x0b, AC_VERB_SET_CONNECT_SEL, 0x00 },
+ /* port-E for HP out (front panel) */
+ { 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 }, // this has to be set to
VREF80
+ /* route front PCM to HP */
+ { 0x0f, AC_VERB_SET_CONNECT_SEL, 0x01 },
+ /* port-F for mic-in (front panel) with vref */
+ { 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },
+ /* port-G for CLFE (rear panel) */
+ { 0x1f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+ /* port-H for side (rear panel) */
+ { 0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+ /* CD-in */
+ { 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },
+ /* route front mic to ADC1*/
+ {0x08, AC_VERB_SET_CONNECT_SEL, 0x00},
+ {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ /* Unmute DAC0~3 & spdif out*/
+ {0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+ {0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+ {0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+ {0x06, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+ {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+
+ /* Unmute Mixer 14 (mic) 1c (Line in)*/
+ {0x014, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ {0x014, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+ {0x01c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ {0x01c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+
+ /* Unmute Stereo Mixer 15 */
+ {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+ {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},
+ {0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb00c }, //Output 0~12 step
+
+ {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+ {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+ {0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ {0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+ {0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+ {0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+ {0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(3)}, // hp used DAC 3
(Front)
+ {0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},
+ { }
+};
+
/*
* generic initialization of ADC, input mixers and output mixers
*/
@@ -6714,6 +6858,9 @@
{ .modelname = "uniwill-m31", .config = ALC861_UNIWILL_M31},
{ .pci_subvendor = 0x1584, .pci_subdevice = 0x9072,
.config = ALC861_UNIWILL_M31 },
+ { .modelname = "asus-a6rp", .config = ALC861_ASUS_A6RP},
+ { .pci_subvendor = 0x1043, .pci_subdevice = 0x1393,
+ .config = ALC861_ASUS_A6RP },
{ .modelname = "auto", .config = ALC861_AUTO },
{}
};
@@ -6781,6 +6928,19 @@
.adc_nids = alc861_adc_nids,
.input_mux = &alc861_capture_source,
},
+ [ALC861_ASUS_A6RP] = {
+ .mixers = { alc861_asus_a6rp_mixer },
+ .init_verbs = { alc861_asus_a6rp_init_verbs },
+ .num_dacs = ARRAY_SIZE(alc861_dac_nids),
+ .dac_nids = alc861_dac_nids,
+ .dig_out_nid = ALC861_DIGOUT_NID,
+ .num_channel_mode = ARRAY_SIZE(alc861_asus_a6rp_modes),
+ .channel_mode = alc861_asus_a6rp_modes,
+ .need_dac_fix = 1,
+ .num_adc_nids = ARRAY_SIZE(alc861_adc_nids),
+ .adc_nids = alc861_adc_nids,
+ .input_mux = &alc861_capture_source,
+ },

};

------=_Part_36062_16247085.1159208750945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2006/9/25, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
&gt;&gt; Propably the sound will appear after (x)th compilation, but why? Why it is not working<br>&gt;&gt; all the time?<br><br>&gt;No idea.&nbsp;&nbsp;A weird hardware...<br><br>&gt;&gt; And why the ALC861 is detected to be the ALC660?
<br><br>&gt;Simply because they are almost compatible (according to Realtek).<br><br>&gt;The patch looks broken.&nbsp;&nbsp;Could you regenerated it?<br><br><br>&gt;thanks,<br><br>&gt;Takashi</blockquote><div><br>&nbsp;Here is patch (now I'll write it as a part of email):
<br><br>--- hda_old/patch_realtek.c     2006-09-12 15:40:56.000000000 +0200<br>+++ hda/patch_realtek.c 2006-09-23 19:25:45.000000000 +0200<br>@@ -91,6 +91,7 @@<br>        ALC861_3ST_DIG,<br>        ALC861_6ST_DIG,<br>        ALC861_UNIWILL_M31,
<br>+       ALC861_ASUS_A6RP,<br>        ALC861_AUTO,<br>        ALC861_MODEL_LAST,<br> };<br>@@ -6070,6 +6071,45 @@<br>        { 4, alc861_uniwill_m31_ch4_init },<br> };<br><br>+/* Set mic1 and line-in as input and unmute the mixer */
<br>+static struct hda_verb alc861_asus_a6rp_ch2_init[] = {<br>+       /* set pin widget 1Ah (line in) for input */<br>+       { 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },<br>+       /* set pin widget 18h (mic1/2) for input, for mic also enable the vref */
<br>+       { 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },<br>+<br>+       { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb00c },<br>+#if 0<br>+       { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 &lt;&lt; 8)) }, /*mic*/<br>+       { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x02 &lt;&lt; 8)) }, /*line-in*/
<br>+#endif<br>+       { } /* end */<br>+};<br>+/* Set mic1 nad line-in as output and mute mixer */<br>+static struct hda_verb alc861_asus_a6rp_ch6_init[] = {<br>+       /* set pin widget 1Ah (line in) for output (Back Surround)*/
<br>+       { 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },<br>+//     { 0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },<br>+       /* set pin widget 18h (mic1) for output (CLFE)*/<br>+       { 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
<br>+//     { 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },<br>+<br>+       { 0x0c, AC_VERB_SET_CONNECT_SEL, 0x00 },<br>+       { 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00 },<br>+<br>+       { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb080 },
<br>+//#if 0<br>+       { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x01 &lt;&lt; 8)) }, /*mic*/<br>+       { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x02 &lt;&lt; 8)) }, /*line in*/<br>+//#endif<br>+       { } /* end */
<br>+};<br>+<br>+static struct hda_channel_mode alc861_asus_a6rp_modes[2] = {<br>+       { 2, alc861_asus_a6rp_ch2_init },<br>+       { 6, alc861_asus_a6rp_ch6_init },<br>+};<br>+<br> /* patch-ALC861 */<br><br> static struct snd_kcontrol_new alc861_base_mixer[] = {
<br>@@ -6188,6 +6228,48 @@<br>        },<br>        { } /* end */<br> };<br>+<br>+static struct snd_kcontrol_new alc861_asus_a6rp_mixer[] = {<br>+        /* output mixer control */<br>+       HDA_CODEC_MUTE(&quot;Front Playback Switch&quot;, 0x03, 0x0, HDA_OUTPUT),
<br>+       HDA_CODEC_MUTE(&quot;Surround Playback Switch&quot;, 0x06, 0x0, HDA_OUTPUT),<br>+       HDA_CODEC_MUTE_MONO(&quot;Center Playback Switch&quot;, 0x05, 1, 0x0, HDA_OUTPUT),<br>+       HDA_CODEC_MUTE_MONO(&quot;LFE Playback Switch&quot;, 0x05, 2, 0x0, HDA_OUTPUT),
<br>+       /*HDA_CODEC_MUTE(&quot;Side Playback Switch&quot;, 0x04, 0x0, HDA_OUTPUT), */<br>+<br>+       /* Input mixer control */<br>+       /* HDA_CODEC_VOLUME(&quot;Input Playback Volume&quot;, 0x15, 0x0, HDA_OUTPUT),
<br>+          HDA_CODEC_MUTE(&quot;Input Playback Switch&quot;, 0x15, 0x0, HDA_OUTPUT), */<br>+       HDA_CODEC_VOLUME(&quot;CD Playback Volume&quot;, 0x15, 0x0, HDA_INPUT),<br>+       HDA_CODEC_MUTE(&quot;CD Playback Switch&quot;, 0x15, 0x0, HDA_INPUT),
<br>+       HDA_CODEC_VOLUME(&quot;Line Playback Volume&quot;, 0x15, 0x02, HDA_INPUT),<br>+       HDA_CODEC_MUTE(&quot;Line Playback Switch&quot;, 0x15, 0x02, HDA_INPUT),<br>+       HDA_CODEC_VOLUME(&quot;Mic Playback Volume&quot;, 0x15, 0x01, HDA_INPUT),
<br>+       HDA_CODEC_MUTE(&quot;Mic Playback Switch&quot;, 0x15, 0x01, HDA_INPUT),<br>+       HDA_CODEC_MUTE(&quot;Front Mic Playback Switch&quot;, 0x10, 0x01, HDA_OUTPUT),<br>+       HDA_CODEC_MUTE(&quot;Headphone Playback Switch&quot;, 0x1a, 0x03, HDA_OUTPUT), // was HDA_INPUT(?)
<br>+<br>+       /* Capture mixer control */<br>+       HDA_CODEC_VOLUME(&quot;Capture Volume&quot;, 0x08, 0x0, HDA_INPUT),<br>+       HDA_CODEC_MUTE(&quot;Capture Switch&quot;, 0x08, 0x0, HDA_INPUT),<br>+       {<br>+               .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
<br>+               .name = &quot;Capture Source&quot;,<br>+               .count = 1,<br>+               .info = alc_mux_enum_info,<br>+               .get = alc_mux_enum_get,<br>+               .put = alc_mux_enum_put,<br>
+       },<br>+       {<br>+               .iface = SNDRV_CTL_ELEM_IFACE_MIXER,<br>+               .name = &quot;Channel Mode&quot;,<br>+               .info = alc_ch_mode_info,<br>+               .get = alc_ch_mode_get,<br>
+               .put = alc_ch_mode_put,<br>+                .private_value = ARRAY_SIZE(alc861_asus_a6rp_modes),<br>+       },<br>+       { }<br>+};<br><br> /*<br>  * generic initialization of ADC, input mixers and output mixers
<br>@@ -6377,6 +6459,68 @@<br>        { }<br> };<br><br>+static struct hda_verb alc861_asus_a6rp_init_verbs[] = {<br>+       /*<br>+        * Unmute ADC0 and set the default input to mic-in<br>+        */<br>+       /* port-A for surround (rear panel) | according to&nbsp;my codec#0 this is the HP jack*/
<br>+       { 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0 }, // was 0x00<br>+       /* route front PCM to HP */<br>+       //{ 0x0e, AC_VERB_SET_CONNECT_SEL, 0x01 },<br>+       /* port-B for mic-in (rear panel) with vref */
<br>+       { 0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },<br>+       /* port-C for line-in (rear panel) */<br>+       { 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },<br>+       /* port-D for Front */<br>+       { 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40 },
<br>+       { 0x0b, AC_VERB_SET_CONNECT_SEL, 0x00 },<br>+       /* port-E for HP out (front panel) */<br>+       { 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 }, // this has to be set to VREF80<br>+       /* route front PCM to HP */
<br>+       { 0x0f, AC_VERB_SET_CONNECT_SEL, 0x01 },<br>+       /* port-F for mic-in (front panel) with vref */<br>+       { 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24 },<br>+       /* port-G for CLFE (rear panel) */<br>+       { 0x1f, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
<br>+       /* port-H for side (rear panel) */<br>+       { 0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },<br>+       /* CD-in */<br>+       { 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20 },<br>+       /* route front mic to ADC1*/
<br>+       {0x08, AC_VERB_SET_CONNECT_SEL, 0x00},<br>+       {0x08, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},<br>+       /* Unmute DAC0~3 &amp; spdif out*/<br>+       {0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
<br>+       {0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},<br>+       {0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},<br>+       {0x06, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},<br>+       {0x07, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
<br>+<br>+       /* Unmute Mixer 14 (mic) 1c (Line in)*/<br>+       {0x014, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},<br>+        {0x014, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},<br>+       {0x01c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
<br>+        {0x01c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},<br>+<br>+       /* Unmute Stereo Mixer 15 */<br>+       {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},<br>+       {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
<br>+       {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},<br>+       {0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0xb00c          }, //Output 0~12 step<br>+<br>+       {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},<br>+       {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
<br>+       {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},<br>+       {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},<br>+       {0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},<br>+       {0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
<br>+       {0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},<br>+       {0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},<br>+       {0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(3)}, // hp used DAC 3 (Front)<br>
+       {0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(2)},<br>+       { }<br>+};<br>+<br> /*<br>  * generic initialization of ADC, input mixers and output mixers<br>  */<br>@@ -6714,6 +6858,9 @@<br>        { .modelname = &quot;uniwill-m31&quot;, .config = ALC861_UNIWILL_M31},
<br>        { .pci_subvendor = 0x1584, .pci_subdevice = 0x9072,<br>          .config = ALC861_UNIWILL_M31 },<br>+       { .modelname = &quot;asus-a6rp&quot;, .config = ALC861_ASUS_A6RP},<br>+       { .pci_subvendor = 0x1043, .pci_subdevice = 0x1393,
<br>+         .config = ALC861_ASUS_A6RP },<br>        { .modelname = &quot;auto&quot;, .config = ALC861_AUTO },<br>        {}<br> };<br>@@ -6781,6 +6928,19 @@<br>                .adc_nids = alc861_adc_nids,<br>                .input_mux = &amp;alc861_capture_source,
<br>        },<br>+       [ALC861_ASUS_A6RP] = {<br>+               .mixers = { alc861_asus_a6rp_mixer },<br>+               .init_verbs = { alc861_asus_a6rp_init_verbs },<br>+               .num_dacs = ARRAY_SIZE(alc861_dac_nids),
<br>+               .dac_nids = alc861_dac_nids,<br>+               .dig_out_nid = ALC861_DIGOUT_NID,<br>+               .num_channel_mode = ARRAY_SIZE(alc861_asus_a6rp_modes),<br>+               .channel_mode = alc861_asus_a6rp_modes,
<br>+               .need_dac_fix = 1,<br>+               .num_adc_nids = ARRAY_SIZE(alc861_adc_nids),<br>+               .adc_nids = alc861_adc_nids,<br>+               .input_mux = &amp;alc861_capture_source,<br>+       },
<br><br> };<br></div></div><br>

------=_Part_36062_16247085.1159208750945--


--===============1643367830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1643367830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1643367830==--
