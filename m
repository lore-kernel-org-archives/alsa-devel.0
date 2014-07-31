From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] Documentation: dt: bindings: sound: Add bindings
 file for CS35L32
Date: Thu, 31 Jul 2014 16:28:03 -0500
Message-ID: <alpine.DEB.2.02.1407311626510.7394@heelrod>
References: <1406664163-10506-1-git-send-email-brian.austin@cirrus.com>
 <1406664163-10506-2-git-send-email-brian.austin@cirrus.com>
 <20140731202149.GX17528@sirena.org.uk>
 <alpine.DEB.2.02.1407311528570.7394@heelrod>
 <20140731211828.GA17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140731211828.GA17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Jul 2014, Mark Brown wrote:

> On Thu, Jul 31, 2014 at 03:40:51PM -0500, Brian Austin wrote:
> > On Thu, 31 Jul 2014, Mark Brown wrote:
> > > On Tue, Jul 29, 2014 at 03:02:43PM -0500, Brian Austin wrote:
> 
> > > > +  - cirrus,gain-manager : Audio-gain management when LEDs are active.
> > > > +  0 = (Default) Automatically reduces audio volume once by 3 dB, only if needed
> > > > +  to avoid thermal shutdown or current limiting the boost converter.
> > > > +  If the condition persists, the CS35L32 examine s ILED_MNG and responds accordingly.
> > > > +  Audio recovers to original volume automatically at the end of the LED event.
> > > > +  1 = User controls volume (nonautomatic).
> 
> > > This looks like something that should be a runtime control.
> 
> > I thought so too but "They" assure me it is not.
> 
> They may be unfamiliar with upstream policies and standards!
> 
That is a fair assumption. I can turn it into a Switch kcontrol and remove 
it from DT.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
