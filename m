From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Wed, 8 Apr 2009 10:28:12 +0100
Message-ID: <20090408092811.GA20122@sirena.org.uk>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090406122232.GA8585@rakim.wolfsonmicro.main>
	<200904061537.59067.peter.ujfalusi@nokia.com>
	<200904070819.12019.peter.ujfalusi@nokia.com>
	<20090407221404.GA8465@sirena.org.uk>
	<20090408090816.7e780975.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DCAE91037E3
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 11:28:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090408090816.7e780975.jarkko.nikula@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2009 at 09:08:16AM +0300, Jarkko Nikula wrote:

> What I've seen few codec specs there is no uniform way for different
> DSP formats between their specifications except Wolfson codecs. So I
> use to keep those as a reference and match codec accordingly. Like in
> AIC3x where bit-clock polarity is fixed.

Well, often there's not much polarity but generally the device will
offer something that can be expressed as a combination of mode A or B
and BCLK inversion.  The Wolfson devices are the way they are mostly to
give them the flexibility to interoperate with whatever the other device
is able to do - there's no reason to select any particular clocking mode
other than for interoperability.
