From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Allow the codec to work in
 slave mode
Date: Thu, 2 Oct 2014 15:54:26 -0300
Message-ID: <CAOMZO5AKvm-DAP7xWieqA8PHVe2cQc0HVy1y6v7YYg+58sg-4g@mail.gmail.com>
References: <1411082245-25679-1-git-send-email-festevam@gmail.com>
 <20140923015448.GF27755@sirena.org.uk>
 <CAOMZO5BUvZDgY+-VUVENWEoXZS4qFDBKA7ZZLAOzDt-Oawm9tA@mail.gmail.com>
 <20140930192912.GM4273@sirena.org.uk>
 <CAOf5uwmFZcKvmSHWLjhu5OMuM=ZUOT2KXhwKdcZQSWOuhqdDsw@mail.gmail.com>
 <20141001182754.GL4273@sirena.org.uk>
 <CAOMZO5A-wd-XcjNdQbz5RGiC6zx+RLGzCBmbUurMvsHqNUTvgw@mail.gmail.com>
 <20141002175856.GY4273@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 32766261735
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 20:54:27 +0200 (CEST)
Received: by mail-la0-f44.google.com with SMTP id gb8so2963310lab.31
 for <alsa-devel@alsa-project.org>; Thu, 02 Oct 2014 11:54:26 -0700 (PDT)
In-Reply-To: <20141002175856.GY4273@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 2, 2014 at 2:58 PM, Mark Brown <broonie@kernel.org> wrote:

> The comment says "if mclk not satisfy the divider, use pll" and then
> does in fact skip configuring the PLL (or at least a register change
> which looks like it does that).  Looking at the code it seems like
> there's a requirement for MCLK to be one of the standard multiples of
> the sample rate.

Ok, got it now.

For sgtl5000 to operate in slave mode it can only work in "Synchronous
SYS_MCLK input" mode.

In this mode only the following rates can be supported: 256*Fs, 384*Fs, 512*Fs.

On the board I was testing this I was getting a ratio of 233, so the
original code returned -EINVAL.

So the current behaviour looks correct.

We could improve the 'PLL not supported in slave mode' error message
though putting the actual ratio we got.

Will send a patch for this shortly.
