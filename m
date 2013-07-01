From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
	before writting
Date: Mon, 1 Jul 2013 19:43:27 +0200
Message-ID: <201307011943.27489.marex@denx.de>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <20130701153327.GX13206@S2101-09.ap.freescale.net>
 <CAOMZO5B5jh1XciO4K1u3yBcHHDAgi8hA3GcywnJd11M7=aOPxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6DE2651B7
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 19:43:29 +0200 (CEST)
In-Reply-To: <CAOMZO5B5jh1XciO4K1u3yBcHHDAgi8hA3GcywnJd11M7=aOPxA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Dear Fabio Estevam,

> On Mon, Jul 1, 2013 at 12:33 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Mon, Jul 01, 2013 at 12:11:58PM -0300, Fabio Estevam wrote:
> >> On Mon, Jul 1, 2013 at 11:34 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >> > And also why we do not see the impact of i2c issue on sgtl5000 before
> >> > the offending commit af8ee11 (ASoC: sgtl5000: Fix driver probe after
> >> > reset)?
> >> 
> >> Probably because the mxs i2c was working before this commit.
> > 
> > Do you have a commit id at which mxs i2c is known good?  I would like to
> > find out it's a mxs i2c issue or sgtl5000 problem.
> 
> I don't have it, but I am adding Alexandre in case he knows.
> 
> Alexandre,
> 
> Do you happen to know a commit id which does not show the mxs i2c
> timeouts you have been observing?

I think you can just disable the PIO mode altogether (around line 500 ... if 
(msg->len < 8) ... replace this with if (0) ) and then the problem should not be 
there (if it's a PIO problem).

Best regards,
Marek Vasut
