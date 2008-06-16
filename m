From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 17:58:53 +0100
Message-ID: <20080616165853.GC8544@sirena.org.uk>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
	<9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>
	<9e4733910806160911t3c4e6cecg56b5e6dcee5c5e6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 850C4243B2
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 18:58:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910806160911t3c4e6cecg56b5e6dcee5c5e6a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 16, 2008 at 12:11:31PM -0400, Jon Smirl wrote:

> A more familiar example of this problem is unified graphics drivers.
> NVidia probably has 100 variations on their GPUs. They used to have

Yes, nothing you're doing should be this difficult - it's a very
standard problem.  AFAICT the main issue you're running into here is
that the way the PowerPC device trees are done it's difficult for you to
idomatically do things based on the board type you're running on.

I'm wondering if it might be worth adding some sort of infrastructure
which would allow drivers to load based on the machine type - not by
defining a device type, just by saying "load me on board X"?  This would
be very similar to how DMI information is used on x86 systems to handle
similar situations.

> To do this I'll put all of the device drivers on an initrd. Then as
> the kernel processes the device tree the right drivers will get
> loaded. After the boot process is finished the initrd and unused
> drivers disappear. Moving the fabric device creation in the my
> equivalent of arch/powerpc/platforms/86xx/mpc8610_hpcd.c will let me
> do this.

That's pretty much how most platforms using platform devices would
handle this.

> BTW, if you read in /Documentation about platform drivers they say not
> to make the devices in the module init function because it causes
> problems like the one I'm having.

Right, and this is not expected to happen in production ASoC v2 drivers
- for ARM boards the idomatic thing would be for the setup to happen in
board specific initialisation code under arch/arm.
