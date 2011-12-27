From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] hda - is_jack_detectable()
Date: Tue, 27 Dec 2011 09:45:13 +0800
Message-ID: <CAN8ccibh75HN0Des_4Vx7ozhsZsqqiFM7p2=oWRtQr-iXe0qYQ@mail.gmail.com>
References: <CAN8cciZ4z5Jx9oHxoSt2K=NoOsOVMFjmaZjxPCXSDD05J5NdVA@mail.gmail.com>
	<CAN8ccia3XSQ0TxD2CqH7bSv=stf4Z8qbdeo=sOt_NUZ5+GNM=w@mail.gmail.com>
	<4EB05EA1.1060701@canonical.com> <s5hy5vzknvk.wl%tiwai@suse.de>
	<CAN8cciZYTq7MCu18nF6ovJa9Km61HUjyBiRfFP3E4gp60i0yhA@mail.gmail.com>
	<s5h8vntl7ix.wl%tiwai@suse.de>
	<CAN8cciacfUwDh4+oK7sBnRDhyoh-rLrFxYnnZUHnNiZxn1P3Yw@mail.gmail.com>
	<s5hy5vplqn2.wl%tiwai@suse.de> <s5hpqh1lopc.wl%tiwai@suse.de>
	<CAN8ccibAoNQfDNWJ-zE_DGH6mc-ipmmdhBDQW+fjOMT8xHcD+Q@mail.gmail.com>
	<s5h4ny76naa.wl%tiwai@suse.de>
	<CAN8cciYT=tvXVzCyMjEpf=FKMA0OqTvqxtgEkEPJwbGfxH+hBA@mail.gmail.com>
	<s5hr516lqw8.wl%tiwai@suse.de>
	<CAN8cciaeA72ku+s1WWC3aJ21sXEV3B=yDDpZF2X7VXK+mUO6VA@mail.gmail.com>
	<s5hhb0rod01.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E4CAD2455C
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 02:45:16 +0100 (CET)
Received: by wibhm4 with SMTP id hm4so4894754wib.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 17:45:14 -0800 (PST)
In-Reply-To: <s5hhb0rod01.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/12/23, Takashi Iwai <tiwai@suse.de>:
> At Fri, 23 Dec 2011 10:37:15 +0800,
> Raymond Yau wrote:
>>
>>
>> How can I add the new hda-jack detect to patch_analog.c ?
>>
>> Only ad1988 use  snd_hda_parse_pin_def_config() to parse the pin,
>> other ad198x codecs are used model since snd_hda_jack_add_ctls()
>> require those pin info from autocfg
>
> Not necessarily.  You can call snd_hda_jack_add_kctl() and enable the
> pin-detection via snd_hda_jack_detect_enable() directly.
>
>> The auto model of ad1988 use init_verbs ad1988_6stack_init which
>> cannot handle those 3 stack motherboard asus m2n
>>
>> What is the reason to call snd_hda_jack_report_sync() at the end of
>> unsol event handler ?
>
> To notify the jack-detection.
>


It seem that I need to add jack->dirty = 1 in ad1988_unsol_event to
force snd_hda_jack_detect() to call read_pin_sense() since
jack->jack_detect is set when calling snd_hda_jack_detect_enable()

Using snd_hda_jack_detect_enable(codec, pin, pin) instead of
snd_hda_jack_detect_enable(codec, pin, HP_EVENT) simiar to hdmi so
that all the detectable pins are assigned different tag

+static void ad1988_hp_automute(struct hda_codec *codec)
+{
+	int i, present;
+	struct ad198x_spec *spec = codec->spec;
+			
+	present = snd_hda_jack_detect(codec, 0x11);
+	if (spec->independent_hp)
+		return;
+	for (i=0; i < spec->multiout.num_dacs; i++)
+		snd_hda_codec_write(codec, spec->autocfg.line_out_pins[i],
+				0, AC_VERB_SET_AMP_GAIN_MUTE,
+				present ? AMP_OUT_MUTE : AMP_OUT_UNMUTE);		
+	
+	if (spec->autocfg.mono_out_pin)
+		snd_hda_codec_write(codec, spec->autocfg.mono_out_pin,
+			0, AC_VERB_SET_AMP_GAIN_MUTE,
+			present ? AMP_OUT_MUTE : AMP_OUT_UNMUTE);
+
+	for (i=0; i < spec->autocfg.speaker_outs; i++) {
+		snd_hda_codec_write(codec, spec->autocfg.speaker_pins[i],
+			0, AC_VERB_SET_AMP_GAIN_MUTE,
+			present ? AMP_OUT_MUTE : AMP_OUT_UNMUTE);
+	}
+}
+
+static void ad1988_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	struct hda_jack_tbl *jack = snd_hda_jack_tbl_get_from_tag(codec, res >> 26);
+	struct ad198x_spec *spec = codec->spec;
+	jack->jack_dirty = 1;
+	if (jack->nid == spec->autocfg.hp_pins[0])
+		ad1988_hp_automute(codec);
+	snd_hda_jack_report_sync(codec);
+}
+
+#define check_jack_detect(c, p) if (is_jack_detectable(c, p))
snd_hda_jack_detect_enable(c, p, p)
+
+void ad1988_auto_init_unsol_event(struct hda_codec *codec)
+{
+	int i;
+	struct ad198x_spec *spec = codec->spec;
+	check_jack_detect(codec, spec->autocfg.hp_pins[0]);
+	for (i=0; i<spec->autocfg.line_outs; i++)
+		check_jack_detect(codec, spec->autocfg.line_out_pins[0]);
+	for (i=0; i<spec->autocfg.num_inputs; i++)
+		check_jack_detect(codec, spec->autocfg.inputs[i].pin);
+	snd_hda_jack_add_kctls(codec, &spec->autocfg);
+	snd_hda_jack_report_sync(codec);
+}

static int ad1988_auto_init(struct hda_codec *codec)
{
	ad198x_init(codec);
	ad1988_auto_init_multi_out(codec);
	ad1988_auto_init_extra_out(codec);
	ad1988_auto_init_analog_input(codec);
+	ad1988_auto_init_unsol_event(codec);
	return 0;
}



	codec->patch_ops = ad198x_patch_ops;
	switch (board_config) {
	case AD1988_AUTO:
		codec->patch_ops.init = ad1988_auto_init;
+		codec->patch_ops.unsol_event = ad1988_unsol_event;
		break;
