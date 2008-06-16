From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 17:24:53 +0100
Message-ID: <20080616162453.GB8544@sirena.org.uk>
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
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 487DE243AF
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 18:24:58 +0200 (CEST)
Content-Disposition: inline
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 16, 2008 at 11:53:27AM -0400, Jon Smirl wrote:

> static struct platform_device codec = {
> 	.name		= "wm9713-codec",
> 	.id		= -1,
> };

> static struct platform_device platform = {
> 	.name		= "Mainstone-WM9713",
> 	.id		= -1,
> };

> The drivers are creating their own platform devices. Constructing them
> in the driver builds in the assumption that if the driver is loaded,
> then the devices are present.  But that's not right in my case, I have
> four fabric drivers built in and I only want one of them active.

The above is a bodge on two fronts:

 - Currently ASoC doesn't autoprobe AC97 devices (in part because the
   general kernel infrastructure doesn't handle AC97 devices too well,
   in part because V1 didn't).  The platform device is a workaround for
   this.  Hopefully once V2 is out someone will look into this - it'll
   need some hoops jumping through to allow the system to handle clock
   configuration issues at startup.

 - The hardware that's being controlled here is not a standard part of
   the Mainstone hardware, it's a plugin module for them and there's no
   programmatic way to identify exactly what's on one of these boards.
   The devices are registered at module load since the only way to tell
   what's plugged in is via visual inspection of the hardware.

The ideal thing for ARM platforms like this would be that the machine
init code would register appropriate platform devices, allowing the
platform device autoload support to do its thing.
