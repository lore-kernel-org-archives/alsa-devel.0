From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v7 2/5] clk: x86: Add Atom PMC platform
 clocks
Date: Sat, 21 Jan 2017 10:28:17 -0600
Message-ID: <e201d2f3-6a14-f00f-3de0-1a68a2816f42@linux.intel.com>
References: <1484690270-28425-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1484690270-28425-3-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20170120235856.GF20800@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170120235856.GF20800@codeaurora.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, x86@kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the review Stephen.

On 1/20/17 5:58 PM, Stephen Boyd wrote:
> On 01/17, Pierre-Louis Bossart wrote:
>> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
>> new file mode 100644
>> index 0000000..312d4e9
>> --- /dev/null
>> +++ b/drivers/clk/x86/clk-pmc-atom.c
> [...]
>> +
>> +static void plt_clk_reg_update(struct clk_plt *clk, u32 mask, u32 val)
>> +{
>> +	u32 tmp;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&clk->lock, flags);
>> +
>> +	tmp = clk_readl(clk->reg);
>
> Do you need to use clk_readl? I'd prefer we deleted that
> function/macro because it's just confusing. Please don't use it
> unless you need it for some reason.

I just followed Andy's recommendation and will revert to readl/writel, 
as well as fix the nitpicks below
>
>> +	tmp = (tmp & ~mask) | (val & mask);
>> +	clk_writel(tmp, clk->reg);
>> +
>> +	spin_unlock_irqrestore(&clk->lock, flags);
>> +}
>> +
> [..]
>> +
>> +static void plt_clk_unregister_parents(struct clk_plt_data *data)
>> +{
>> +	plt_clk_unregister_fixed_rate_loop(data, data->nparents);
>> +}
>> +
>> +
>
> Nitpick: Single newline please

ok

>> +static struct platform_driver plt_clk_driver = {
>> +	.driver = {
>> +		.name = PLT_CLK_DRIVER_NAME,
>
> Nitpick: Just put the string here

ok
