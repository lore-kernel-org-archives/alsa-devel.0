From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH RFC] ASoC: rt5663: use msleep() for uncritical delay
Date: Thu, 19 Jan 2017 12:24:26 +0000
Message-ID: <20170119122425.GB2693@osadl.at>
References: <1484147031-25525-1-git-send-email-hofrat@osadl.org>
 <20170117193302.q4spr53qwrgqdrbh@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117193302.q4spr53qwrgqdrbh@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2017 at 07:33:02PM +0000, Mark Brown wrote:
> On Wed, Jan 11, 2017 at 04:03:51PM +0100, Nicholas Mc Guire wrote:
> > The delay here does not seem to be critical with respect to longer
> > delays than 10ms as this delay is to ensure that the write took
> > effect before the next soc_update_bits/write call only, thus a 
> > high resolution timer makes little sense here - msleep() should do.
> 
> No, that's not what the code is doing at all.
> 
> > +++ b/sound/soc/codecs/rt5663.c
> > @@ -2764,7 +2764,7 @@ static int rt5663_set_bias_level(struct snd_soc_codec *codec,
> >  			RT5663_PWR_FV1_MASK | RT5663_PWR_FV2_MASK |
> >  			RT5663_PWR_MB_MASK, RT5663_PWR_VREF1 |
> >  			RT5663_PWR_VREF2 | RT5663_PWR_MB);
> > -		usleep_range(10000, 10005);
> > +		msleep(10);
> 
> The write before is turning on a bunch of analogue power bits, the
> enabled supplies will then take time to ramp up to their operating
> state before we can proceed.  That's not just "make sure the change took
> effect", there's a bit more to it than that, and power up sequences are
> generally very latency sensitive as they tend to happen in response to
> user input.  People are generally picking the minimum value they can
> reliably get away with and a lot of effort goes into optimising the
> power up procedures.
> 
> That doesn't mean that the change is bad but the analysis in the
> changelog is and could cause confusion.
ok - thanks for the explaination - you are right that I was not seeing
the actual intent of the delay here but simply took it as a I/O delay.

The change should stay valid as both msleep() and usleep_range() can
very significantly overrun their stated values and that should be safe here
(or the code has a deeper rooted problem) while the usage of the high-resolution
timers does not seem to bring any benefit here.

Will clean up the commit message and resend this as well.

thx!
hofrat
