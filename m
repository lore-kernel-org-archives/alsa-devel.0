From: Timur Tabi <timur@freescale.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 11:01:36 -0500
Message-ID: <48568E60.10206@freescale.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>	
	<1213612755.6599.51.camel@odin>	
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>	
	<4856776B.7040300@freescale.com>	
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>	
	<20080616150337.GB22229@sirena.org.uk>
	<9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D40B52439A
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 18:01:41 +0200 (CEST)
In-Reply-To: <9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> The drivers are creating their own platform devices. Constructing them
> in the driver builds in the assumption that if the driver is loaded,
> then the devices are present.  But that's not right in my case, I have
> four fabric drivers built in and I only want one of them active.

You have two choices:

1) Load all drivers.  In each driver's __init section, let it determine whether
it should load or not.  If not, it can fail silently.  Off the top of my head, I
don't remember how to do that.

2) Use the Kernel Module Loader to dynamically load the module you want.  I
don't know how this works either.

> The devices are being created in the wrong place. So instead of my
> proposal of reading the platform name out of the device tree and
> loading the driver from fsl_ssi,  in Timur's case the fabric device
> should be created in arch/powerpc/platforms/86xx/mpc8610_hpcd.c.
> PowerPC is already capable of making the codec device from the device
> tree.

True, but I chose to keep it in sound/soc/fsl so that I wouldn't have to push 3
drivers to alsa-devel and one driver to linuxppc-dev.

-- 
Timur Tabi
Linux kernel developer at Freescale
