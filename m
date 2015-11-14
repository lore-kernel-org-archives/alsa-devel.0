From: Pavel Machek <pavel@ucw.cz>
Subject: Re: multi-codec support for arizona-ldo1 was Re:
 System with multiple arizona (wm5102) codecs
Date: Sat, 14 Nov 2015 18:59:16 +0100
Message-ID: <20151114175915.GA20429@amd>
References: <20150914115439.GA29646@amd> <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd> <20151012154715.GF4238@sirena.org.uk>
 <20151012201137.GA7317@amd> <20151013115355.GC14956@sirena.org.uk>
 <20151113215812.GA19020@amd> <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd> <20151114123931.GW12392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 737CA2612AC
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2015 18:59:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151114123931.GW12392@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, sameo@linux.intel.com, lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi!

> > Obviously I'll need to use the existing interfaces, or extend them as
> > needed. I'd expect subsystem maintainer to know if the existing
> > interfaces are ok or what needs to be fixed, but it seems you either
> > don't know how your subsystem works, or are not willing to tell me.
> 
> I *am* trying to tell you but you appear to not be responding to the
> bits where I'm asking you to look at what's going on on your system.  To
> repeat what you cut from the e-mail you're replying to:
> 
> | Look at how we resolve supplies when we do lookups, then look at how we
> | create aliases for the MFD cells to map supplies into the function
> | devices and figure out why those mappings aren't being found.  The NULL
> | you're seeing above seems like a bit of a warning sign here - where did
> | that come from?
> 
> especially the bit about the NULL which looks likely to be the source of
> your problem.

Well, mfd_core.c seems to call regulator_bulk_register_supply_alias()
with device that does not have dev_name initialized.

I can do this (patch below), but I'm not quite sure it is the right
thing. (This is v4.2 based).

The debug output is then this:

[    1.424740] Initializing arizona-micsupp for codec 2
[    1.429970] Registering expected codec
[    1.434446] mfd_add_device ... arizona-gpio, (null), arizona-gpio
[    1.441004] mfd_add_device ... arizona-gpio,
spi32766.2-arizona-gpio, arizona-gpio
[    1.449449] mfd_add_device ... arizona-haptics, (null),
arizona-haptics
[    1.456594] mfd_add_device ... arizona-haptics,
spi32766.2-arizona-haptics, arizona-haptics
[    1.465629] mfd_add_device ... arizona-pwm, (null), arizona-pwm
[    1.471970] mfd_add_device ... arizona-pwm, spi32766.2-arizona-pwm,
arizona-pwm
[    1.479879] mfd_add_device ... wm5102-codec, (null), wm5102-codec
[    1.486402] mfd_add_device ... wm5102-codec,
spi32766.2-wm5102-codec, wm5102-codec
[    1.494403] Adding alias for supply MICVDD,spi32766.2-wm5102-codec
-> MICVDD,spi32766.2
[    1.502848] Adding alias for supply DBVDD2,spi32766.2-wm5102-codec
-> DBVDD2,spi32766.2
[    1.511279] Adding alias for supply DBVDD3,spi32766.2-wm5102-codec
-> DBVDD3,spi32766.2
[    1.519711] Adding alias for supply CPVDD,spi32766.2-wm5102-codec
-> CPVDD,spi32766.2
[    1.527957] Adding alias for supply SPKVDDL,spi32766.2-wm5102-codec
-> SPKVDDL,spi32766.2
[    1.536583] Adding alias for supply SPKVDDR,spi32766.2-wm5102-codec
-> SPKVDDR,spi32766.2
[    1.546882] vcan: Virtual CAN interface driver

> > Is there someone else I should talk to with respect to regulators-ALSA
> > interface?
> 
> To restate one of my previous questions could you please tell me what
> this "regulators-ALSA" interface you keep talking about is?  In order to
> help you I really need you to at least be looking at the code and
> talking in specifics about it and the concepts it implements.  We
> need

It seems there are more "MICVDD"s then I assumed. 

regulator_bulk_register_supply_alias() results in "Adding alias"
stuff, and then drivers/regulator/arizona-micsupp.c tries to register
another "MICVDD".

And now we have

sound/soc/codecs/wm5102.c, around line 1093:

@@ -1092,7 +1094,6 @@ SND_SOC_DAPM_SUPPLY("ASYNCOPCLK",
ARIZONA_OUTPUT_ASYNC_CLOCK,
 SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
 SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0, 0),
 SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
-SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0,  SND_SOC_DAPM_REGULATOR_BYPASS),
 SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDL", 0, 0),
 SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0, 0),

That is the regulator<->alsa interface I'm talking about. But as you
may recall, I have 2 arizona chips here, so two wm5102.c instances,
and I believe this means that "MICVDD" is not suitable here, and we
want something like "MICVDD,spi32766.2" here.

But a) code does not seem to be quite ready for that, and b) you said
you disliked that approach.

> to be on something like the same page here, at the very least I need you
> to talk about what code you're looking at and what you don't understand
> so I can try to help you follow it but right now I'm just not sure where
> to start, it feels like you're trying to treat a lot of the code as a
> black box without following the abstractions it provides which makes
> things very hard.

Well, the code is pretty close to the black box for me :-(.

I have hardware with two arizona chips, apparently code is not quite
ready for that. I got it to somehow work with some rather ugly hacks,
and I don't see a clear way to non-hacky version.

(For the reference, patch is attached, but it is rather ugly at places.)

> If you're asking about the regulator API or embedded ALSA both of those
> are me but there are other things in here - the driver you're working
> with and the MFD core at least.  At the minute I'm not convinced that
> the problem here isn't just that the MFD and/or MFD core hasn't set up
> the mappings to the child devices properly.

Ok, good. I don't understand how the things are expected to fit
together. See above. I believe SND_SOC_ macros should have another
argument "device", or maybe regulator names should have "device" name
embedded in them.

Best regards,
								Pavel

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 14fd5cb..c05feb4 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -147,6 +147,18 @@ static int mfd_add_device(struct device *parent, int id,
 	pdev->dev.dma_parms = parent->dma_parms;
 	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
 
+
+	printk("mfd_add_device ... %s, %s, %s\n", cell->name, dev_name(&pdev->dev), pdev->name);
+	{
+		char buf[128];
+		sprintf(buf, "%s-%s", dev_name(parent), cell->name);
+		pdev->dev.kobj.name = kstrdup(buf, GFP_KERNEL);
+	}
+
+
+	printk("mfd_add_device ... %s, %s, %s\n", cell->name, dev_name(&pdev->dev), pdev->name);	
+	/* &pdev->dev is not initialized correctly? */
+
 	ret = regulator_bulk_register_supply_alias(
 			&pdev->dev, cell->parent_supplies,
 			parent, cell->parent_supplies,
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 34f3856..0bdf435 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1670,6 +1670,8 @@ int regulator_register_supply_alias(struct device *dev, const char *id,
 	pr_info("Adding alias for supply %s,%s -> %s,%s\n",
 		id, dev_name(dev), alias_id, dev_name(alias_dev));
 
+	WARN_ON(!dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(regulator_register_supply_alias);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
