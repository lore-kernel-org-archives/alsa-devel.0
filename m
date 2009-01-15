From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR init
 bug.
Date: Thu, 15 Jan 2009 16:45:31 -0500
Message-ID: <20090115164531.82d6159c.hugo@hugovil.com>
References: <20090108121613.1ef53112.hugo@hugovil.com>
	<1232051992-31817-1-git-send-email-hugo@hugovil.com>
	<20090115205748.GJ12768@sirena.org.uk>
	<20090115160257.f35c440d.hugo@hugovil.com>
	<20090115210908.GK12768@sirena.org.uk>
	<20090115161700.4d671c05.hugo@hugovil.com>
	<20090115214040.GA5909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id BC37C10389E
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 22:45:33 +0100 (CET)
In-Reply-To: <20090115214040.GA5909@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jan 2009 21:40:41 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> On Thu, Jan 15, 2009 at 04:17:00PM -0500, Hugo Villeneuve wrote:
> > Mark Brown <broonie@sirena.org.uk> wrote:
> 
> > > Sounds like that should be fixed instead, then?
> 
> > If someone wants to fix it, fine. I tried but couldn?t find what is
> > wrong. Maybe the person who added that piece of code (not me) should
> > fix it...
> 
> It was added by David Brownell to prevent the module being used on the
> wrong hardware, which is perfectly reasonable.  The machine_is_foo()
> tests are a very standard part of the ARM infrastructure and are
> widely used - if they're not working that's where the fix is.  Are
> you sure that your .config has MACH_SFFSDR set?  There appears to be
> no mainline support for the core machine so you'd have to have
> patched that in...

I just found the cause. I created the SFFSDR machine on the ARM
website, and this automatically defined the macro CONFIG_MACH_SFFSDR,
and not CONFIG_MACH_DAVINCI_SFFSDR like it is currently in the Kconfig.

I will submit a patch to rename CONFIG_MACH_DAVINCI_SFFSDR to
CONFIG_MACH_SFFSDR in the Kconfig file.

Thank-you everyone for your help.

Hugo.

---------------
Hugo Villeneuve
www.hugovil.com
---------------
