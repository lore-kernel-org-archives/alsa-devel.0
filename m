From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for 19.2 MHz MCLK
	in	TLV320AIC3X
Date: Tue, 15 Apr 2008 13:34:05 +0100
Message-ID: <20080415123405.GD24498@rakim.wolfsonmicro.main>
References: <1207902735-6660-1-git-send-email-jarkko.nikula@nokia.com>
	<20080414135046.GA25508@rakim.wolfsonmicro.main>
	<20080415094139.0838e508.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8548E24714
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 14:34:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080415094139.0838e508.jarkko.nikula@nokia.com>
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

On Tue, Apr 15, 2008 at 09:41:39AM +0300, Jarkko Nikula wrote:
> "ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> > Rather than maintaining this table it might be worth looking at adding
> > code to allow the driver to calculate a suitable configuration at run
> > time.  The WM8753 and WM9713 drivers do this for the PLL
> > configuration, for example.

> Agree, I was also thinking this some time ago but went for simple
> solution first since OMAP's seems to be happy with either 12 or 19.2
> MHz :-)

That actually matches our experiences fairly well - most users use one
of a small set of standard inputs.  It's only a relatively small
proportion of systems that end up using something unusual.
