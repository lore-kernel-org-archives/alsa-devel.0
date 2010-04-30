From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320dac33: Support for turning
	off the codec in BIAS_STANDBY
Date: Fri, 30 Apr 2010 12:45:38 +0300
Message-ID: <201004301245.38913.peter.ujfalusi@nokia.com>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<1272612715-13387-5-git-send-email-peter.ujfalusi@nokia.com>
	<20100430084100.GB28241@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 33596243E7
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 11:46:41 +0200 (CEST)
In-Reply-To: <20100430084100.GB28241@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 30 April 2010 11:41:00 ext Mark Brown wrote:
> On Fri, Apr 30, 2010 at 10:31:55AM +0300, Peter Ujfalusi wrote:
> > When the codec is in STANDBY we can actually turn it off.
> > When the codec is off, than the associated regulator can be also turned
> > off (if the number of users on the regulator is 0).
> =

> You can just set idle_bias_off in the CODEC and then the core will push
> you down into _BIAS_OFF.

Good idea. Needed some code movement, but works fine. Thanks.

> =

> > There are few scenarios, which has to be taken care::
> > 1. Analog bypass caused BIAS_STANDBY -> BIAS_ON
> > =

> >    We need to power on the codec, and do the chip init, but we does not
> >    need to execute the playback related configuration
> =

> Moving the playback related configuration into events on the DAC widgets
> (or probably a supply connected to the DAC widgets) seems like a good
> move for a lot of these scenarios?  The core will then take care of
> ensuring that the startup sequence for the playback is called for you
> and the states can do what they're supposed to more directly.

This is not working.
Actually it works, if we come from BIAS_OFF, but...
If I restart the playback fast (within asoc timeout for BIAS change), than =
the =

widget will not get event (since it is still powered). This means that I ca=
n not =

do the needed reconfiguration for the tlv320dac33 -> audio breaks.

I will keep the current logic, but move it a bit with the idle_bias_off cha=
nge.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

P=E9ter
