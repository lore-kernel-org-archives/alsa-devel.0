From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [RFC 2/4] ASoC: imx-sgtl5000: Let the code clock
 be a mandatory binding
Date: Thu, 18 Apr 2013 14:41:08 +0800
Message-ID: <20130418064106.GE20563@S2101-09.ap.freescale.net>
References: <1366242921-16376-1-git-send-email-festevam@gmail.com>
 <1366242921-16376-2-git-send-email-festevam@gmail.com>
 <20130418033616.GD20563@S2101-09.ap.freescale.net>
 <CAOMZO5CDBBV1H1-uj=qXj5Ayo_Lp57j6tcS7izN3AEGHze9XXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FE94265E11
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 08:41:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5CDBBV1H1-uj=qXj5Ayo_Lp57j6tcS7izN3AEGHze9XXg@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, mfuzzey@gmail.com, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2013 at 12:56:15AM -0300, Fabio Estevam wrote:
> On Thu, Apr 18, 2013 at 12:36 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> >> I am marking this one as RFC because I don't have mx51babbage nor mx53qsb handy
> >> to test it.
> >
> > It works on imx53-qsb but doe not on imx5q-babbage.  That clk_26M is not
> > registered to clock framework as a clk provider.
> 
> Thanks for testing it, Shawn.
> 
> I will investigate this when I get access to a mx51-babbage.
> 
> If anyone has any hints as to how register this clk_26M properly via
> device tree, please let me know.

Though it's still under review, the patch [1] from Martin Fuzzey is just
what you need.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg238281.html
