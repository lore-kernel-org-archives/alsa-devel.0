From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Hoontech Audio DSP24 Value (+bracket)
Date: Tue, 12 Feb 2002 11:49:12 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202121138001.496-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <s5hpu3b5776.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christof Damian <cdamian@guideguide.com>, alsa developer mailinglist <alsa-devel@alsa.alsa-project.org>, Claus Riethmueller <claus@ridi.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 Feb 2002, Takashi Iwai wrote:

> At Mon, 11 Feb 2002 14:15:59 +0000,
> Christof Damian wrote:
> >
> > Hello,
> > I already send the attached email to the alsa-user list, but haven't
> > got any response.
> >
> > After looking through ice1712.c I now realize that the DSP24 Value
> > might never have been tried with this driver. As it only mentions the
> > STDSP24, which is similar but not the same.
> >
> > Is this correct, or has anyone got this working ?
>
> The patch is apprently not enough.
> We need additional codes in snd_ice1712_ak4524_write() to send signals
> to ak4524 correctly.
> Most likely there are gpio bits for codec selection, data and clock
> lines.  Looking at the photo of the card, the DSP24 Value looks like
> having fairly different usage of gpio.  If we really have no info
> about this card, we need to guess from other cards how the connections
> are..  Well, it's not a good dream..

The patch is wrong. There is PIC accessing and initializating AK4524
codecs. I'm not sure, if we can drive analog codecs directly, because I
have no further information about DSP24 Value.

> > I am currently fiddling with the driver and have done this:
> >
> > --- pci/ice1712.c       9 Feb 2002 18:54:38 -0000       1.9
> > +++ pci/ice1712.c       11 Feb 2002 14:11:25 -0000
> > @@ -3750,6 +3750,10 @@
> >
> >         /* determine I2C, DACs and ADCs */
> >         switch (ice->eeprom.subvendor) {
> > +       case ICE1712_SUBDEVICE_STDSP24:
> > +               has_i2c = 1;
> > +               ice->num_adcs = ice->num_dacs = ice->num_total_dacs =
> > 2;
> > +               break;
> >         case ICE1712_SUBDEVICE_AUDIOPHILE:
> >                 ice->ak4528 = 1;
> >                 /* follow thru */
> > @@ -3954,6 +3958,7 @@
> >         case ICE1712_SUBDEVICE_DELTA66:
> >         case ICE1712_SUBDEVICE_EWS88MT:
> >         case ICE1712_SUBDEVICE_DMX6FIRE:
> > +       case ICE1712_SUBDEVICE_STDSP24:
> >                 for (idx = 0; idx < ice->num_dacs; ++idx) {
> >                         snd_kcontrol_t ctl;
> >                         memset(&ctl, 0, sizeof(ctl));
> >
> > which gives me the IPGA scontrol in amixer and the "H/W Out 1+2" and the
> > DAC 0+1 and ADC 0+1 levels in "Analog Volume" in envy24control.
> >
> > not that i know what i am doing as i don't have any docs for this
> > card. I also don't know how to decide wheter the card is a DSP24 Value
> > or STDSP24 in ice1712.c
>
> Since your card was recognized as STDSP24, it means that both cards
> have the same sub vendor/device id.  Thus it's difficult to guess
> which chip is.  Perhaps trying to detect ak4524 at first, then one
> can recognize it as DSP24 Value or not.

I'm also not sure about differences between models, because the full
version expects some additional I/O boxes, but there is no way to detect
which (and if) a box is connected. The DSP24 Value version looks like a
card with simplified build-in I/O box.

I think that I have a contact to a guy from Taiwan (Hoontech) from Claus
Riethmueller, so I asked him for more information about differences
between DSP24 and DSP24 Value, but he has not replied.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
