From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Mon, 17 Feb 2014 16:16:13 +0100
Message-ID: <20140217161613.3d6fe44e@skate>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
 <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
 <20140130181607.6a694b8f@skate>
 <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
 <20140210152244.19f9d647@skate>
 <20140214201709.GG4451@sirena.org.uk>
 <20140217141440.335d1a7b@skate>
 <CAOf5uwncvsUmLJynYZW2kzFf7Dp728HNciLFdLRovFRC8Je35A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id E6575261B32
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 16:16:17 +0100 (CET)
In-Reply-To: <CAOf5uwncvsUmLJynYZW2kzFf7Dp728HNciLFdLRovFRC8Je35A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Lior Amsalem <alior@marvell.com>, Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Dear Michael Trimarchi,

On Mon, 17 Feb 2014 15:59:35 +0100, Michael Trimarchi wrote:

> > Note that I haven't looked myself in details at the code of the audio
> > codec. I simply noticed there was a volume control problem and that
> > reverting Brian's patch made the volume control work again. I have not
> > investigated at all to fix the codec code, as I was suspecting that
> > Brian may have immediately an idea on what could be wrong. If he
> > doesn't have the time to look into this, I can certainly spend a bit of
> > time to investigate what's going on.
> >
> why you don't just use regmap and check what happen on registers?

I did have a look at the codec_reg debugfs file from ASoC, and the
values were indeed not correct, as far as I remember. But I don't have
the board powered up right now, so I'd need to set it up again to make
a more precise report of what's going on.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
