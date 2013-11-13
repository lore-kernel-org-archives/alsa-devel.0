From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v2] ALSA: usb-audio: add front jack channel
	selector for EMU0204
Date: Wed, 13 Nov 2013 12:54:27 +0300
Message-ID: <CA+E=qVfpLEprvr01pJY6jFxV+AufpD+EYbRnbnsfC2y7g3PJAQ@mail.gmail.com>
References: <1384335140-4834-1-git-send-email-anarsoul@gmail.com>
 <s5h38n0d4j0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C7F926084B
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 10:54:48 +0100 (CET)
Received: by mail-ob0-f170.google.com with SMTP id gq1so164655obb.1
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 01:54:48 -0800 (PST)
In-Reply-To: <s5h38n0d4j0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Yury Bushmelev <jay@jay-tech.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 13, 2013 at 12:39 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed, 13 Nov 2013 12:32:20 +0300,
> Vasily Khoruzhick wrote:
> >
> > Add support for front jack channel selector which is present on EMU0204.
> > It allows to get 4 channels out of this soundcard.
> >
> > Tested-by: Yury Bushmelev <jay@jay-tech.ru>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > v2: - pass constants for bRequest and bRequestType into snd_usb_ctl_msg()
> >     - implement control as an enum instead of a switch.
> >
> >  sound/usb/mixer_quirks.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >
> > diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> > index d42a584..83f8ab1 100644
> > --- a/sound/usb/mixer_quirks.c
> > +++ b/sound/usb/mixer_quirks.c
> > @@ -433,6 +433,86 @@ static void snd_audigy2nx_proc_read(struct snd_info_entry *entry,
> >       }
> >  }
> >
> > +/* EMU0204 */
> > +static int snd_emu0204_ch_switch_info(struct snd_kcontrol *kcontrol,
> > +                                   struct snd_ctl_elem_info *uinfo)
> > +{
> > +     static const char *texts[4] = {"1/2",
> > +                                    "3/4"
> > +     };
>
> The declared array size doesn't match.
>

Oh, sorry, my fault, will resend in few minutes.

>
>
> Takashi
>
> > +
> > +     uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
> > +     uinfo->count = 1;
> > +     uinfo->value.enumerated.items = 2;
> > +     if (uinfo->value.enumerated.item > 1)
> > +             uinfo->value.enumerated.item = 1;
> > +     strcpy(uinfo->value.enumerated.name,
> > +             texts[uinfo->value.enumerated.item]);
> > +
> > +     return 0;
> > +}
> > +
> > +static int snd_emu0204_ch_switch_get(struct snd_kcontrol *kcontrol,
> > +                                  struct snd_ctl_elem_value *ucontrol)
> > +{
> > +     ucontrol->value.enumerated.item[0] = kcontrol->private_value;
> > +     return 0;
> > +}
> > +
> > +static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
> > +                                  struct snd_ctl_elem_value *ucontrol)
> > +{
> > +     struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
> > +     int value = ucontrol->value.enumerated.item[0];
> > +     int err, changed;
> > +     unsigned char buf[2];
>
> Better to have a sanity check of the value.  User-space can pass any
> value in theory.
>

And return -EINVAL on non-valid values? OK

>
>
> thanks,
>
> Takashi


Regards
Vasily
