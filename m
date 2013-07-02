From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
 before writting
Date: Tue, 2 Jul 2013 10:16:53 +0800
Message-ID: <20130702021651.GY13206@S2101-09.ap.freescale.net>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <20130701153327.GX13206@S2101-09.ap.freescale.net>
 <CAOMZO5B5jh1XciO4K1u3yBcHHDAgi8hA3GcywnJd11M7=aOPxA@mail.gmail.com>
 <201307011943.27489.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 987332652B9
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 04:16:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201307011943.27489.marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 01, 2013 at 07:43:27PM +0200, Marek Vasut wrote:
> Dear Fabio Estevam,
> 
> > On Mon, Jul 1, 2013 at 12:33 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > On Mon, Jul 01, 2013 at 12:11:58PM -0300, Fabio Estevam wrote:
> > >> On Mon, Jul 1, 2013 at 11:34 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > >> > And also why we do not see the impact of i2c issue on sgtl5000 before
> > >> > the offending commit af8ee11 (ASoC: sgtl5000: Fix driver probe after
> > >> > reset)?
> > >> 
> > >> Probably because the mxs i2c was working before this commit.
> > > 
> > > Do you have a commit id at which mxs i2c is known good?  I would like to
> > > find out it's a mxs i2c issue or sgtl5000 problem.
> > 
> > I don't have it, but I am adding Alexandre in case he knows.
> > 
> > Alexandre,
> > 
> > Do you happen to know a commit id which does not show the mxs i2c
> > timeouts you have been observing?
> 
> I think you can just disable the PIO mode altogether (around line 500 ... if 
> (msg->len < 8) ... replace this with if (0) ) and then the problem should not be 
> there (if it's a PIO problem).

Ok, Fabio is right. With the change, sgtl5000 write works even without
that msleep(50).

So, Mark, please disregard the patch, and we should fix mxs i2c driver
instead.

Shawn
