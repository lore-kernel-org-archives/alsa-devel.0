From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] pxa2xx-lib: support building for several
	pxa's
Date: Thu, 31 Jul 2008 10:37:57 +0100
Message-ID: <20080731093756.GA11790@sirena.org.uk>
References: <1217441805.20421.4.camel@ubuntu>
	<bc64b4640807301541m3f070da9o1c44ec14e160e829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FF6024564
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 11:37:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bc64b4640807301541m3f070da9o1c44ec14e160e829@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry <dbaryshkov@gmail.com>
Cc: Russ Dill <russ.dill@gmail.com>, alsa-devel@alsa-project.org, eric.miao@marvell.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 31, 2008 at 02:41:21AM +0400, Dmitry wrote:

> > #ifdef's. Just a quick question for Dmitry, why all the if (!
> > cpu_is_pxa3xx())'s around the pxa_gpio_mode's? Also, there was a build
> > error when just building the sound/arm pxa2xx-ac97.

> AFAIR pxa_gpio_mode isn't valid for the the pxa3xx, so cpu_is_pxa3xx().

Not really.  The thing is that historically drivers set the MFP mappings
up themselves rather than letting the board code do it.  Going forward
that should be being done by the platform code but simply removing the
configuration for PXA2xx would break existing users.

Aside from that the PXA3xx series provide multiple MFP options for the
AC97 interface so we can't do an unconditional setup for them anyway -
the configuration is always board specific.
