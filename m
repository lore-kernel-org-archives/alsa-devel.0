From: Yao-Wen Mao <yaowen@google.com>
Subject: Re: [PATCH] sound/usb: add dB range mapping for some
	devices.
Date: Wed, 29 Jul 2015 15:59:12 +0800
Message-ID: <CAHjFKHxFD847JgTq-uhGRWXG=npkh-PzuCOgyGPEiEFZycYmFg@mail.gmail.com>
References: <1438154034-112595-1-git-send-email-yaowen@google.com>
 <s5hk2tje7vy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id BD2C026056B
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 09:59:13 +0200 (CEST)
Received: by lafd3 with SMTP id d3so1370801laf.1
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 00:59:13 -0700 (PDT)
In-Reply-To: <s5hk2tje7vy.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 29, 2015 at 3:32 PM, Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 29 Jul 2015 09:13:54 +0200,
> Yao-Wen Mao wrote:
> >
> > Add the correct dB ranges of Bose Companion 5 and Drangonfly DAC 1.2.
> >
> > Signed-off-by: Yao-Wen Mao <yaowen@google.com>
> > ---
> >  sound/usb/mixer_maps.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
> > index e5000da..f0c9e49 100644
> > --- a/sound/usb/mixer_maps.c
> > +++ b/sound/usb/mixer_maps.c
> > @@ -339,6 +339,19 @@ static struct usbmix_name_map gamecom780_map[] = {
> >  static const struct usbmix_name_map scms_usb3318_map[] = {
> >       { 10, NULL },
> >       { 0 }
>
> You seem to have dropped some lines here.
> At the next time, please at least do a build-test before submitting
> the patch.
>
> I applied it now with manual correction.  Thanks.


Sorry for that.
Thanks for applying this patch!

Yao-Wen


> Takashi
>
> > +
> > +/* Bose companion 5, the dB conversion factor is 16 instead of 256 */
> > +static struct usbmix_dB_map bose_companion5_dB = {-5006, -6};
> > +static struct usbmix_name_map bose_companion5_map[] = {
> > +     { 3, NULL, .dB = &bose_companion5_dB },
> > +     { 0 }   /* terminator */
> > +};
> > +
> > +/* Dragonfly DAC 1.2, the dB conversion factor is 1 instead of 256 */
> > +static struct usbmix_dB_map dragonfly_1_2_dB = {0, 5000};
> > +static struct usbmix_name_map dragonfly_1_2_map[] = {
> > +     { 7, NULL, .dB = &dragonfly_1_2_dB },
> > +     { 0 }   /* terminator */
> >  };
> >
> >  /*
> > @@ -451,6 +464,16 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
> >               .id = USB_ID(0x25c4, 0x0003),
> >               .map = scms_usb3318_map,
> >       },
> > +     {
> > +             /* Bose Companion 5 */
> > +             .id = USB_ID(0x05a7, 0x1020),
> > +             .map = bose_companion5_map,
> > +     },
> > +     {
> > +             /* Dragonfly DAC 1.2 */
> > +             .id = USB_ID(0x21b4, 0x0081),
> > +             .map = dragonfly_1_2_map,
> > +     },
> >       { 0 } /* terminator */
> >  };
> >
> > --
> > 2.5.0.rc2.392.g76e840b
> >
> >
>
