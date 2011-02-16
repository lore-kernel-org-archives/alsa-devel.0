From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-lib: snd_mixer_selem_is_active changes -
	which event?
Date: Wed, 16 Feb 2011 19:03:55 +0800
Message-ID: <AANLkTimctqH+Qy8GEsr2TWwqf_oo6UjwFLj-RQPLS-yf@mail.gmail.com>
References: <4D5ACED8.5030707@gmx.de>
	<4D5B8D23.2080107@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 54FAC244E4
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 12:03:59 +0100 (CET)
Received: by ewy19 with SMTP id 19so305237ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 03:03:56 -0800 (PST)
In-Reply-To: <4D5B8D23.2080107@ladisch.de>
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

2011/2/16 Clemens Ladisch <clemens@ladisch.de>

> Sebastian H. wrote:
> > I wonder which event mask notifies an application that
> > snd_mixer_selem_is_active() may have changed.
> >
> > SND_CTL_EVENT_MASK_VALUE
> > or
> > SND_CTL_EVENT_MASK_INFO
>
> _VALUE is only for the value itself; all metadata changes
> generate an _INFO event.
>
>
I have doubt about the implementation of alsamixer is different from the
driver

If I add the "Independent HP Switch" which switch the connection of node
0x37 from DAC0 to DAC 1 for ad1988 multi streaming playback model and
activate_ctl(codec, "Headphone Playback Volume", spec->independent_hp )

Both "Headphone Playback Volume" and "Headphone playback Switch" are greyed
( inactive) in alsamixer when the independent HP switch is off , but the
driver only deactivate the "Headphone Playback Volume".

When I toggle the "Independnent HP switch" on and off , the headphone
controls does not change from active to inactive and vice versa


For qasmixer , the "headphone playback volume" and "headphone playback
switch" are disappeared when the Indepdent HP switch is off




static int ad1988_independent_hp_info(struct snd_kcontrol *kcontrol,
                   struct snd_ctl_elem_info *uinfo)
{
    uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
    uinfo->count = 1;
    uinfo->value.integer.min = 0;
    uinfo->value.integer.max = 1;
    return 0;
}

static int ad1988_independent_hp_get(struct snd_kcontrol *kcontrol,
                  struct snd_ctl_elem_value *ucontrol)
{
    struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
    struct ad198x_spec *spec = codec->spec;
    *ucontrol->value.integer.value = spec->independent_hp;
    return 0;
}

static void activate_ctl(struct hda_codec *codec, const char *name, int
active)
{
    struct snd_kcontrol *ctl = snd_hda_find_mixer_ctl(codec, name);
    if (ctl) {
        ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
        ctl->vd[0].access |= active
            ? 0 : SNDRV_CTL_ELEM_ACCESS_INACTIVE;
        snd_ctl_notify(codec->bus->card,
                   SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
    }
}

static int ad1988_independent_hp_put(struct snd_kcontrol *kcontrol,
                  struct snd_ctl_elem_value *ucontrol)
{
    struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
    struct ad198x_spec *spec = codec->spec;
    activate_ctl(codec, "Headphone Playback Volume",
            *ucontrol->value.integer.value);
    if ( spec->independent_hp !=  *ucontrol->value.integer.value ) {
            spec->independent_hp =  *ucontrol->value.integer.value;
        snd_hda_codec_write(codec, 0x37, 0, AC_VERB_SET_CONNECT_SEL,
            spec->independent_hp ? 0x00 : 0x01 );
        return 1;
    }
    return 0;
}


static struct snd_kcontrol_new ad1988_6stack_fp_mixers[] = {
    HDA_CODEC_VOLUME("Headphone Playback Volume", 0x03, 0x0, HDA_OUTPUT),
    {
        .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
        .name = "Independent HP",
        .info = ad1988_independent_hp_info,
        .get = ad1988_independent_hp_get,
        .put = ad1988_independent_hp_put,
    },
    { } /* end */
};
