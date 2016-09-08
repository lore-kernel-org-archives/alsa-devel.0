From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v2] clk: x86: Add Atom PMC platform clocks
Date: Thu, 8 Sep 2016 18:08:24 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F329961@irsmsx105.ger.corp.intel.com>
References: <1473266524-14786-1-git-send-email-irina.tirdea@intel.com>
 <20160907235227.GB13062@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160907235227.GB13062@codeaurora.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: linux-clk-owner@vger.kernel.org [mailto:linux-clk-owner@vger.kernel.org] On Behalf Of Stephen Boyd
> Sent: 08 September, 2016 2:52
> To: Tirdea, Irina
> Cc: linux-clk@vger.kernel.org; Michael Turquette; alsa-devel@alsa-project.org; Mark Brown; Takashi Iwai; Bossart, Pierre-louis; Pierre-
> Louis Bossart
> Subject: Re: [PATCH v2] clk: x86: Add Atom PMC platform clocks
> 
> On 09/07, Irina Tirdea wrote:
> > @@ -152,6 +155,17 @@
> >  #define	SLEEP_TYPE_S5		0x1C00
> >  #define	SLEEP_ENABLE		0x2000
> >
> > +struct pmc_clk {
> > +	const char *name;
> > +	unsigned long freq;
> > +	const char *parent_name;
> > +};
> > +
> > +struct pmc_clk_data {
> > +	void __iomem *base;
> > +	const struct pmc_clk *clks;
> > +};
> 
> Can you please put these structures in
> include/linux/platform_data/ with some new file? That way we
> don't need to have any architecture specific configuration to
> test build the clk driver and we can drop the asm include fro
> mthe clk driver too.
> 

Thanks for the review!

Sure, I will make all the changes you pointed out.

I assume I will also need to allow the driver to be compiled if
COMPILE_TEST is set. Is that correct or is there another way
to test build the driver for any architecture?

Thanks,
Irina

