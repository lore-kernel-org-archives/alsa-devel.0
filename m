From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Wed, 8 Apr 2009 09:08:16 +0300
Message-ID: <20090408090816.7e780975.jarkko.nikula@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090406122232.GA8585@rakim.wolfsonmicro.main>
	<200904061537.59067.peter.ujfalusi@nokia.com>
	<200904070819.12019.peter.ujfalusi@nokia.com>
	<20090407221404.GA8465@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 287DC245D1
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 08:08:03 +0200 (CEST)
In-Reply-To: <20090407221404.GA8465@sirena.org.uk>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Apr 2009 00:14:05 +0200
ext Mark Brown <broonie@sirena.org.uk> wrote:

> The TWL4030 datasheet does not appear to be a model of clarity in this
> area but it looks awfully like mode A with an inverted bit clock (the
> data appears to be being driven rather than sampled on the rising edge
> but the first bit does start on the falling edge of the frame clock).
> This means the Beagle code looks about right unless I'm misreading
> something.

What I've seen few codec specs there is no uniform way for different
DSP formats between their specifications except Wolfson codecs. So I
use to keep those as a reference and match codec accordingly. Like in
AIC3x where bit-clock polarity is fixed.


Jarkko
