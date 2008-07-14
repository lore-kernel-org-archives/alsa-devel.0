From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
Date: Mon, 14 Jul 2008 10:13:14 -0400
Message-ID: <9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D9082436D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 16:13:16 +0200 (CEST)
Received: by el-out-1112.google.com with SMTP id o28so760253ele.2
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2008 07:13:15 -0700 (PDT)
In-Reply-To: <20080714134930.GC25448@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com
List-Id: alsa-devel@alsa-project.org

On 7/14/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 12, 2008 at 02:39:29AM -0600, Grant Likely wrote:
>
>  > Simple utility layer for creating ASoC machine instances based on data
>  > in the OpenFirmware device tree.  OF aware platform drivers and codec
>  > drivers register themselves with this framework and the framework
>  > automatically instantiates a machine driver.
>
>
> Ideally someone from the PowerPC community would sign off on this -
>  given the nature and volume of discussion people obviously have very
>  strong opinions about how machine drivers should be done so I'd really
>  like to see some community buy in for something like this.  From an ASoC
>  point of view if this works it's fine.


Grant is one of the core PowerPC developers. There's no big
disagreement on the driver model, there just isn't a clean solution
for building a PowerPC ASoC driver under ASoC v1.  The ASoC v1 driver
model is simply not compatible with the PowerPC device tree model.
That's why all of this glue code is needed.

Hopefully we can get the driver model sorted out in v2. If the ASoC
driver model is fixed all of this glue code disappears.

The PowerPC side isn't without fault too. PowerPC still doesn't have a
good way to load the fabric/machine driver.

Which are we going to call it, fabric or machine? I had been working
on the Apple code in sound/aoa. It is called fabric in that code. The
equivalent driver is called machine in ASoC v1.

>
>
>  > This is most likely temporary glue code to work around limitations in
>  > the ASoC v1 framework.  I expect ASoC v2 won't need this.
>
>
> It will need some way of providing a machine driver, generic (like this
>  one) or otherwise.
>
>
>  > +static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
>  > +{
>  > +     struct platform_device *pdev;
>  > +     int rc;
>  > +
>  > +     /* Only register the device if both the codec and platform have
>  > +      * been registered */
>  > +     if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
>  > +             return;
>  > +
>  > +     pr_info("platform<-->codec match achieved; registering machine\n");
>
>
> So what this does is add an extremely simple machine driver which
>  matches up the first DAI on a single codec and platform with no facility
>  for setting up any configurable clocking or anything?  This is fine in
>  so far as it goes but it's going to work for very few systems as it is -
>  most codecs will need some additional configuration.  This could be
>  added later, though.
>
>  Given this it might be worth renaming it to something less generic and
>  perhaps pushing it down into an of directory below the main ASoC
>  directory to parallel existing machine drivers.  I'm happy with the code
>  from an ASoC point of view.
>


-- 
Jon Smirl
jonsmirl@gmail.com
