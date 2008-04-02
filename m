From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC for TI OMAP - Multiformat ASoC DAI
	link	driver?
Date: Wed, 2 Apr 2008 12:48:20 +0100
Message-ID: <20080402114820.GB7977@rakim.wolfsonmicro.main>
References: <20080402134538.67d67d6e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2F842442E
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Apr 2008 13:48:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080402134538.67d67d6e.jarkko.nikula@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 02, 2008 at 01:45:38PM +0300, Jarkko Nikula wrote:

> Currently in ASoC v1 we have one DAI driver per one format? E.g.
> separate drivers for I2S, AC97, etc and type field in cpu_dai
> structure is not a bit field or at least not used such way in
> soc-core.c and DAI link drivers.

Yes, though it's mostly just used to special case AC97 and for display
purposes so you may find that your use case already works if you fill in
something non-AC97.  I've not looked closely or made any effort to test
this, though.

> I looked shortly asoc-v2-dev branch and now this type field is gone.
> Does it mean that there you can have DAI link driver which supports
> multiple formats in set_fmt callback?

I don't know if anyone has ever actually done that but there should be
nothing in the core which has a problem with doing it - if there is we
should fix it up since this is a perfectly reasonable use case and
affects a number of other modern processors too.
