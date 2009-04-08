From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Wed, 8 Apr 2009 09:01:18 +0300
Message-ID: <200904080901.18705.peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904070819.12019.peter.ujfalusi@nokia.com>
	<20090407221404.GA8465@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 39B44245CA
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 08:01:29 +0200 (CEST)
In-Reply-To: <20090407221404.GA8465@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 08 April 2009 01:14:05 ext Mark Brown wrote:
> On Tue, Apr 07, 2009 at 08:19:11AM +0300, Peter Ujfalusi wrote:
> > twl4030: Samples the data on falling edge, shifts data out (and changes
> > the FS) on rising edge
> > tlv320aic23: Samples the data on rising, shifts data out (and changes t=
he
> > FS) on falling edge
>
> What ASoC expects for DSP mode is that the data can be sampled on either
> the first (mode B) or second (mode A) rising edge of BCLK after a rising
> edge of LRCLK.  This implies that the data should be driven on the
> falling edge of BCLK.
>
> The TLV320AIC23 can do either mode - the description on page 24 matches
> exactly.  Unless I'm missing something the inversion of the frame clock
> for osk5912 looks like a mistake.  I'd need to read the code a bit more
> closely to check I've not missed something but it looks like the codec
> driver is never actually setting LRP so it's got the mode the wrong way
> round for the one it supports.

I have been also wondering about the missing LRP handling, but I do not hav=
e =

access to osk5912 board neither to tlv320aic32 codec...

>
> The TWL4030 datasheet does not appear to be a model of clarity in this
> area but it looks awfully like mode A with an inverted bit clock (the
> data appears to be being driven rather than sampled on the rising edge
> but the first bit does start on the falling edge of the frame clock).

Well, in general there are lots of these kind of 'small' details missing fr=
om =

the documentation. One just have to try it out and see how it behaves ;)

> This means the Beagle code looks about right unless I'm misreading
> something.

Does it means that the DSP_A addition is also correct? I have it drawn to =

paper, how the configuration in omap-mcbsp used by the beagle in 4 channel =

mode would look like, and it does look 100% as the TDM mode described in th=
e =

twl datasheet...


BTW: when the twl is in 4 channel mode, it has to be the master on the bus =

(small thing, since twl usually is the master on the bus anyway)

-- =

P=E9ter
