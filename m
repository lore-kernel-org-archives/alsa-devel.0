From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Thu, 24 Nov 2011 11:03:08 +0100
Message-ID: <jal4os$vs9$1@dough.gmane.org>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<jal29f$6dt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030209090700050303080304"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CB0B244C2
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:03:24 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RTW9K-0005TQ-0y
	for alsa-devel@alsa-project.org; Thu, 24 Nov 2011 11:03:22 +0100
Received: from 217-162-57-177.dynamic.hispeed.ch ([217.162.57.177])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:03:21 +0100
Received: from belegdol by 217-162-57-177.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:03:21 +0100
In-Reply-To: <jal29f$6dt$1@dough.gmane.org>
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

This is a multi-part message in MIME format.
--------------030209090700050303080304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

W dniu 24.11.2011 10:20, Julian Sikorski pisze:
> W dniu 20.08.2011 09:33, Andrew Mahone pisze:
>> This laptop is detected as ALC892 audio (and by the codec ID this
>> seems to be valid), but none of the configurations for it quite match
>> this device. I've been working on documenting the connections with HDA
>> Analyzer.
>>
>> alsa-info output:
>> http://www.alsa-project.org/db/?f=b86e4c6447867fbd129a36d8a63e2f5caa836c52
>>
>> The laptop has built-in 5.1, and 5.1 or 7.1 output via jacks.
>>
>> DAC NIDs:
>> 0x02 front
>> 0x03 rear
>> 0x04 clfe
>> 0x05 side
>>
>> internal mixers:
>> 0x0c front
>> 0x0d rear
>> 0x0e clfe
>> 0x0f side
>>
>> internal speaker pins:
>> 0x14 front
>> 0x15 "rear" (front of laptop)
>> 0x16 clfe
>>
>> external ports:
>> fixed route:
>> 0x17 side
>>
>> can select any output:
>> 0x18 mic / output
>> 0x1a line-in / output
>> 0x1b headphone
>>
>> I've been experimenting with patch_realtek.c to add the extra DAC NID,
>> and have had some success with a 6-channel mode for the built-in
>> speakers and an 8-channel mode that mutes all internal speakers and
>> sets the jacks up for output. I still need to manually connect pins
>> 0x18, 0x1a, 0x1b to the correct internal mixers for 7.1 to work, and
>> headphone plugin does not mute internal speakers in 5.1 mode. I have
>> not added a plain stereo mode for internal speakers, although it
>> appears that i can probably configure the codec to mix the front
>> channels to center and LFE.
>>
>> Are there any suggestions for what to do next? My current state as a
>> patch against the linux-3.0.y repository is at
>> http://pastie.org/2400649
>>
> I tried this patch (attached a version ported to 3.1.x kernel) with
> P150HM and I was still unable to get sound out of the subwoofer when on
> 6 channel mode, could nonexisting rear be interfering?

I tried a similar patch but also no luck there... Any ideas why the
subwoofer might not be working? Is there a way to somehow eavesdrop the
windows driver?

> As Andrew said, 8 channel mode works once you manually unmute and
> reattach mixers using hda-analyzer.
> 
> Regards,
> Julian
> 
> 
> 


--------------030209090700050303080304
Content-Type: text/x-patch;
 name="clevo-p150hm-quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="clevo-p150hm-quirk.patch"

--- vanilla-3.1/sound/pci/hda/alc662_quirks.c	2011-10-24 09:10:05.000000000 +0200
+++ linux-3.1.x86_64/sound/pci/hda/alc662_quirks.c	2011-11-24 08:29:00.443842837 +0100
@@ -29,15 +29,16 @@
 	ALC272_DELL,
 	ALC272_DELL_ZM1,
 	ALC272_SAMSUNG_NC10,
+	ALC892_CLEVO_P150HM,
 	ALC662_MODEL_LAST,
 };
 
 #define ALC662_DIGOUT_NID	0x06
 #define ALC662_DIGIN_NID	0x0a
 
-static const hda_nid_t alc662_dac_nids[3] = {
-	/* front, rear, clfe */
-	0x02, 0x03, 0x04
+static const hda_nid_t alc662_dac_nids[4] = {
+	/* front, rear, clfe, side */
+	0x02, 0x03, 0x04, 0x05
 };
 
 static const hda_nid_t alc272_dac_nids[2] = {
@@ -172,6 +173,39 @@
 	{ 6, alc662_sixstack_ch8_init },
 };
 
+/*
+ * 4ch mode
+ */
+static const struct hda_verb alc892_clevo_p150hm_ch4_init[] = {
+	{ 0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+	{ 0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+	{ 0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ } /* end */
+};
+
+/*
+ * 8ch mode
+ */
+static const struct hda_verb alc892_clevo_p150hm_ch8_init[] = {
+	{ 0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+	{ 0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+	{ 0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x00 },
+	{ 0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ } /* end */
+};
+
+static const struct hda_channel_mode alc892_clevo_p150hm_modes[2] = {
+	{ 4, alc892_clevo_p150hm_ch4_init },
+	{ 8, alc892_clevo_p150hm_ch8_init },
+};
+
 /* Pin assignment: Front=0x14, Rear=0x15, CLFE=0x16, Side=0x17
  *                 Mic=0x18, Front Mic=0x19, Line-In=0x1a, HP=0x1b
  */
@@ -547,6 +581,12 @@
 	{}
 };
 
+static const struct hda_verb alc892_clevo_p150hm_init_verbs[] = {
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC_MIC_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC_HP_EVENT},
+	{}
+};
+
 /* Set Unsolicited Event*/
 static const struct hda_verb alc662_eeepc_ep20_sue_init_verbs[] = {
 	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
@@ -987,6 +1027,7 @@
 	[ALC272_DELL]		= "dell",
 	[ALC272_DELL_ZM1]	= "dell-zm1",
 	[ALC272_SAMSUNG_NC10]	= "samsung-nc10",
+	[ALC892_CLEVO_P150HM]   = "clevo-p150hm",
 	[ALC662_AUTO]		= "auto",
 };
 
@@ -1403,6 +1444,18 @@
 		.setup = alc663_mode4_setup,
 		.init_hook = alc_inithook,
 	},
+	[ALC892_CLEVO_P150HM] = {
+		.mixers = { alc662_base_mixer, alc662_chmode_mixer },
+		.init_verbs = { alc662_init_verbs, alc662_eapd_init_verbs, alc892_clevo_p150hm_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc662_dac_nids),
+		.dac_nids = alc662_dac_nids,
+		.dig_out_nid = ALC662_DIGOUT_NID,
+		.dig_in_nid = ALC662_DIGIN_NID,
+		.num_channel_mode = ARRAY_SIZE(alc892_clevo_p150hm_modes),
+		.channel_mode = alc892_clevo_p150hm_modes,
+		.input_mux = &alc662_capture_source,
+		.init_hook = alc_inithook,
+	},
 };
 
 

--------------030209090700050303080304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030209090700050303080304--
