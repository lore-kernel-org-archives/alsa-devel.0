From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Clarify API for bias configuration
Date: Fri, 23 May 2008 00:34:15 +0100
Message-ID: <20080522233414.GB31117@sirena.org.uk>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080519171558.c37b980b.jarkko.nikula@nokia.com>
	<20080519183654.GB30712@sirena.org.uk>
	<20080520125325.b17ba0b3.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A4E8924496
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 01:34:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080520125325.b17ba0b3.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 20, 2008 at 12:53:25PM +0300, Jarkko Nikula wrote:
> "ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> > levels.  For a lot of codecs there's no or limited control of the
> > baises but some do provide fine grained control.

> It came to my mind only afterwards but probably usual set_power
> convention fits here well, doesn't confuse with DAPM and doesn't limit
> to thinking only mic bias :-)

Hrm, depends - I can see people viewing it as an alternative to DAPM.
Which, of course, you can do but it's not the Right Way.

This API really is intended for configuring biases and things like them.
Maintaining biases is both power and output quality sensitive so it's
beneficial for the core to be able to control them specifically.  Other
things are expected to be managed via either DAPM, feature-specific APIs
(eg, the PLLs) or the regular power management interface.  From that
point of view it would be good to keep the bias name in at least the
constants. 

> Also how on earth I was able to test my ASoC drivers for OMAP in case
> of codec slave since driver is enabling PLL only for master case.
> Hmm... what a hack I was using then.

Is the codec able to run entirely from the clocks on the audio bus,
perhaps?

> > Most drivers expose clocking configuration like the PLL to machine
> > drivers in order to allow use of clocks generated on the codec
> > independently of the audio stream - if it's not needed outside of

> Some integrated chips might require it as well if there is some
> (undocumented) interdependencies inside the integrated chip. IRCC e.g.
> TSC2301 keypad and touchscreen were using audio clock in some occasions.

Yeah, some of these chips would benefit from the clock API being easier
to use for things outside the SoC, at least for the non-codec features.
