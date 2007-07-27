From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Hidden rate conversion, and Alsa configuration
Date: Fri, 27 Jul 2007 17:20:41 +0100
Message-ID: <200707271720.41278.gineera@aspect135.co.uk>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<20070719142440.GA2467@localhost>
	<200707201333.38449.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CA61103839
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 17:56:41 +0200 (CEST)
In-Reply-To: <200707201333.38449.gineera@aspect135.co.uk>
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

On Friday 20 July 2007 13:33, Alan Horstmann wrote:
> < Previously subject: Re: SALSA and aplay >
>
> On Thursday 19 July 2007 15:24, you wrote:
> > On Thu, Jul 19, 2007 at 11:33:32AM +0200, Takashi Iwai wrote:
> > > At Wed, 18 Jul 2007 17:20:29 +0100,
> > >
> > > The 48k-fixed rate is due to dmix plugin.  It requires a fixed sample
> > > rate for all apps.  In theory, it may accept multiple rates, but the
> > > feature is not implemented yet.
> > >
> > > You can change the default rate by overriding defaults.pcm.dmix.rate
> > > config item, e.g. define the below in ~/.asoundrc:
> > >
> > > 	defaults.pcm.dmix.rate 44100
> >
> > Wouldn't it be better to specify hw:0 (or whatever card you are using)
> > in this case? With this type of hardware I'd rather make sure that dmix
> > isn't used at all (I assume that dmix is now the default instead of
> > hw:0).
>
> I have less concern with dmix than the hidden rate conversion, but would
> happily loose both.  Using "hw" forces use of 12 capture and 10 playback
> channels in this case, doesn't it?  So I need some plugin to play 2
> channels?
>
> There are 2 issues for me:
>
> 1. With the cards rate state = 'locked' alsa (not sure what bit of it) was
> unable to set the desired clock rate, yet did not report an error.  Data
> was then eg captured from the card as if it was running at 48K, but
> actually it remained at 44.1K.  Thus the recorded data was wrong.
>
> snd_pcm_hw_params_set_rate_near(..)
>
> did not report error because it was asking for 44.1K; somewhere else the
> configuration decided 48K was better, but did not highlight that the card
> refused to change setting.  Surely this should class as a bug.
>
> Since the inverse error happens on capture, it is not immediately obvious
> that there is a problem with the recording, so important recordings could
> be completely messed up.
>
> 2. These ice1712-based pro/semi-pro hardware systems should IMO NEVER
> perform secret rate conversion.  They are designed for readers of 'Sound on
> Sound' etc, and Paul White et al would rightly blast M-Audio or Terratec if
> their Windows drivers quietly set the card to a different rate to that
> requested and rate converted the data!  Especially so on a capture stream. 
> Remember the cards are 24-bit 96KHz capable and approach 100dB
> signal-to-noise ratio.
>
> Whilst there may be circumstances in which material recorded at different
> rates has to be used in the same project, it is only converted once, in
> full knowledge.
>
> Can't dmix be configured to run at whatever rate is set on the card, or the
> requested rate, rather than attempt to overule both of them?

Takashi,

Was this missed or ignored?!!

Could you give pointers as to how to modify Alsa configuration so that rate 
conversion can never happen, as I would prefer to have an error accessing the 
sound card rather than unknown conversion, which in my use should never be 
neccesary anyway.

Thanks

Alan
