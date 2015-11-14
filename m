From: Pavel Machek <pavel@ucw.cz>
Subject: Re: multi-codec support for arizona-ldo1 was Re:
 System with multiple arizona (wm5102) codecs
Date: Sat, 14 Nov 2015 22:16:33 +0100
Message-ID: <20151114211633.GE20429@amd>
References: <20151012090045.GA7448@amd> <20151012154715.GF4238@sirena.org.uk>
 <20151012201137.GA7317@amd> <20151013115355.GC14956@sirena.org.uk>
 <20151113215812.GA19020@amd> <20151113225355.GU12392@sirena.org.uk>
 <20151114074400.GA7898@amd> <20151114123931.GW12392@sirena.org.uk>
 <20151114175915.GA20429@amd> <20151114184940.GY12392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34CE826055C
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2015 22:16:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151114184940.GY12392@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

HiOn Sat 2015-11-14 18:49:40, Mark Brown wrote:
> On Sat, Nov 14, 2015 at 06:59:16PM +0100, Pavel Machek wrote:
> 
> > Well, mfd_core.c seems to call regulator_bulk_register_supply_alias()
> > with device that does not have dev_name initialized.
> 
> OK, that'll be the problem then - we're not mapping the supply into the
> individual child device but rather system wide, probably because that
> mapping is being done too early, before we've actually created the
> device.

Take a look at mfd_add_device(). Yes, we do
regulator_bulk_register_supply_alias() before doing
platform_device_add().

> > regulator_bulk_register_supply_alias() results in "Adding alias"
> > stuff, and then drivers/regulator/arizona-micsupp.c tries to register
> > another "MICVDD".
> 
> That's fine because all supplies should be namespaced with a device.
> The goal is to say "Supply X on device Y" (we do support exceptions for
> the few cases where there are not yet any devices involved but this
> clearly isn't one of them).

Well, clearly someone should tell that to wm5102
maintainers. Hmm. It looks like driver is marked supported but there
are no names attached?

WOLFSON MICROELECTRONICS DRIVERS
L:      patches@opensource.wolfsonmicro.com
T:      git git://opensource.wolfsonmicro.com/linux-2.6-asoc
T:      git git://opensource.wolfsonmicro.com/linux-2.6-audioplus
W:
http://opensource.wolfsonmicro.com/content/linux-drivers-wolfson-device\
s
S:      Supported

I guess Charles Keepax should be listed there?

> > And now we have
> 
> > sound/soc/codecs/wm5102.c, around line 1093:
> 
> > @@ -1092,7 +1094,6 @@ SND_SOC_DAPM_SUPPLY("ASYNCOPCLK",
> > ARIZONA_OUTPUT_ASYNC_CLOCK,
> >  SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD2", 0, 0),
> >  SND_SOC_DAPM_REGULATOR_SUPPLY("DBVDD3", 0, 0),
> >  SND_SOC_DAPM_REGULATOR_SUPPLY("CPVDD", 20, 0),
> > -SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0,  SND_SOC_DAPM_REGULATOR_BYPASS),
> >  SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDL", 0, 0),
> >  SND_SOC_DAPM_REGULATOR_SUPPLY("SPKVDDR", 0, 0),
> 
> > That is the regulator<->alsa interface I'm talking about. But as you
> 
> So if you look at this just templates out some boilerplate regulator API
> client code which calls regulator_get() like any other client and then
> hooks that regulator into the audio power management.

Ok, so SND_SOC_DAPM_REGULATOR_SUPPLY() does not work, because I have
two regulators, right? Is there similar macro I can use?

Do you have an example (filename, linenumber) of sound driver that
gets this right? 

> > may recall, I have 2 arizona chips here, so two wm5102.c instances,
> > and I believe this means that "MICVDD" is not suitable here, and we
> > want something like "MICVDD,spi32766.2" here.
> 
> > But a) code does not seem to be quite ready for that, and b) you said
> > you disliked that approach.
> 
> Please go and look at how regulator clients request their supplies and
> how those get resolved into actual supplies - it's exactly the same
> struct device based namespacing that we use for clocks, PWMs and other
> resources.  It's not that I dislike this approach, it's that this
> approach does not make sense in the model we use for requesting supplies
> and is not supported in any way by the code.
> 
> I'm not sure how I can be any clearer that supply names are namespaced
> by client device and that as a result fiddling around with the supply
> name is not going to help anything.

Well, you are saying that pretty clearly, but sound driver I seen
assumes names are global, and /sys interface assumed the names are
global. Give me an example I can look at and I should be able to
figure it out... You are clear, but the kernel code seems to disagree
with you.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
