From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Envy24control s/pdif input bugfix
Date: Mon, 24 Sep 2007 11:07:55 +0100
Message-ID: <200709241107.55372.gineera@aspect135.co.uk>
References: <46F67612.90103@gmx.at> <46F67877.5050708@gmx.at>
	<200709232306.23001.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 00D9224898
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Sep 2007 11:53:45 +0200 (CEST)
In-Reply-To: <200709232306.23001.gineera@aspect135.co.uk>
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Stephan Zaubzer <s.zaubzer@gmx.at>
List-Id: alsa-devel@alsa-project.org

On Sunday 23 September 2007 23:06, Alan Horstmann wrote:
> On Sunday 23 September 2007 15:30, Stephan Zaubzer wrote:
> > Sorry, used diff the wrong way!
> > Here the correct patch:
> >
> > diff -ubr alsa-tools-1.0.14/envy24control/hardware.c
> > alsa-tools-1.0.14patch/envy24control/hardware.c ---
> > alsa-tools-1.0.14/envy24control/hardware.c  2007-06-04 13:27:25.000000000
> > +0200 +++ alsa-tools-1.0.14patch/envy24control/hardware.c     2007-09-23
> > 15:58:53.000000000 +0200 @@ -775,7 +775,7 @@
> >          snd_ctl_elem_value_set_interface(volume_rate,
> > SND_CTL_ELEM_IFACE_MIXER); snd_ctl_elem_value_set_name(volume_rate,
> > "Multi Track Volume Rate");
> >
> > -       if (! card_is_dmx6fire) {
> > +       if (card_is_dmx6fire) {
> >                  snd_ctl_elem_value_set_interface(spdif_input,
> > SND_CTL_ELEM_IFACE_MIXER); snd_ctl_elem_value_set_name(spdif_input,
> > "Optical Digital Input Switch"); } else {
> >
> > Regards Stephan
> >
> > Stephan Zaubzer wrote:
> > > Hi!
> > > This patch against the stable version of envy24control fixes a bug
> > > where the S/Pdif input switch doesn't work on Terratec DMX 6fire cards.
> > > This bug first appeared in  version 1.0.11rc3.
> > >
> > > diff -ubr alsa-tools-1.0.14patch/envy24control/hardware.c
> > > alsa-tools-1.0.14/envy24control/hardware.c
> > > --- alsa-tools-1.0.14patch/envy24control/hardware.c     2007-09-23
> > > 15:58:53.000000000 +0200
> > > +++ alsa-tools-1.0.14/envy24control/hardware.c  2007-06-04
> > > 13:27:25.000000000 +0200
> > > @@ -775,7 +775,7 @@
> > >          snd_ctl_elem_value_set_interface(volume_rate,
> > > SND_CTL_ELEM_IFACE_MIXER);
> > >          snd_ctl_elem_value_set_name(volume_rate, "Multi Track Volume
> > > Rate");
> > >
> > > -       if (card_is_dmx6fire) {
> > > +       if (! card_is_dmx6fire) {
> > >                  snd_ctl_elem_value_set_interface(spdif_input,
> > > SND_CTL_ELEM_IFACE_MIXER);
> > >                  snd_ctl_elem_value_set_name(spdif_input, "Optical
> > > Digital Input Switch");
> > >          } else {
> > >
> > >
> > > Regards
> > > Stephan
>
> I think that's a typo in my original patch -oops!  Will confirm ASAP.

Actually, it is not from my patch - I added 'card_is_dmx6fire' to 
envy24control.c.  It was later extended to hardware.c by another:

http://hg-mirror.alsa-project.org/alsa-tools/rev/48406c03292e

Obviously a typo though.

Also noticed that, as that patch added the declaration of card_is_dmx6fire to 
envy24control.h, there is now a redundant declaration in envy24control.c, 
Line 37.

Alan
