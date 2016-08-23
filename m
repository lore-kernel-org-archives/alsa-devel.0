From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [RFC PATCH] mfd: arizona: Add gating of external
 MCLKn clocks
Date: Tue, 23 Aug 2016 18:44:57 +0200
Message-ID: <0c0378e7-918b-1545-1655-43293aed4c8d@samsung.com>
References: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
 <20160822092233.GN21682@localhost.localdomain>
 <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
 <20160822174104.GT22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160822174104.GT22076@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/22/2016 07:41 PM, Mark Brown wrote:
> On Mon, Aug 22, 2016 at 07:22:47PM +0200, Sylwester Nawrocki wrote:
> 
>> If we provided an interface like:
> 
>> struct clk * arizona_get_mclk(struct arizona *arizona, int id);
>> void arizona_put_mclk(struct clk *clk);
> 
>> the machine driver would need to get hold of struct arizona*,
>> which is not that straightforward if we are given only CODEC
>> of_node (it can be a child of I2C or SPI bus).
> 
> We could add an interface for the machine driver to retrieve a clock
> from the CODEC as a transition measure...

That works for me. Is the long term plan to control the CODEC's clocks
through the common clock API in machine drivers and phase out calls
like snd_soc_codec_set_pll(), snd_soc_codec_set_sysclk()?

>> Then how about specifying MCLK in the sound node and using
>> regular devm_clk_get()?
> 
> This is what we're trying to avoid?

Indeed, sorry, I just started getting confused of what are acceptable
tradeoffs here.
