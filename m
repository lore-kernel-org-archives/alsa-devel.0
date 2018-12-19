From: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
 device
Date: Wed, 19 Dec 2018 16:01:03 +0100
Message-ID: <20181219150103.GA52375@gerhold.net>
References: <3b96d716-1d9f-a569-2afa-82b386e752e4@linux.intel.com>
 <20181217181729.GB845@gerhold.net>
 <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
 <20181217191054.GA10938@gerhold.net>
 <d5755c1c-f9d6-5bed-73ee-00a24d36fccc@linux.intel.com>
 <20181217203242.GB10938@gerhold.net>
 <20181217204320.GC10938@gerhold.net>
 <86b92282-5bc1-b8de-93e7-97e7ee17db4b@linux.intel.com>
 <20181219130747.GA83656@gerhold.net>
 <f3c2105e-ac56-9be3-eff7-78ef2b0560ac@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DDE426770D
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 16:01:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f3c2105e-ac56-9be3-eff7-78ef2b0560ac@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 19, 2018 at 08:04:35AM -0600, Pierre-Louis Bossart wrote:
> On 12/19/18 7:07 AM, Stephan Gerhold wrote:
> > On Mon, Dec 17, 2018 at 08:13:36PM -0600, Pierre-Louis Bossart wrote:
> > > 
> > > > > > > The quirks to get sound working with bytcr-rt5640 on that device are:
> > > > > > > BYT_RT5640_SSP0_AIF1 | BYT_RT5640_IN1_MAP | BYT_RT5640_MCLK_EN
> > > > > > > 
> > > > > > > I guess this means that SSP0 is being used?
> > > > > > Yes indeed, and that makes me think we should force this device to look like
> > > > > > Baytrail-CR.
> > > > > > 
> > > > > > You can do this with a DMI-based quirk (preferably in is_byt_cr directly so
> > > > > > that I can reuse the code when I move it to a helper at some point).
> > > > > Okay - thanks! One last question:
> > > > > I was looking at the ACPI DSDT tables of some similar devices and have
> > > > > found two others that look the same (only one IRQ listed). In this case,
> > > > > the BYT-T acpi_ipc_irq_index = 5 will never work, and we will definitely
> > > > > have a better chances with trying Baytrail-CR.
> > > > > 
> > > > > One of them actually had a similar patch proposed at [1] (although they
> > > > > did it in a weird way and also need an extra machine driver).
> > > > > 
> > > > > We could also detect this situation in a generic way with something like
> > > > > 
> > > > >     if (platform_irq_count(pdev) == 1) {
> > > > >     	*bytcr = true;
> > > > > 	return 0;
> > > > >     }
> > > > > 
> > > > > ... instead of a DMI quirk. What do you think?
> > > > > 
> > > > To avoid confusion: The existing PMIC-type based is_byt_cr() detection
> > > > would be used in all other cases (i.e. if irq_count != 1), so it won't
> > > > make any difference for the devices that are already working fine.
> > > > (Most BYT-CR devices seem to have 5 IRQs listed)
> > > > 
> > > > So it's more like
> > > > 
> > > >     if (platform_irq_count(pdev) == 1) {
> > > >     	*bytcr = true;
> > > >     } else {
> > > >     	// pmic-type based detection...
> > > >     }
> > > > 
> > > > with platform_irq_count == 1 as condition for the "quirk".
> > > 
> > > The solution seems appealing but
> > > 
> > > 1) does it really work? I am not sure an index=5 means there are 5
> > > interrupts.
> > 
> > Yes, I believe that it means that there need to be (at least) 5
> > interrupts.
> > 
> > I have checked the source code of platform_get_irq.
> > When you do platform_get_irq(pdev, /* index = */ 5) (as done for BYT-T)
> > it first calls
> > 
> >      platform_get_resource(/* type = */ IORESOURCE_IRQ, /* num = */ 5)
> > 
> > to lookup the resource. That method is really simple and looks like
> > 
> > 	for (i = 0; i < dev->num_resources; i++) {
> > 		struct resource *r = &dev->resource[i];
> > 
> > 		if (type == resource_type(r) && num-- == 0)
> > 			return r;
> > 	}
> > 
> > So when you request an IRQ at index=5, it loops through all resources,
> > skips the first 5 IRQs and returns the 6th one (on my device, it
> > returns NULL because there are not enough IRQs listed).
> > 
> > There is a bit more magic in platform_irq_count (it looks up all IRQs
> > and does not count invalid ones), so to be absolutely safe we could
> > just check platform_get_resource(IRQ, 5) == NULL early.
> > If it returns NULL, then platform_get_irq(pdev, 5) will also return
> > -ENXIO, so treating the device as BYT-T is guaranteed to fail.
> > In this case, we have better chances when we assume BYT-CR.
> > 
> > Example patch: (I have added it in probe instead of is_byt_cr() because
> > it requires the platform device, plus I think it might be better to
> > differentiate the messages in the kernel log..)
> > 
> > --- a/sound/soc/intel/atom/sst/sst_acpi.c
> > +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> > @@ -337,6 +337,16 @@ static int sst_acpi_probe(struct platform_device *pdev)
> >   	if (!((ret < 0) || (bytcr == false))) {
> >   		dev_info(dev, "Detected Baytrail-CR platform\n");
> > 
> >   		/* override resource info */
> >   		byt_rvp_platform_data.res_info = &bytcr_res_info;
> > +	} else if (platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL) {
> > +		/*
> > +		 * Some devices detected as BYT-T have only a single IRQ listed.
> > +		 * In this case, platform_get_irq with index 5 will return -ENXIO.
> > +		 * Fall back to the BYT-CR resource info to use the correct IRQ.
> > +		 */
> > +		dev_info(dev, "Falling back to Baytrail-CR platform\n");
> > +
> > +		/* override resource info */
> > +		byt_rvp_platform_data.res_info = &bytcr_res_info;
> >   	}
> > 
> > > 
> > > 2) the test would affect all existing devices, and there's so much hardware
> > > proliferation that proving this change in harmless might be difficult. I
> > > personally only have one BYT-T (ASus T100) device left and it's not very
> > > reliable. Hans seems to have a ton of devices but they are mostly Byt-Cr?
> > > 
> > 
> > With the updated patch above I believe there is literally no way this
> > can break sound on any device. The condition only evaluates to true if
> > SST would normally fail to probe later anyway.
> > 
> > I have tested the patch above on my device with:
> >   - as-is, without any modifications:
> >      -> "Falling back to Baytrail-CR platform", sound now working
> >   - a simulated "BYT-T" device: (copied the IRQs from the DSDT of the T100TA)
> >      -> "BYT-CR not detected" - uses 5th IRQ, sound working
> >   - a simulated "BYT-CR" device (made is_byt_cr() return "true" and
> >     copied the IRQs from the DSDT of the T100TAF)
> >      -> "Detected Baytrail-CR platform" - uses IRQ at index 0, sound working
> > 
> > Let me know what you think!
> 
> Sounds good, playing with resources is what I had in mind rather than an
> interrupt count which isn't necessarily safe. The only improvement I would
> suggest is to add this test inside of is_byt_cr(). This routine will be
> moved as a helper outside of sst_acpi to be reused for SOF, so if we can
> make this test more self-contained it's more future-proof.
> 

Hmm. Part of why I put it outside of is_byt_cr() is so that the 
pmic-type based detection always runs, and my new check is only used as 
a fallback. That allows us to see in the log if the device was 
detected as BYT-CR through the pmic detection or if BYT-CR is just used 
as fallback. (Might be useful for troubleshooting in the future..)

The design of is_byt_cr() with multiple returns (and even more so the 
SOF refactored version at [1]) makes it a bit difficult for me to apply 
this fallback after the detection, at least if this is supposed to be a 
single method.

So we can either

(1) Skip pmic-based detection if
    platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL:

--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -255,10 +255,18 @@ static int is_byt(void)
 	return status;
 }
 
-static int is_byt_cr(struct device *dev, bool *bytcr)
+static int is_byt_cr(struct platform_device *pdev, bool *bytcr)
 {
+	struct device *dev = &pdev->dev;
 	int status = 0;
 
+	if (platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL) {
+		/* This message is even shown if the device would be detected as BYT-CR below */
+		dev_info(dev, "Falling back to Baytrail-CR platform\n");
+		*bytcr = true;
+		return status;
+	}
+
 	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
 		u32 bios_status;

or
(2) Rename is_byt_cr() to something like is_bytcr_pmic() and wrap it 
    with a new method:

static int is_byt_cr(struct platform_device *pdev, bool *bytcr)
{
	int status = is_byt_cr_pmic(&pdev->dev, bytcr);
	if (!*bytcr && platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL) {
		*bytcr = true;
		dev_info(&pdev->dev, "Falling back to Baytrail-CR platform\n");
		return 0;
	}
	return status;
}

The end result is the same. The only difference is if we also log the 
result of the pmic-based detection.

Which one do you prefer? (Or any other suggestions?)

[1]: https://github.com/thesofproject/linux/blob/43b4e383f85446a7f43f7fd19f382d344afb7d62/sound/soc/sof/sof-acpi-dev.c#L75-L105
