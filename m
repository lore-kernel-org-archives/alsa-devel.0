From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: OMAP: Fix DSP DAI format in McBSP
	DAI driver
Date: Wed, 22 Oct 2008 11:29:36 +0100
Message-ID: <20081022102935.GC7640@sirena.org.uk>
References: <1224505799-16686-1-git-send-email-jarkko.nikula@nokia.com>
	<dfeb90390810220256t41015140l57cb3fb584e24da0@mail.gmail.com>
	<20081022131225.b162289e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0370B2451B
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 12:29:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081022131225.b162289e.jarkko.nikula@nokia.com>
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
Cc: ext Arun KS <getarunks@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 22, 2008 at 01:12:25PM +0300, Jarkko Nikula wrote:

> > This is modifying what machine driver has chosen. AM I missing something?

> Since as a McBSP sense, the normal polarities in DSP format (or
> according to AIC33 DSP mode...) were different than in I2S. Idea is to
> keep codec and cpu configuration in sync in the machine driver, i.e.
> same bit clock and frame sync polarity configuration

Hrm - this suggests that one or more of your codec drivers may be
getting this wrong.  I would expect that the inversion of bit and frame
clocks should be with respect to the normal behaviour of the mode, not
with respect to I2S mode.
