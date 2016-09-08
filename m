From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: x86: Add Atom PMC platform clocks
Date: Thu, 8 Sep 2016 12:39:52 -0700
Message-ID: <bb55c314-456e-ecff-541c-08cb2a62cd79@codeaurora.org>
References: <1473266524-14786-1-git-send-email-irina.tirdea@intel.com>
 <20160907235227.GB13062@codeaurora.org>
 <1F3AC3675D538145B1661F571FE1805F2F329961@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F329961@irsmsx105.ger.corp.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 09/08/2016 11:08 AM, Tirdea, Irina wrote:
>
>> -----Original Message-----
>> From: linux-clk-owner@vger.kernel.org [mailto:linux-clk-owner@vger.kernel.org] On Behalf Of Stephen Boyd
>> Sent: 08 September, 2016 2:52
>> To: Tirdea, Irina
>> Cc: linux-clk@vger.kernel.org; Michael Turquette; alsa-devel@alsa-project.org; Mark Brown; Takashi Iwai; Bossart, Pierre-louis; Pierre-
>> Louis Bossart
>> Subject: Re: [PATCH v2] clk: x86: Add Atom PMC platform clocks
>>
>> On 09/07, Irina Tirdea wrote:
>>> @@ -152,6 +155,17 @@
>>>  #define	SLEEP_TYPE_S5		0x1C00
>>>  #define	SLEEP_ENABLE		0x2000
>>>
>>> +struct pmc_clk {
>>> +	const char *name;
>>> +	unsigned long freq;
>>> +	const char *parent_name;
>>> +};
>>> +
>>> +struct pmc_clk_data {
>>> +	void __iomem *base;
>>> +	const struct pmc_clk *clks;
>>> +};
>> Can you please put these structures in
>> include/linux/platform_data/ with some new file? That way we
>> don't need to have any architecture specific configuration to
>> test build the clk driver and we can drop the asm include fro
>> mthe clk driver too.
>>
> Thanks for the review!
>
> Sure, I will make all the changes you pointed out.
>
> I assume I will also need to allow the driver to be compiled if
> COMPILE_TEST is set. Is that correct or is there another way
> to test build the driver for any architecture?

Yes that's good too. Individual files can be compiled standalone with
"make foo.o" even when they're not enabled in the Kconfig.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

