From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] HDA - add "Independent HP" switch for
	ad1988
Date: Thu, 22 Sep 2011 10:32:24 +0800
Message-ID: <CAN8cciaJz-Q_KpPGpXtLBU2myecADrBU=gwUGg0f8SN6TgyAng@mail.gmail.com>
References: <CAN8cciYWVwcCnrGjgn3Vrvoxd+j6GrKXNRzoqDMAExKMo5_+_Q@mail.gmail.com>
	<s5h1uvaz3l8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BA9B610381B
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 04:32:25 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2449039fxe.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2011 19:32:24 -0700 (PDT)
In-Reply-To: <s5h1uvaz3l8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/21 Takashi Iwai <tiwai@suse.de>:
> At Sun, 18 Sep 2011 07:18:28 +0800,
> Raymond Yau wrote:
>>
>> Add "Independent HP" switch for ad1988
>>
>> - add playback device 2 "AD1988 HP" for 7.1+2 multi streaming playback
>> - add "Independent HP" switch to enable/disable the feature
>> =A0 switch is inactive and write protect when device 0 or device 2 is op=
ened
>> - remove 6stack-dig-fp model
>
> Any rationale to remove this model?
> I'm fine with the removal, but need to know the reason.
>

After the previous patch

"Add Headphone Playback Volume" for ad1988
-use DAC0 instead of DAC1 for Port -A headphone

All models already have a "Headphone Playback Volume" control by using
DAC0 node 0x3 instead of sharing DAC1 node 0x4 (HDA_FRONT) with Port B
- green jack

int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
				     struct hda_multi_out *mout,
				     unsigned int stream_tag,
				     unsigned int format,
				     struct snd_pcm_substream *substream)
	if (!mout->no_share_stream &&
	    mout->hp_nid && mout->hp_nid !=3D nids[HDA_FRONT])
		/* headphone out will just decode front left/right (stereo) */
		snd_hda_codec_setup_stream(codec, mout->hp_nid, stream_tag,
					   0, format);

In this patch,  playback device 2 (AD198x Headphone) is added to all
models of ad1988/ad1989  so there is no need to keep the model
"6stack-dig-fp"

Especially when hda reconfig is still "experiemental"

The drawback of using hda reconfig or rmmod/insmod to change the model are
1) require root privilege
2) the volume level of the controls are re-initialised by init verbs
of the model

I don't like "6stack-dig-fp" model because "6stack-dig" create a
digital input device which is not present in my motherboard.


> Also, regarding the patch:
>
>> @@ -302,6 +304,71 @@ static int ad198x_check_power_status(struct hda_cod=
ec *codec, hda_nid_t nid)
>> =A0}
>> =A0#endif
>>
>> +static void activate_ctl(struct hda_codec *codec, const char *name, int=
 active)
>> +{
>> + =A0 =A0 struct snd_kcontrol *ctl =3D snd_hda_find_mixer_ctl(codec, nam=
e);
>> + =A0 =A0 if (ctl) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctl->vd[0].access &=3D ~SNDRV_CTL_ELEM_ACCESS_=
INACTIVE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctl->vd[0].access |=3D active ? 0:SNDRV_CTL_EL=
EM_ACCESS_INACTIVE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctl->vd[0].access &=3D ~SNDRV_CTL_ELEM_=
ACCESS_WRITE;
>
> Please use tabs.

OK

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctl->vd[0].access |=3D active ? SNDRV_CTL_ELEM=
_ACCESS_WRITE:0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_ctl_notify(codec->bus->card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV_CTL_EVENT=
_MASK_INFO, &ctl->id);
>> + =A0 =A0 }
>> +}
>> +
>> + static void set_stream_active(struct hda_codec *codec, bool active)
>> +{
>> + =A0 =A0 struct ad198x_spec *spec =3D codec->spec;
>> + =A0 =A0 if (active)
>> + =A0 =A0 =A0 =A0 =A0 =A0 spec->num_active_streams++;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 spec->num_active_streams--;
>> + =A0 =A0 activate_ctl(codec, "Independent HP", spec->num_active_streams=
 =3D=3D 0);
>> + =A0 =A0 printk(KERN_INFO "set stream active : active stream =A0%d \n",=
 spec->num_active_streams);
>
> Avoid debug prints in the final code.
> If any, use snd_printdd() or such.
>

I will remove this statement as I already know  the cause of  codec
cleanup function is called twice even in non sticky pcm mode

>> +}
> +
> +static int ad1988_independent_hp_info(struct snd_kcontrol *kcontrol,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct snd_ctl_elem_info *uinfo)
> +{
> + =A0 =A0 =A0 static const char * const texts[] =3D { "OFF", "ON", NULL};
> + =A0 =A0 =A0 int index;
> + =A0 =A0 =A0 uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
> + =A0 =A0 =A0 uinfo->count =3D 1;
> + =A0 =A0 =A0 uinfo->value.enumerated.items =3D 2;
> + =A0 =A0 =A0 index =3D uinfo->value.enumerated.item;
> + =A0 =A0 =A0 if (index >=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D 1;
> + =A0 =A0 =A0 strcpy(uinfo->value.enumerated.name, texts[index]);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int ad1988_independent_hp_get(struct snd_kcontrol *kcontrol,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
snd_ctl_elem_value *ucontrol)
> +{
> + =A0 =A0 =A0 struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> + =A0 =A0 =A0 struct ad198x_spec *spec =3D codec->spec;
> + =A0 =A0 =A0 ucontrol->value.enumerated.item[0] =3D spec->independent_hp;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int ad1988_independent_hp_put(struct snd_kcontrol *kcontrol,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
snd_ctl_elem_value *ucontrol)
> +{
> + =A0 =A0 =A0 struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> + =A0 =A0 =A0 struct ad198x_spec *spec =3D codec->spec;
> + =A0 =A0 =A0 unsigned int select =3D ucontrol->value.enumerated.item[0];
> + =A0 =A0 =A0 if (spec->independent_hp !=3D select) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->independent_hp =3D select;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spec->independent_hp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.hp_nid =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.hp_nid =3D s=
pec->alt_dac_nid[0];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
>
> Changing spec->multiout.hp_nid dynamically here is racy. =A0If the value
> is changed during the PCM stream is opened, the HP-setup might be kept
> inconsistent at close.
>

Do you mean set_stream_active() check in ad198x_playback_pcm_open(),
ad1988_alt_playback_pcm_open() , ad198x_playback_pcm_close() and
ad1988_alt_playback_pcm_close()

  ctl->vd[0].access &=3D ~SNDRV_CTL_ELEM_ACCESS_WRITE;

still not enough to protect the value of the control

This write protect should protect change of value by amixer since
amixer does not check whether the control is inactive when update the
control


The alternative is to implement a new variable in hda_codec.to control
the setup_stream and cleanup_stream of headphone dac

The "Independent HP" switch is similar to "IEC958 Default PCM" , which
use node 0x02 and device 1

9a08160bdbe3148a405f72798f76e2a5d30bd243

 Tue, 12 Feb 2008 17:37:26 +0000 (18:37 +0100)
[ALSA] hda-codec - Add "IEC958 Default PCM" switch

Added a new mixer switch to enable/disable the sharing of the default
PCM stream with analog and SPDIF outputs.  When "IEC958 Default PCM"
switch is on, the PCM stream is routed both to analog and SPDIF outputs.
This is the behavior in the earlier version.

Turning this switch off has a merit for some codecs, though.  Some codec
chips don't support 24bit formats for SPDIF but only for analog outputs.
In this case, you can use 24bit format by disabling this switch.
