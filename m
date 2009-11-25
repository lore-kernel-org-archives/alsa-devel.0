From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/12] add a mc13783 codec driver
Date: Wed, 25 Nov 2009 12:00:55 +0000
Message-ID: <20091125120055.GC3175@sirena.org.uk>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<20091119193008.GC2814@sirena.org.uk>
	<20091125074631.GB27548@pengutronix.de>
	<20091125103959.GB17420@opensource.wolfsonmicro.com>
	<20091125110854.GC27548@pengutronix.de>
	<20091125111037.GE17420@opensource.wolfsonmicro.com>
	<20091125113034.GD27548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A9DA243D3
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 13:00:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091125113034.GD27548@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 12:30:34PM +0100, Sascha Hauer wrote:
> On Wed, Nov 25, 2009 at 11:10:37AM +0000, Mark Brown wrote:

> > Again, what are "primary" and "secondary"?

> Maybe this explains best the situation we have here.
> Right in the middle of the diagram you see the A/D converters in the
> Voice Codec. As you see it has two monaural A/D converters. One of them
> is the primary, the other is the secondary converter (don't ask me which
> of them is which, I'd had to lookup myself)

So all you've really got here is stereo in one direction and mono in the
other with flexible placement of the slots.

> The input sources of these ADCs can't be controlled completely
> independent and they are designed to be used for example with two
> microphones in a mobile phone. (I guess that's why they call them
> 'primary' and 'secondary', not 'left' and 'right'). But of course you
> can also do stereo with them.

You could either treat them independently or just assume they're going
to be used as a stereo pair and put them in one DAI.  A third option is
to define DAIs for both cases and then trust machine drivers not to mix
the stereo and mono options inappropriately.  It's really up to you.

For the random placement of the two channels look at the set_channel_map
API.
