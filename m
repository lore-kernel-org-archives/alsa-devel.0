From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] mfd: arizona: Add gating of external MCLKn clocks
Date: Tue, 13 Sep 2016 13:57:07 +0100
Message-ID: <20160913125707.GN21682@localhost.localdomain>
References: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1472831568-466-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160913124457.GA31412@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160913124457.GA31412@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 13, 2016 at 01:44:57PM +0100, Lee Jones wrote:
> On Fri, 02 Sep 2016, Charles Keepax wrote:
> 
> > From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > 
> > This patch adds requesting of the clocks supplied on MCLK1, MCLK2 pins,
> > gating of the 32k clock is added to the arizona_clk32k_enable(),
> > arizona_clk32k_disable() helpers.
> > 
> > It's a temporary change until the CODEC's clock controller gets exposed
> > through the clk API and is helpful for board configurations where the
> > MCLK clocks are not provided by always on oscillators.
> > 
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > ---
> >  drivers/mfd/arizona-core.c       | 30 ++++++++++++++++++++++++++++--
> >  include/linux/mfd/arizona/core.h |  9 +++++++++
> >  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Can I take this?
> 

The two following ASoC patches depend on it, so its probably
slightly easier if they go through together.

Thanks,
Charles
