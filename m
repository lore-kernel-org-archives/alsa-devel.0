From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC PATCH] mfd: arizona: Add gating of external
 MCLKn clocks
Date: Thu, 25 Aug 2016 14:02:34 +0100
Message-ID: <20160825130234.GQ21682@localhost.localdomain>
References: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
 <20160822092233.GN21682@localhost.localdomain>
 <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
 <20160823162825.GO21682@localhost.localdomain>
 <6b1626c1-d223-4e39-8065-a7421bd3944c@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6b1626c1-d223-4e39-8065-a7421bd3944c@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 25, 2016 at 12:18:47PM +0200, Sylwester Nawrocki wrote:
> On 08/23/2016 06:28 PM, Charles Keepax wrote:
> > I think we should be able to do something requesting the 32k
> > approximately as your existing patch here does, but then
> > requesting the main MCLK from the set_pll and set_sysclk
> > handlers. Eventually I would like the internal SYSCLK and FLLs
> > represented in the clock framework, so I want to have a quick
> > think about how that would migrate over. Let me see what I can
> > come up with here.
> 
> Sounds good, I assume you mean enabling/disabling from the set_pll
> and set_syclk handlers. Do you find any issues with that? I think
> the CODEC should ensure external MCLK is enabled when setting FLL,
> otherwise it will not lock?
> Presumably arizona_set_fll() and arizona_set_sysclk() are places
> where it should be checked what the root source clock is and enable
> it if it's not yet enabled?

Yes so the MCLK needs to be available before we start the FLL, so
my thinking was we would enable the clock that corresponds
to the source for the FLL in arizona_set_fll before we start
enabling the FLL.

The direct MCLK would require a little more work but we could
probably enable the clock in this case from wm5110_sysclk_ev.

I have sent you through a copy of my prototype clock patches you
can have a look at. I am going to have a bit of a look over this
today and hopefully will be able to get back to you with more
concrete thoughts later today.

Thanks,
Charles
