From: John Keeping <john@metanate.com>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add ACPI support
Date: Wed, 17 Aug 2016 11:05:22 +0100
Message-ID: <20160817110522.123de95c.john@metanate.com>
References: <20160814111823.1782-1-john@metanate.com>
	<20160814111823.1782-2-john@metanate.com>
	<20160816172006.GW9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160816172006.GW9347@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Aug 2016 18:20:06 +0100, Mark Brown wrote:

> On Sun, Aug 14, 2016 at 12:18:22PM +0100, John Keeping wrote:
> 
> > The Chromebook Pixel 2015 uses this codec with the ACPI ID RT5677CE, so
> > add an ACPI match table and support for reading properties from ACPI.  
> 
> This would be a lot easier to review with a concrete description of what
> "support for reading properties from ACPI" means and probably also split
> out a bit so that different things were being added separately.

OK, I'll have a think about this, although I'm not sure how much it can
be split up.  We can add the ACPI device property names in a separate
patch and maybe add the match table as a final step, but the GPIO
mapping and probe changes depend on each other.

> > +/* GPIO indexes defined by ACPI */
> > +enum {
> > +	RT5677_GPIO_PLUG_DET,
> > +	RT5677_GPIO_MIC_PRESENT_L,
> > +	RT5677_GPIO_HOTWORD_DET_L,
> > +	RT5677_GPIO_DSP_INT,
> > +	RT5677_GPIO_HP_AMP_SHDN_L,
> > +};  
> 
> If these are an ABI you should explicitly assign the values so that they
> can't get remapped by future edits.  If they're not an ABI I don't
> understand the comment.

Yes, these are ABI.  I'll add explicit values.

> > +	if (ACPI_HANDLE(dev)) {
> > +		u32 val;
> > +
> > +		if (!device_property_read_u32(dev, "DCLK", &val))
> > +			rt5677->pdata.dmic2_clk_pin = val;
> > +
> > +		rt5677->pdata.in1_diff = device_property_read_bool(dev, "IN1");
> > +		rt5677->pdata.in2_diff = device_property_read_bool(dev, "IN2");  
> 
> What happens if someone makes a machine which uses the DT<->ACPI
> mappings (especially given that this is currently undocumented)?  That
> would not work which defeats the whole purpose of using the device
> property APIs.  Shouldn't we be accepting either property?

I'm not sure we want to accept undocumented properties in the DT case.
I went looking for other drivers that have different property names for
ACPI and DT and the only example I could find is:

    drivers/net/ethernet/amd/xgbe/xgbe-main.c

In that case there are separate functions for parsing DT and ACPI
properties.  Having separate functions would have made this patch a lot
clearer, so if we keep the separation between DT and ACPI I'll make that
change for the next round.

The ideal might be to have something similar to the ACPI GPIO mapping
support so that the ACPI device property code could handle the different
names, but that feels like overkill if there are only two drivers that
use different property names in DT and ACPI.
