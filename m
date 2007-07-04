From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: Re: [HDA Intel/STAC92xx] mic not working
	(retasking?)...
Date: Thu, 5 Jul 2007 00:19:53 +0100
Message-ID: <6278d2220707041619x3f43510fud3009844874df603@mail.gmail.com>
References: <6278d2220706271328u79afd988r44cc1fbfc41c6014@mail.gmail.com>
	<s5hved6z75l.wl%tiwai@suse.de>
	<6278d2220706301407p739ebfb5i52d4a2af3a17ecd8@mail.gmail.com>
	<s5habuec264.wl%tiwai@suse.de>
	<6278d2220707021539g1485af71v3cbb639f0844b271@mail.gmail.com>
	<s5h3b057u8d.wl%tiwai@suse.de>
	<6278d2220707031612i1c129969ga9c0d5d77b7c73db@mail.gmail.com>
	<s5h8x9w8hp5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AC28244FC
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 01:20:00 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so380452ugf
	for <alsa-devel@alsa-project.org>; Wed, 04 Jul 2007 16:19:59 -0700 (PDT)
In-Reply-To: <s5h8x9w8hp5.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Daniel J Blueman wrote:
> > > > > > > > With both 2.6.20 and 2.6.22 kernels on Ubuntu 7.04 on my Sony Vaio
> > > > > > > > SZ240, I'm unable to get my mic connector working at any cost.
> > > > > > >
> > > > > > > First, show the contents of /proc/asound/card0/codec#* files...
> > [snip]
> > > > I have discovered the bug preventing me using the external mic socket
> > > > before: in the mixer, the user has to select the [internal] mic input,
> > > > then re-select the line-in (actually external mic) input; reading from
> > > > (eg) /dev/dsp while changing this, the output suddenly is as expected
> > > > when the line-in is re-selected.
> > >
> > > Could you elaborate?  What do yo mean "output" here, and what did you
> > > expect?
> >
> > Looking at what is printed from the command 'cat /dev/dsp', what is
> > shown changes when I de-select 'line-in' and then reselect it. Let me
> > know if you're still unclear.
> >
> > > > Since we've got started, where should I look for the 'before' and
> > > > 'after' state to compare to see into this?
> > >
> > > Yes, comparing the codec dump file would be helpful.
> >
> > Changing from the initial mixer state of 'Line-in' being selected to
> > 'Microphone' does not change anything in the
> > /proc/asound/card0/codec#{0,1} files. After, changing the input back
> > to 'Line-in' does show a change [1] (which we'd expect).
> >
> > My interpretation of this is that (in the initial state) the STAC
> > registers are set to record from the internal mic (which doesn't
> > actually exist; there is a tiny amount of crosstalk) and the mixer
> > settings ALSA reports show the line-in/external mic selected [2].
>
> The problem sounds like a mismatch of initialization verb and the
> internal mixer state.  If it's the case, the patch below should fix,
> then.

This does indeed squarely address the problem I was having, and is a
good fix here!

The 'Line in' and 'Mic' inputs are a little confusing still. Do you
think it's worth having 'Line/Mic in' or just 'External'?

As there is no internal mic on this model the 'Mic' input is the
opposite of what needs selecting. Is there any way we can address this
at the same too? Perhaps 'Int mic' or similar would clarify it.

Thank you again for your support and I hope your patch makes it to
mainline soon,
   Daniel

> diff -r 523aa7d0e49d pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c  Wed Jul 04 10:35:29 2007 +0200
> +++ b/pci/hda/patch_sigmatel.c  Wed Jul 04 14:38:39 2007 +0200
> @@ -2337,7 +2337,7 @@ static struct hda_verb vaio_init[] = {
>         {0x0d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 }, /* Mic? (<- 0x2) */
>         {0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN }, /* CD */
>         {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 }, /* Mic? */
> -       {0x15, AC_VERB_SET_CONNECT_SEL, 0x2}, /* mic-sel: 0a,0d,14,02 */
> +       {0x15, AC_VERB_SET_CONNECT_SEL, 0x1}, /* mic-sel: 0a,0d,14,02 */
>         {0x02, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE}, /* HP */
>         {0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE}, /* Speaker */
>         {0x09, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)}, /* capture sw/vol -> 0x8 */
> @@ -2353,7 +2353,7 @@ static struct hda_verb vaio_ar_init[] =
>         {0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN }, /* CD */
>  /*     {0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },*/ /* Optical Out */
>         {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 }, /* Mic? */
> -       {0x15, AC_VERB_SET_CONNECT_SEL, 0x2}, /* mic-sel: 0a,0d,14,02 */
> +       {0x15, AC_VERB_SET_CONNECT_SEL, 0x1}, /* mic-sel: 0a,0d,14,02 */
>         {0x02, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE}, /* HP */
>         {0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE}, /* Speaker */
>  /*     {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},*/ /* Optical Out */
-- 
Daniel J Blueman
