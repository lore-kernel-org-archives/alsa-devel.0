From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] Documentation: dt: bindings: sound: Add bindings
 file for CS35L32
Date: Thu, 31 Jul 2014 15:40:51 -0500
Message-ID: <alpine.DEB.2.02.1407311528570.7394@heelrod>
References: <1406664163-10506-1-git-send-email-brian.austin@cirrus.com>
 <1406664163-10506-2-git-send-email-brian.austin@cirrus.com>
 <20140731202149.GX17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140731202149.GX17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Jul 2014, Mark Brown wrote:

> On Tue, Jul 29, 2014 at 03:02:43PM -0500, Brian Austin wrote:
> 
> > This patch adds the devicetree bindings file for the Cirrus Logic CS35L32 Boosted Amplifier
> 
> Word wrapping in the commit message please.
> 
> > +  - cirrus,sdout-datacfg : Data configuration for dual CS35L32 applications only.
> > +  Determines the data packed in a two-CS35L32 configuration.
> > +  0 = Left/right channels VMON[11:0], IMON[11:0], VPMON[7:0].
> > +  1 = Left/right channels VMON[11:0], IMON[11:0], STATUS.
> > +  2 = (Default) left/right channels VMON[15:0], IMON [15:0].
> > +  3 = Left/right channels VPMON[7:0], STATUS.
> 
> > +  - cirrus,sdout-share : SDOUT sharing. Determines whether one or two CS35L32
> > +  devices are on board sharing SDOUT.
> > +  0 = (Default) One IC.
> > +  1 = Two IC's.
> 
> So, this was all a bit non-obvious but I found a datasheet so was able
> to figure it out.  The device is using the I2S input channels to stream
> monitoring data back to the host and can do this in TDM mode.  That's a
> bit fun, and would ideally mean we'd have to play with hwmon, but it's
> possibly better not to worry about that for now.
Good. I didn't want to have to mess with anything on this part. At least 
for now
> 
> Looking at the datasheet I also see a VP supply which is omitted from
> the driver and bindings - in battery powered devices like phones it'll
> be connected directly to the battery so have no effect but it's still
> better to represent it in case someone wants to use it some other way
> that does merit software control (eg, a system running off 12V batteries
> will need to regulate it down).
> 
I was wondering about that. I didn't think representing a battery as a 
regulator was gonna be accepted but I can add that back in for sure

> > +  - cirrus,gain-manager : Audio-gain management when LEDs are active.
> > +  0 = (Default) Automatically reduces audio volume once by 3 dB, only if needed
> > +  to avoid thermal shutdown or current limiting the boost converter.
> > +  If the condition persists, the CS35L32 examine s ILED_MNG and responds accordingly.
> > +  Audio recovers to original volume automatically at the end of the LED event.
> > +  1 = User controls volume (nonautomatic).
> 
> This looks like something that should be a runtime control.
> 
I thought so too but "They" assure me it is not.

Thanks Mark
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
