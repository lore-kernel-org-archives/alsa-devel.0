From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 14/31] HDA patch_via.c: Add Jack detect
	feature for VT1708.
Date: Tue, 6 Oct 2009 13:06:40 +0800
Message-ID: <16685ee0910052206ge80ec18yb0546282c4a9945f@mail.gmail.com>
References: <16685ee0910050727q4288fc76hdde23b431232d073@mail.gmail.com>
	<s5h7hv96fis.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id DDF84243AA
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 07:06:41 +0200 (CEST)
Received: by bwz25 with SMTP id 25so11508069bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 22:06:40 -0700 (PDT)
In-Reply-To: <s5h7hv96fis.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

VT1708 HW doesn't support unsolicited response, so we polling with jack
detect function instead.
As you describe, we implement it with self-reschedule workqueue, acting
like a timer.
Is there some advice to implement timer-like task, I tested  with timer and
it will crash the driver.

On Mon, Oct 5, 2009 at 11:12 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 5 Oct 2009 22:27:20 +0800,
> Li Bo wrote:
>>
>> [ALSA] HDA VIA: Add Jack detect feature for VT1708.
>
> Why is it needed? =A0Isn't the unsolicited event handled properly at
> HP plugging?
>
> Also, this implementation doesn't look good. =A0If I understand
> correctly, it invokes a workqueue which re-schedules itself at each
> 100ms...
>
>
> Takashi
>
>> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>>
>> Index: sound-2.6/sound/pci/hda/patch_via.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- sound-2.6.orig/sound/pci/hda/patch_via.c =A02009-10-05 15:10:22.0000=
00000 +0800
>> +++ sound-2.6/sound/pci/hda/patch_via.c =A0 =A0 =A0 2009-10-05 15:10:36.=
000000000 +0800
>> @@ -257,6 +257,11 @@
>> =A0 =A0 =A0 unsigned int smart51_enabled;
>> =A0 =A0 =A0 enum VIA_HDA_CODEC codec_type;
>>
>> + =A0 =A0 /* work to check hp jack state */
>> + =A0 =A0 struct hda_codec *codec;
>> + =A0 =A0 struct delayed_work hp_jack_work;
>> + =A0 =A0 int vt1708_jack_detectect;
>> +
>> =A0#ifdef CONFIG_SND_HDA_POWER_SAVE
>> =A0 =A0 =A0 struct hda_loopback_check loopback;
>> =A0#endif
>> @@ -966,6 +971,8 @@
>> =A0 =A0 =A0 {0x20, AC_VERB_SET_CONNECT_SEL, 0x1},
>> =A0 =A0 =A0 /* PW9 Output enable */
>> =A0 =A0 =A0 {0x25, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
>> + =A0 =A0 /* power down jack detect function */
>> + =A0 =A0 {0x1, 0xf81, 0x1},
>> =A0 =A0 =A0 { }
>> =A0};
>>
>> @@ -1340,6 +1347,10 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> =A0 =A0 =A0 via_free_kctls(codec);
>> + =A0 =A0 if (spec->codec_type =3D=3D VT1708) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&spec->hp_jack_work);
>> + =A0 =A0 =A0 =A0 =A0 =A0 flush_scheduled_work();
>> + =A0 =A0 }
>> =A0 =A0 =A0 kfree(codec->spec);
>> =A0}
>>
>> @@ -1724,6 +1735,52 @@
>> =A0 =A0 =A0 return;
>> =A0}
>>
>> +static int vt1708_jack_detectect_get(struct snd_kcontrol *kcontrol,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct snd_ctl_elem_value *ucontrol)
>> +{
>> + =A0 =A0 struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
>> + =A0 =A0 struct via_spec *spec =3D codec->spec;
>> +
>> + =A0 =A0 if (spec->codec_type !=3D VT1708)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 spec->vt1708_jack_detectect =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 !((snd_hda_codec_read(codec, 0x1, 0, 0xf84, 0)=
 >> 8) & 0x1);
>> + =A0 =A0 ucontrol->value.integer.value[0] =3D spec->vt1708_jack_detecte=
ct;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int vt1708_jack_detectect_put(struct snd_kcontrol *kcontrol,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct snd_ctl_elem_value *ucontrol)
>> +{
>> + =A0 =A0 struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
>> + =A0 =A0 struct via_spec *spec =3D codec->spec;
>> + =A0 =A0 int change;
>> +
>> + =A0 =A0 if (spec->codec_type !=3D VT1708)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 spec->vt1708_jack_detectect =3D ucontrol->value.integer.value[=
0];
>> + =A0 =A0 snd_hda_codec_write(codec, 0x1, 0, 0xf81, !spec->vt1708_jack_d=
etectect);
>> + =A0 =A0 change =3D (0x1 & (snd_hda_codec_read(codec, 0x1, 0, 0xf84, 0)=
 >> 8))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D !spec->vt1708_jack_detectect;
>> + =A0 =A0 if (spec->vt1708_jack_detectect) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mute_aa_path(codec, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 notify_aa_path_ctls(codec);
>> + =A0 =A0 }
>> + =A0 =A0 return change;
>> +}
>> +
>> +static struct snd_kcontrol_new vt1708_jack_detectect[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "Jack Detect",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .count =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .info =3D snd_ctl_boolean_mono_info,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .get =3D vt1708_jack_detectect_get,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .put =3D vt1708_jack_detectect_put,
>> + =A0 =A0 },
>> + =A0 =A0 {} /* end */
>> +};
>> +
>> =A0static int vt1708_parse_auto_config(struct hda_codec *codec)
>> =A0{
>> =A0 =A0 =A0 struct via_spec *spec =3D codec->spec;
>> @@ -1751,6 +1808,10 @@
>> =A0 =A0 =A0 err =3D vt1708_auto_create_analog_input_ctls(spec, &spec->au=
tocfg);
>> =A0 =A0 =A0 if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> + =A0 =A0 /* add jack detect on/off control */
>> + =A0 =A0 err =3D snd_hda_add_new_ctls(codec, vt1708_jack_detectect);
>> + =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>> =A0 =A0 =A0 spec->multiout.max_channels =3D spec->multiout.num_dacs * 2;
>>
>> @@ -1784,6 +1845,24 @@
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static void update_hp_jack_state(struct work_struct *work)
>> +{
>> + =A0 =A0 struct via_spec *spec =3D container_of(work, struct via_spec,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0hp_jack_work.work);
>> + =A0 =A0 static int present =3D 1;
>> +
>> + =A0 =A0 if (spec->codec_type !=3D VT1708)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 /* if jack state toggled */
>> + =A0 =A0 if (present
>> + =A0 =A0 =A0 =A0 !=3D (snd_hda_codec_read(spec->codec, spec->autocfg.hp=
_pins[0], 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AC_VERB=
_GET_PIN_SENSE, 0) >> 31)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 present ^=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 via_hp_automute(spec->codec);
>> + =A0 =A0 }
>> + =A0 =A0 schedule_delayed_work(&spec->hp_jack_work, msecs_to_jiffies(10=
0));
>> +}
>> +
>> =A0static int get_mux_nids(struct hda_codec *codec)
>> =A0{
>> =A0 =A0 =A0 struct via_spec *spec =3D codec->spec;
>> @@ -1860,7 +1939,9 @@
>> =A0#ifdef CONFIG_SND_HDA_POWER_SAVE
>> =A0 =A0 =A0 spec->loopback.amplist =3D vt1708_loopbacks;
>> =A0#endif
>> -
>> + =A0 =A0 spec->codec =3D codec;
>> + =A0 =A0 INIT_DELAYED_WORK(&spec->hp_jack_work, update_hp_jack_state);
>> + =A0 =A0 schedule_delayed_work(&spec->hp_jack_work, msecs_to_jiffies(10=
0));
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>
