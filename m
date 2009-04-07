From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Tue, 7 Apr 2009 23:14:05 +0100
Message-ID: <20090407221404.GA8465@sirena.org.uk>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090406122232.GA8585@rakim.wolfsonmicro.main>
	<200904061537.59067.peter.ujfalusi@nokia.com>
	<200904070819.12019.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F8E8243A3
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 00:14:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904070819.12019.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, alsa-devel@alsa-project.org, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 07, 2009 at 08:19:11AM +0300, Peter Ujfalusi wrote:

> twl4030: Samples the data on falling edge, shifts data out (and changes the 
> FS) on rising edge
> tlv320aic23: Samples the data on rising, shifts data out (and changes the FS) 
> on falling edge

What ASoC expects for DSP mode is that the data can be sampled on either
the first (mode B) or second (mode A) rising edge of BCLK after a rising
edge of LRCLK.  This implies that the data should be driven on the
falling edge of BCLK.

The TLV320AIC23 can do either mode - the description on page 24 matches
exactly.  Unless I'm missing something the inversion of the frame clock
for osk5912 looks like a mistake.  I'd need to read the code a bit more
closely to check I've not missed something but it looks like the codec
driver is never actually setting LRP so it's got the mode the wrong way
round for the one it supports.

The TWL4030 datasheet does not appear to be a model of clarity in this
area but it looks awfully like mode A with an inverted bit clock (the
data appears to be being driven rather than sampled on the rising edge
but the first bit does start on the falling edge of the frame clock).
This means the Beagle code looks about right unless I'm misreading
something.
