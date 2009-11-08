From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: RFC: ice1712 virtual devices
Date: Sun, 8 Nov 2009 21:13:17 +0000
Message-ID: <200911082113.17684.gineera@aspect135.co.uk>
References: <4AE9D57E.5090105@hotmail.com>
	<200910300923.37295.gineera@aspect135.co.uk>
	<s5h3a4pqp1c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net
	[62.24.128.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 763BF1037FF
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 22:02:06 +0100 (CET)
In-Reply-To: <s5h3a4pqp1c.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sunday 08 November 2009 10:38, you wrote:
> At Fri, 30 Oct 2009 09:23:37 +0000,
>
> Alan Horstmann wrote:
> > On Thursday 29 October 2009 17:48, Arno Schuring wrote:
> > > This is basically a resend of
> > > http://thread.gmane.org/gmane.linux.alsa.devel/59481/focus=59672 ,
> > > which fixed the front: device of ice1712 cards to accept two-channel
> > > input. Currently, the front: device is exposed through the route
> > > plugin, which requires all clients to mmap all 10 channels, even though
> > > the front device is supposed to be a stereo device.
> > >
> > > This patch changes the front: device definition such that it matches
> > > the definition of iec958 in the same file. Additionally, I'm tempted to
> > > remove the surround* definitions because the chip does not really offer
> > > surround-style multichannel: it basically just offers multiple stereo
> > > channels, and does not provide any channel mapping beyond stereo.
> > >
> > > Finally, I'm also experimenting with the dshare plugin to allow
> > > applications to access the iec958: and front: devices simultaneously.
> > > Can anyone point me to a working example for this? From reading the
> > > alsa-lib documentation, it is not clear to me how I should nest the
> > > different plugins.
> > >
> > >
> > > Many thanks,
> > > Arno Schuring
> > >
> > >
> > > --
> > >
> > > diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
> > > index 01e50d2..d7acb81 100644
> > > --- a/src/conf/cards/ICE1712.conf
> > > +++ b/src/conf/cards/ICE1712.conf
> > > @@ -32,12 +32,28 @@ ICE1712.pcm.front.0 {
> > >         @args.CARD {
> > >                 type string
> > >         }
> > > -       type route
> > > -       ttable.0.0 1
> > > -       ttable.1.1 1
> > > -       slave.pcm {
> > > -               type hw
> > > -               card $CARD
> > > +       type asym
> > > +       playback.pcm {
> > > +               type route
> > > +               ttable.0.0 1
> > > +               ttable.1.1 1
> > > +               slave.pcm {
> > > +                       type hw
> > > +                       card $CARD
> > > +               }
> > > +               slave.format S32_LE
> > > +               slave.channels 10
> > > +       }
> > > +       capture.pcm {
> > > +               type route
> > > +               ttable.0.0 1
> > > +               ttable.1.1 1
> > > +               slave.pcm {
> > > +                       type hw
> > > +                       card $CARD
> > > +               }
> > > +               slave.format S32_LE
> > > +               slave.channels 12
> > >         }
> > >  }
> >
> > Bear in mind that the ice1712 has been used on a number of very different
> > audio products aimed at different markets, from pro audio recording
> > (DSP2000, Delta1010) to desktop multi-media (DMX6fire, Aureon7.1) and so
> > the 'best' solution in each can be different.
> >
> > In the discussion you quoted, I suggested leaving the sample conversion
> > out of the above definition of 'front', as unwanted conversion is always
> > bad.  If needed, use plug:front.
> >
> > The other issue is that capture from 'front' does not make sense on all
> > products.  The DMX6fire has a differnt routing, with CD, line & phone
> > inputs. A configuration for this unit would not suit the others.  So the
> > most general approach is needed.
> >
> > Certainly adding the asym and slave parts to 'front' definition would be
> > helpful in all cases IMO, as I proposed then, but preferably not format
> > conversion.
>
> I agree that the capture from "front" PCM isn't considered as valid.
> The "front", "rear", "center_lfe" definitions are rather for
> multi-channel playbacks.  The capture on these channels aren't useful
> in most cases.


Takashi,

Arno's original post was just to the list, so I added your cc.  His response 
was also only to the list, but has a patch at the bottom to do just playback 
asym with channels convertion, (which looks reasonable to me), so might be 
worth looking back at.

BTW, for example in the case of ice1712, is there a way for different sound 
cards which use the same driver to have different default config files?  The 
DMX6fire in particular would benefit from specific definitions for the 
particular mapping of its 6 analogue inputs.

Alan
