From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 3/3] M-Audio FTU: Add effect controls
Date: Mon, 23 Apr 2012 12:19:39 +0200
Message-ID: <CAFz=ag7Bk-g8wezAr59Nb17UJSLBPaCEH_87R6yAdvJj60XeSw@mail.gmail.com>
References: <1335172568-13502-1-git-send-email-linuxaudio@showlabor.de>
	<1335172568-13502-4-git-send-email-linuxaudio@showlabor.de>
	<s5hty0a22sr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hty0a22sr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, mark@pogo.org.uk
List-Id: alsa-devel@alsa-project.org

Hi,

2012/4/23 Takashi Iwai <tiwai@suse.de>:
> At Mon, 23 Apr 2012 11:16:08 +0200,
> Felix Homann wrote:
>>
>>
>> Signed-off-by: Felix Homann <linuxaudio@showlabor.de>
>
> Again, a bit more explanations please.
>
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 596744f..be46657 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -775,6 +775,24 @@ static void volume_control_quirks(struct usb_mixer_=
elem_info *cval,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct s=
nd_kcontrol *kctl)
>> =A0{
>> =A0 =A0 =A0 switch (cval->mixer->chip->usb_id) {
>> + =A0 =A0 case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
>> + =A0 =A0 case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((strcmp(kctl->id.name, "Effect Duration") =
=3D=3D 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_INFO
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "set quirk for=
 FTU Effect Duration\n");
>
> Put a prefix in the info print to be identified properly.
> snd_printk() might be just printk() when CONFIG_SND_VERBOSE_PRINTK
> isn't set.

Hmm, again I just followed the examples of other volume quirks. What
kind of prefix would you like?

>
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval->min =3D 0x0000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval->max =3D 0x7f00;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cval->res =3D 0x0100;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((strcmp(kctl->id.name, "Effect Volume") =
=3D=3D 0) |
>
> Use the logical OR '||'.

Oh yes, stupid me...

> Also the parenthesis is superfluous.

I know. I put them there because checkpatch.pl complained. What's the
right way to cope with checkpatch.pl complains then?


>>
>> =A0/* M-Audio FastTrack Ultra quirks */
>>
>> +/* FTU Effect switch */
>> +struct snd_maudio_ftu_effect_switch_private_value {
>
> Well... The length of a name is a matter of taste, but it looks
> unnecessarily too long to me, as it appears in the casts.

It's not to my taste either. But it's in line with the existing ftu
quirks. I'm already preparing a patch for the M-Audio C-400 mixer.
What do you think of

* renaming the FTU specifiy functions from snd_maudio_ftu_* to snd_ftu_*
* renaming functions common to different M-Audio devices to snd_maudio_*
* specifically renaming snd_maudio_ftu_effect_switch_private_value to
snd_maudio_effect_switch_priv_val (well, it's just a bit shorter...)



>> + =A0 =A0 mixer =3D (struct usb_mixer_interface *) pval->mixer;
>> + =A0 =A0 if (mixer =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_printd(KERN_ERR "mixer =3D=3D NULL");
>
> Use snd_BUG_ON() in such a case.

What's that?


>> +static int snd_maudio_ftu_create_effect_switch(struct usb_mixer_interfa=
ce *mixer)
>> +{
>> + =A0 =A0 struct snd_kcontrol_new template =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "Effect Program Switch",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .index =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .info =3D snd_maudio_ftu_effect_switch_info,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .get =3D snd_maudio_ftu_effect_switch_get,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .put =3D snd_maudio_ftu_effect_switch_put
>> + =A0 =A0 };
>
> Use static.

OK.


>> +static int snd_maudio_ftu_create_effect_volume_ctl(struct usb_mixer_int=
erface *mixer)
>> +{
>> + =A0 =A0 unsigned int id, control, cmask;
>> + =A0 =A0 int val_type;
>> +
>> + =A0 =A0 char name[] =3D "Effect Volume";
>
> Use static.

OK.

>
>> +
>> + =A0 =A0 id =3D 6;
>> + =A0 =A0 val_type =3D USB_MIXER_U8;
>> + =A0 =A0 control =3D 2;
>> + =A0 =A0 cmask =3D 0;
>
> Use const.

OK.

>> +static int snd_maudio_ftu_create_effect_duration_ctl(struct usb_mixer_i=
nterface *mixer)
>> +{
>> + =A0 =A0 unsigned int id, control, cmask;
>> + =A0 =A0 int val_type;
>> +
>> + =A0 =A0 char name[] =3D "Effect Duration";
>> +
>> + =A0 =A0 id =3D 6;
>> + =A0 =A0 val_type =3D USB_MIXER_S16;
>> + =A0 =A0 control =3D 3;
>> + =A0 =A0 cmask =3D 0;
>
> Use const.

OK.


>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Input A Captu=
re Volume", NULL);
>> + =A0 =A0 snd_create_std_mono_ctl(mixer, 10, 2, 0x2, USB_MIXER_S16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Input B Captu=
re Volume", NULL);
>
> These should have been applied in the first patch.

OK. I wasn't aware of the extremely reasonable policy of not breaking
the build with a patch...

Sorry,

Felix
