From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: Codec driver for Texas Instruments
	tlv320dac33 codec
Date: Tue, 13 Oct 2009 12:46:42 +0300
Message-ID: <200910131246.42861.peter.ujfalusi@nokia.com>
References: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910131013.00050.peter.ujfalusi@nokia.com>
	<20091013092622.GA1230@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BF2F1038A1
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 11:46:53 +0200 (CEST)
In-Reply-To: <20091013092622.GA1230@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tuesday 13 October 2009 12:26:22 ext Mark Brown wrote:
 =

> I mean the pattern of suppressing I2C writes while the chip is powered
> down rather than the

I guess I have some good way of handling this (thanks to Eero for the idea)

> =

> > I'm not sure how to make sure that we can access to the chip, and at the
> > same time do not use extensive mutex lock/unlock for the I2C accesses.
> > Ideas?
> =

> Perhaps just call the mutex something more descriptive like chip_power
> or something might be enough make it clear what it's protecting?

Now that the mutex handling is cleaner in the chip power sense, I'll use th=
e =

same mutex to protect the state as well (when the dac33 is in nSample mode).
It fits there nicely as well.

> > Hmm, yes you are right, it is kind of a mess...
> > I can think of the following:
> > dac33_set_power -> dac33_hard_reset
> > dac33_soft_power -> dac33_soft_reset
> >
> > In dac33_set_bias_level only toggle the dac33_soft_reset.
> > In dac33_soc_suspend/dac33_soc_resume I can use the dac33_hard_reset wi=
th
> > register restore.
> >
> > Does it makes it a bit cleaner?
> =

> I think so - it'd probably also help if the cache restore were merged
> into one of the functions too.  I'd be inclined to keep _power too.

You mean something like this:
dac33_set_power -> dac33_hard_power
dac33_soft_power -> dac33_soft_power

Or keeping the old names, but make the use of these more consequent?

 =

> OK.  I'd expect that at some point people will want to control things
> like the digital routing.

I think, I will have the controls implemented before anyone would realize t=
hat =

they need control for those ;)
But it will be done in the future since it needs lot's of tries to get thin=
gs =

sorted out.

-- =

P=E9ter
