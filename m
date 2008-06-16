From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 11:53:27 -0400
Message-ID: <9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id E084B24375
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:53:31 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so2692049ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 08:53:27 -0700 (PDT)
In-Reply-To: <20080616150337.GB22229@sirena.org.uk>
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
To: Timur Tabi <timur@freescale.com>, ALSA-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 6/16/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 16, 2008 at 10:32:37AM -0400, Jon Smirl wrote:
>  > On 6/16/08, Timur Tabi <timur@freescale.com> wrote:
>  > > Jon Smirl wrote:
>
>  > > > I'd like for the fabric driver to be dynamically loaded by the device
>  > > tree.
>
>  > >  You have a PPC problem, not an ASoC problem.  You're trying to use the
>  > > device tree to load a device without specifying a specific node.  This is
>
>
> ...
>
>
>  > I think I've come up with a solution. Push all of that generic setup
>  > code in mpc8610_hpcd into fsl_ssi. Leave only the platform specific
>  > support in mpc8610_hpcd. Now turn mpc8610_hpcd into a loadable module
>  > but leave it as a platform_driver. During the fsl_ssi probe function
>  > extract the platform name from the device tree and use it to
>  > dynamically load the mpc8610_hpcd driver.
>
>
> That should work from an ASoC point of view.
>
>  As Timur says, this is a PowerPC-specific problem - ASoC v2 itself
>  doesn't care how the various devices get instantiated.  The fabric,
>  codec and SoC drivers can all come up in any order and the core will
>  sort things out.
>
>  OOI, I guess that if there were some visible control on the board (eg, a
>  few controls via GPIO) then this would be less of an issue since there
>  would be real hardware for the machine/fabric driver to control?

This seems to be a more global problem. I'm working on audio devices
so I was putting it into the ASOC bucket.

Some more pieces of the puzzle are starting to come together for me.
It's this type of code is causing the problem. Timur's version of this
is more complicated.

static struct platform_device codec = {
	.name		= "wm9713-codec",
	.id		= -1,
};

static struct platform_device platform = {
	.name		= "Mainstone-WM9713",
	.id		= -1,
};

static struct platform_device *devices[] = {
	&codec,
	&platform,
};

static int __init mainstone_asoc_init(void)
{
	platform_add_devices(&devices[0], ARRAY_SIZE(devices));
	return platform_driver_register(&mainstone_wm9713_driver);
}

The drivers are creating their own platform devices. Constructing them
in the driver builds in the assumption that if the driver is loaded,
then the devices are present.  But that's not right in my case, I have
four fabric drivers built in and I only want one of them active.

The devices are being created in the wrong place. So instead of my
proposal of reading the platform name out of the device tree and
loading the driver from fsl_ssi,  in Timur's case the fabric device
should be created in arch/powerpc/platforms/86xx/mpc8610_hpcd.c.
PowerPC is already capable of making the codec device from the device
tree.

-- 
Jon Smirl
jonsmirl@gmail.com
