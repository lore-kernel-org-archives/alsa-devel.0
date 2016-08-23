From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC PATCH] mfd: arizona: Add gating of external
 MCLKn clocks
Date: Tue, 23 Aug 2016 17:28:25 +0100
Message-ID: <20160823162825.GO21682@localhost.localdomain>
References: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
 <20160822092233.GN21682@localhost.localdomain>
 <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2016 at 07:22:47PM +0200, Sylwester Nawrocki wrote:
> On 08/22/2016 11:22 AM, Charles Keepax wrote:
> > Yeah I am not sure this is quite the correct approach, there are
> > quite a few corner cases that would not be covered well here. For
> > example an internally divided down 32k in which case both the 32k
> > and MCLK would come from the same pin, or using the 32k to feed
> > an FLL in which case we are trying to enable MCLK1 unnecessarily.
> > 
> > I think we could request the 32k clock source from this part
> > of the code, but without implementing clock drivers for the
> > chips internal clocking I think the main MCLK would need to be
> > requested from the machine driver for now.
> > 
> > On that note, I have been working on a patch chain that adds an
> > actual clock driver for the chip unfortunately this has been
> > delayed somewhat due to issues interfacing SPI backed clocks to
> > the clock framework. Krzysztof Kozlowski has sent a series that
> > appears to resolve these issues for me so hopefully once the
> > clock guys have had a look at that I can send my clock driver.
> > My current implementation mostly just implements the 32k clock
> > but we can start building that out to include the SYSCLKs and
> > FLLs etc. fairly quickly. The best thing might be to wait for
> > that and then build additional features onto that.
> > 
> > Let me know if you want to get an early look at that code.
> 
> Thanks for the feedback.  I would really like to avoid touching
> this code and messing up anything in code shared by multiple
> CODECs.  You certainly know it much better than than I do.
> 
> I got suggestion from Mark not to request the main MCLK clock
> in the machine driver.  But even if gating of that clock was
> added to the CODEC driver I would need to get hold of it in
> the machine driver to get rate of MCLK.  So I thought about
> exporting a helper from the MFD for requesting MCLK clock or
> specifying MCLK clock back in the sound DT node.
> 
> IIUC, you are suggesting to leave the 32k parts of the patch 
> and just drop the MCLK part?
> 

I would certainly be ok with that it is very similar to what my
patch does but done from the MFD driver rather than moving things
out into a clock driver. Although it looks like in this case we
need to solve both clocks for it to be useful to you.

> If we provided an interface like:
> 
> struct clk * arizona_get_mclk(struct arizona *arizona, int id);
> void arizona_put_mclk(struct clk *clk);
> 
> the machine driver would need to get hold of struct arizona*,
> which is not that straightforward if we are given on CODEC
> of_node (it can be a child of I2S or SPI bus).
> 
> Then how about specifying MCLK in the sound node and using
> regular devm_clk_get()?
> 

Yeah I think we want to avoid specifying the MCLK in the sound
node as it really is a clock the codec consumes so should be
defined there in the DT.

> Regarding the clock locking patches, I think it needs some more 
> discussion and should rather be merged early in the development
> cycle to have good exposure in -next as it's quite an invasive
> change.
> 

I would agree there, and I am not sure how clear it is what the
clock guys will make of the approach yet as well. Which might
cause issues if we want to merge something now.

> I'd be happy to look at your code, if only to have a better 
> overview and to avoid interfering with you work.
> 

I am afraid I haven't managed to get time today but I will fire
you an email with my current work in progress stuff, hopefully
tomorrow.

> Anyway, my main goal is only to get the tm2_wm5110 sound card
> upstream, with as little casualties as possible;)

Apologies it seems I missed another version of this on the
mailing list, please do feel free to add me or the
patches@opensource.wolfsonmicro.com list as a direct CC on
any patches using our CODECs, I am always more than happy to look
over things and feel bad when I miss stuff. I will have a look
at the latest version of the patch.

I think we should be able to do something requesting the 32k
approximately as your existing patch here does, but then
requesting the main MCLK from the set_pll and set_sysclk
handlers. Eventually I would like the internal SYSCLK and FLLs
represented in the clock framework, so I want to have a quick
think about how that would migrate over. Let me see what I can
come up with here.

Thanks,
Charles
