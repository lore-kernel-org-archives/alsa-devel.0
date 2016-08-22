From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [RFC PATCH] mfd: arizona: Add gating of external
 MCLKn clocks
Date: Mon, 22 Aug 2016 19:22:47 +0200
Message-ID: <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
References: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
 <20160822092233.GN21682@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160822092233.GN21682@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/22/2016 11:22 AM, Charles Keepax wrote:
> Yeah I am not sure this is quite the correct approach, there are
> quite a few corner cases that would not be covered well here. For
> example an internally divided down 32k in which case both the 32k
> and MCLK would come from the same pin, or using the 32k to feed
> an FLL in which case we are trying to enable MCLK1 unnecessarily.
> 
> I think we could request the 32k clock source from this part
> of the code, but without implementing clock drivers for the
> chips internal clocking I think the main MCLK would need to be
> requested from the machine driver for now.
> 
> On that note, I have been working on a patch chain that adds an
> actual clock driver for the chip unfortunately this has been
> delayed somewhat due to issues interfacing SPI backed clocks to
> the clock framework. Krzysztof Kozlowski has sent a series that
> appears to resolve these issues for me so hopefully once the
> clock guys have had a look at that I can send my clock driver.
> My current implementation mostly just implements the 32k clock
> but we can start building that out to include the SYSCLKs and
> FLLs etc. fairly quickly. The best thing might be to wait for
> that and then build additional features onto that.
> 
> Let me know if you want to get an early look at that code.

Thanks for the feedback.  I would really like to avoid touching
this code and messing up anything in code shared by multiple
CODECs.  You certainly know it much better than than I do.

I got suggestion from Mark not to request the main MCLK clock
in the machine driver.  But even if gating of that clock was
added to the CODEC driver I would need to get hold of it in
the machine driver to get rate of MCLK.  So I thought about
exporting a helper from the MFD for requesting MCLK clock or
specifying MCLK clock back in the sound DT node.

IIUC, you are suggesting to leave the 32k parts of the patch 
and just drop the MCLK part?

If we provided an interface like:

struct clk * arizona_get_mclk(struct arizona *arizona, int id);
void arizona_put_mclk(struct clk *clk);

the machine driver would need to get hold of struct arizona*,
which is not that straightforward if we are given on CODEC
of_node (it can be a child of I2S or SPI bus).

Then how about specifying MCLK in the sound node and using
regular devm_clk_get()?

Regarding the clock locking patches, I think it needs some more 
discussion and should rather be merged early in the development
cycle to have good exposure in -next as it's quite an invasive
change.

I'd be happy to look at your code, if only to have a better 
overview and to avoid interfering with you work.

Anyway, my main goal is only to get the tm2_wm5110 sound card
upstream, with as little casualties as possible;)

--
Thanks, 
Sylwester
