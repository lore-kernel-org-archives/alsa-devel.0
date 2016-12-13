From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Tue, 13 Dec 2016 15:25:24 -0800
Message-ID: <20161213232524.GQ5423@codeaurora.org>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/13, Andy Shevchenko wrote:
> On Fri, Dec 9, 2016 at 8:01 PM, Irina Tirdea <irina.tirdea@intel.com> wrote:
> 
> > --- a/drivers/clk/x86/Makefile
> > +++ b/drivers/clk/x86/Makefile
> > @@ -1,2 +1,5 @@
> >  clk-x86-lpss-objs              := clk-lpt.o
> >  obj-$(CONFIG_X86_INTEL_LPSS)   += clk-x86-lpss.o
> 
> > +ifeq ($(CONFIG_COMMON_CLK), y)
> 
> Hmm... I think (I didn't check) we don't go here otherwise.

We should move this statement to drivers/clk/Makefile around the
x86 line.

> > +                                       void __iomem *base,
> > +                                       const char **parent_names,
> > +                                       int num_parents)
> > +{
> > +       struct clk_plt *pclk;
> > +       struct clk_init_data init;
> > +       int ret;
> > +
> > +       pclk = devm_kzalloc(&pdev->dev, sizeof(*pclk), GFP_KERNEL);
> > +       if (!pclk)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       init.name =  kasprintf(GFP_KERNEL, "%s%d", PLT_CLK_NAME_BASE, id);
> 
> devm_kasprintf()

Please no.

> 
> > +       init.ops = &plt_clk_ops;
> > +       init.flags = 0;
> > +       init.parent_names = parent_names;
> > +       init.num_parents = num_parents;
> > +
> > +       pclk->hw.init = &init;
> > +       pclk->reg = base + id * PMC_CLK_CTL_SIZE;
> > +       spin_lock_init(&pclk->lock);
> > +
> > +       ret = devm_clk_hw_register(&pdev->dev, &pclk->hw);
> > +       if (ret)
> > +               goto err_free_init;
> > +
> > +       pclk->lookup = clkdev_hw_create(&pclk->hw, init.name, NULL);
> > +       if (!pclk->lookup) {
> > +               ret = -ENOMEM;
> > +               goto err_free_init;
> > +       }
> > +
> 
> > +       kfree(init.name);
> 
> devm_kfree();

It's all local to this function, devm isn't helping anything.
Having one kfree() would be good though. And using init.name for
the clkdev lookup is probably wrong and should be replaced with
something more generic along with an associated device name.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
