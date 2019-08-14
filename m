From: =?UTF-8?B?5b2t6L6J?= <benquike@gmail.com>
Subject: Re: [PATCH] Fix an OOB bug in parse_audio_mixer_unit
Date: Wed, 14 Aug 2019 12:28:39 -0400
Message-ID: <CAKpmkkUv=arsdJiexaM-UVhXEwfGN=zreny9P_kDNhQUij8=FQ@mail.gmail.com>
References: <20190814023625.21683-1-benquike@gmail.com>
 <s5hzhkcb6dh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71EA2F8015A
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 18:28:52 +0200 (CEST)
Received: by mail-oi1-x244.google.com with SMTP id p124so4582392oig.5
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2019 09:28:52 -0700 (PDT)
In-Reply-To: <s5hzhkcb6dh.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mathias Payer <mathias.payer@nebelwelt.net>, security@kernel.org, Wenwen Wang <wang6495@umn.edu>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
List-Id: alsa-devel@alsa-project.org

Hi, Takashi:
Here the problem is that `desc->bLength` is controlled by the device side,
so  `desc->bLength` may not represent the real length of the descriptor.
That is why I use pointer arithmetic operations to derive the real size of
the buffer
in my patch.

On Wed, Aug 14, 2019 at 2:36 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 14 Aug 2019 04:36:24 +0200,
> Hui Peng wrote:
> >
> > The `uac_mixer_unit_descriptor` shown as below is read from the
> > device side. In `parse_audio_mixer_unit`, `baSourceID` field is
> > accessed from index 0 to `bNrInPins` - 1, the current implementation
> > assumes that descriptor is always valid (the length  of descriptor
> > is no shorter than 5 + `bNrInPins`). If a descriptor read from
> > the device side is invalid, it may trigger out-of-bound memory
> > access.
> >
> > ```
> > struct uac_mixer_unit_descriptor {
> >       __u8 bLength;
> >       __u8 bDescriptorType;
> >       __u8 bDescriptorSubtype;
> >       __u8 bUnitID;
> >       __u8 bNrInPins;
> >       __u8 baSourceID[];
> > }
> > ```
> >
> > This patch fixes the bug by add a sanity check on the length of
> > the descriptor.
> >
> > Signed-off-by: Hui Peng <benquike@gmail.com>
> > Reported-by: Hui Peng <benquike@gmail.com>
> > Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
> > ---
> >  sound/usb/mixer.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 7498b5191b68..38202ce67237 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -2091,6 +2091,15 @@ static int parse_audio_mixer_unit(struct
> mixer_build *state, int unitid,
> >       struct usb_audio_term iterm;
> >       int input_pins, num_ins, num_outs;
> >       int pin, ich, err;
> > +     int desc_len = (int) ((unsigned long) state->buffer +
> > +                     state->buflen - (unsigned long) raw_desc);
> > +
> > +     if (desc_len < sizeof(*desc) + desc->bNrInPins) {
> > +             usb_audio_err(state->chip,
> > +                           "descriptor %d too short\n",
> > +                           unitid);
> > +             return -EINVAL;
> > +     }
> >
> >       err = uac_mixer_unit_get_channels(state, desc);
> >       if (err < 0) {
>
> Hm, what is the desc->bLength value in the error case?
>
> Basically the buffer boundary is already checked against bLength in
> snd_usb_find_desc() which is called from obtaining the raw_desc in the
> caller of this function (parse_audio_unit()).
>
> So, if any, we need to check bLength for the possible overflow like
> below.
>
>
> thanks,
>
> Takashi
>
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -744,6 +744,8 @@ static int uac_mixer_unit_get_channels(struct
> mixer_build *state,
>                 return -EINVAL;
>         if (!desc->bNrInPins)
>                 return -EINVAL;
> +       if (desc->bLength < sizeof(*desc) + desc->bNrInPins)
> +               return -EINVAL;
>
>         switch (state->mixer->protocol) {
>         case UAC_VERSION_1:
>


-- 
May the *Lord* Richly Bless you and yours !
