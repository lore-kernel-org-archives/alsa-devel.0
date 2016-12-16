From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v6 1/3] clk: x86: Add Atom PMC platform
 clocks
Date: Thu, 15 Dec 2016 23:15:37 -0600
Message-ID: <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <20161213232524.GQ5423@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161213232524.GQ5423@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Irina Tirdea <irina.tirdea@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, linux-clk@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Stephen,

can you elaborate on the last comment?

thanks,

-Pierre


On 12/13/2016 05:25 PM, Stephen Boyd wrote:
>
>>> +                                       void __iomem *base,
>>> +                                       const char **parent_names,
>>> +                                       int num_parents)
>>> +{
>>> +       struct clk_plt *pclk;
>>> +       struct clk_init_data init;
>>> +       int ret;
>>> +
>>> +       pclk = devm_kzalloc(&pdev->dev, sizeof(*pclk), GFP_KERNEL);
>>> +       if (!pclk)
>>> +               return ERR_PTR(-ENOMEM);
>>> +
>>> +       init.name =  kasprintf(GFP_KERNEL, "%s%d", PLT_CLK_NAME_BASE, id);
>> devm_kasprintf()
> Please no.
>
>>> +       init.ops = &plt_clk_ops;
>>> +       init.flags = 0;
>>> +       init.parent_names = parent_names;
>>> +       init.num_parents = num_parents;
>>> +
>>> +       pclk->hw.init = &init;
>>> +       pclk->reg = base + id * PMC_CLK_CTL_SIZE;
>>> +       spin_lock_init(&pclk->lock);
>>> +
>>> +       ret = devm_clk_hw_register(&pdev->dev, &pclk->hw);
>>> +       if (ret)
>>> +               goto err_free_init;
>>> +
>>> +       pclk->lookup = clkdev_hw_create(&pclk->hw, init.name, NULL);
>>> +       if (!pclk->lookup) {
>>> +               ret = -ENOMEM;
>>> +               goto err_free_init;
>>> +       }
>>> +
>>> +       kfree(init.name);
>> devm_kfree();
> It's all local to this function, devm isn't helping anything.
> Having one kfree() would be good though. And using init.name for
> the clkdev lookup is probably wrong and should be replaced with
> something more generic along with an associated device name.
I am not sure I understand this last comment.
init.name is not a constant, it's made of the "pmc_plt_clk_" string 
concatenated with an id which directly maps to which hardware clock is 
registered. Clients use devm_clk_get() with a "pmc_plt_clk_<n>" argument.
>

