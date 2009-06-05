From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Fri, 5 Jun 2009 23:47:32 +0100
Message-ID: <20090605224731.GA11747@sirena.org.uk>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090603131819.GQ26148@buzzloop.caiaq.de>
	<37b631400906040207o169abbc2ob33100879ac68911@mail.gmail.com>
	<1719ee7f0906040244t3890b069s5039c3f0c8bbe09a@mail.gmail.com>
	<20090605172630.GG26148@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3947B2448A
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 00:47:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090605172630.GG26148@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, bshen9@marvell.com, eric.y.miao@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2009 at 07:26:30PM +0200, Daniel Mack wrote:

> Ah - the PXA_SSP_FRM_64FS is the detail I missed. With that option set,
> my system works well, so I'm generally fine with the changes.
> 
> However, I proposed a generic way (not pxa/ssp specific) to let the
> format flags carry the information about such frame format details some
> months ago and the approach was rejected because there are already too
> many ways to let the DAI know about this.

Indeed, and there's some potential lack of clarity with the interaction
of settings in the DAI format with these other settings.

>                                           In particular, the DIV_SCR
> (serial clock rate divider) is used to propagate the base frequency
> ratio and together with other options, you can find out the desired
> frame format.

There's that, and there's also the TDM settings which provide
essentially the same information - an overclocked bit clock is
equivalent to a TDM mode where the first slot is in use.  It's not
immediately clear to me what a combination of the two options ought to
do.

It's also a logically different bit of configuration - for most devices
it only makes a difference to the device that's generating the clocks
and wouldn't need to be specified for the other devices since they'd
just ignore the extra clocks.  The DAI format specifies the format for
the clocks, primarily the frame clocks, but does not currently handle
their rates.

> handles the case. Eventually this might be a matter of taste, but if we
> go this way, why shouldn't that definitions be in ASoC's generic
> headers?

Definitely.
