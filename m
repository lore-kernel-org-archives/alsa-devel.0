From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ALSA: usb-audio: Change structure initialisation to C99
 style
Date: Wed, 15 Jun 2016 15:31:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1606151530380.2887@hadrien>
References: <20160615132634.GA20438@amitoj-Inspiron-3542> <s5htwgupoky.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htwgupoky.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>, alsa-devel@alsa-project.org, perex@perex.cz, linux-kernel@vger.kernel.org, keescook@chromium.org, michael.leibowitz@intel.com
List-Id: alsa-devel@alsa-project.org



On Wed, 15 Jun 2016, Takashi Iwai wrote:

> On Wed, 15 Jun 2016 15:26:34 +0200,
> Amitoj Kaur Chawla wrote:
> >
> > Replace the in order struct initialisation style with explicit field
> > style.
> >
> > The Coccinelle semantic patch used to make this change is as follows:
> >
> > @decl@
> > identifier i1,fld;
> > type T;
> > field list[n] fs;
> > @@
> >
> > struct i1 {
> >  fs
> >  T fld;
> >  ...};
> >
> > @@
> > identifier decl.i1,i2,decl.fld;
> > expression e;
> > position bad.p, bad.fix;
> > @@
> >
> > struct i1 i2@p = { ...,
> > + .fld = e
> > - e@fix
> >  ,...};
> >
> > Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> > ---
> >  sound/usb/mixer_maps.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
> > index 1f8fb0d9..9038b2e 100644
> > --- a/sound/usb/mixer_maps.c
> > +++ b/sound/usb/mixer_maps.c
> > @@ -107,8 +107,10 @@ static struct usbmix_name_map extigy_map[] = {
> >   * e.g. no Master and fake PCM volume
> >   *			Pavel Mihaylov <bin@bash.info>
> >   */
> > -static struct usbmix_dB_map mp3plus_dB_1 = {-4781, 0};	/* just guess */
> > -static struct usbmix_dB_map mp3plus_dB_2 = {-1781, 618}; /* just guess */
> > +static struct usbmix_dB_map mp3plus_dB_1 = {.min = -4781, .max = 0};
> > +						/* just guess */
> > +static struct usbmix_dB_map mp3plus_dB_2 = {.min = -1781, .max = 618};
> > +						/* just guess */
>
> These are simple min/max table, so no big merit to write in such a
> way.

My understanding is that structures are going to be randomized, so at
least all global structures need C99 initialization.  Maybe Kees can
provide further clarification.

julia
