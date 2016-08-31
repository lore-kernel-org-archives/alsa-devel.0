From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] clk: x86: Add Atom PMC platform clocks
Date: Tue, 30 Aug 2016 20:35:55 -0500
Message-ID: <7c15a844-1351-f1ac-2ad0-3c41455fcc2e@linux.intel.com>
References: <1471459276-11517-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160831003722.GH12510@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160831003722.GH12510@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Thanks for the review, much appreciated.

On 8/30/16 7:37 PM, Stephen Boyd wrote:
> On 08/17, Pierre-Louis Bossart wrote:
>> @@ -414,6 +456,13 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  	if (ret)
>>  		dev_warn(&pdev->dev, "debugfs register failed\n");
>>
>> +	/* Register platform clocks - PMC_PLT_CLK [5:0] */
>> +	clkdev = platform_device_register_data(NULL, "clk-byt-plt", -1,
>> +					       &clks, sizeof(clks));
>
> Shouldn't we register the clk device as a child of the
> registering device? Otherwise it's just floating in the device
> hierarchy?

from a hardware perspective these clocks are pretty much stand-alone and 
independent, there is no real parent/child dependency I can think of and 
having this as 'floating' isn't very far from reality.

>> diff --git a/drivers/clk/x86/clk-byt-plt.c b/drivers/clk/x86/clk-byt-plt.c
>> new file mode 100644
>> index 0000000..330cd35
>> --- /dev/null
>> +++ b/drivers/clk/x86/clk-byt-plt.c
>> @@ -0,0 +1,413 @@
>> +
>> +static int plt_pmc_atom_update(struct clk_plt *clk, u32 mask, u32 val)
>> +{
>> +	int ret;
>> +	u32 orig, tmp;
>> +	unsigned long flags = 0;
>> +
>> +	spin_lock_irqsave(&clk->lock, flags);
>> +
>> +	ret = pmc_atom_read(clk->offset, &orig);
>> +	if (ret)
>> +		goto out;
>> +
>> +	tmp = orig & ~mask;
>> +	tmp |= val & mask;
>> +
>> +	if (tmp == orig)
>> +		goto out;
>> +
>> +	ret = pmc_atom_write(clk->offset, tmp);
>
> It's sad that this can't be compiled on any platform. Has there
> been any move towards making this into a regmap provider so that
> this clk driver can use cross platform regmap APIs instead? Or
> even passing the __iomem pointer through platform data or
> something so that we can use readl/writel APIs directly instead
> of pmc_atom_write()/read()?

it's not clear to me what cross-platform goals you are hinting at and 
what the concern is. We can add more framework stuff and make the code 
more elegant but at the end of the day we will write in a very limited 
set of registers (2 for audio - on/off and 19.2/25MHz selection) and the 
use of this functionality is restricted to Baytrail and Cherrytrail.

