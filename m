From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Same pci id for different ASUS machine
Date: Tue, 18 Mar 2008 18:57:41 +0000
Message-ID: <20080318185740.GA30373@sirena.org.uk>
References: <1205376529.15217.8.camel@localhost.localdomain>
	<s5hskyvdqgu.wl%tiwai@suse.de>
	<20080317201955.GB10926@serv.smile.org.ua>
	<s5hlk4gufbl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0142410387D
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 19:57:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hlk4gufbl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy@smile.org.ua>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 18, 2008 at 06:12:14PM +0100, Takashi Iwai wrote:
> Andy Shevchenko wrote:

> > example? Could we make more flex configuration in the ALSA instead of
> > hardcoded model= in the modprobe.conf?

> Windows have *.INI files so that they can ignore broken BIOS.  Or in
> other way round - due to this, the hardware vendors never ship the
> correct BIOS!

Worse, fixing the BIOS would probably break driver level workarounds :/

> I have patches to make some stuff dynamically re-configurable,
> e.g. overriding the default pin-config or additional verbs together
> with some hints to the parser, which can be set up via udev etc.

I guess the kernel could do the quirking for most cases by using DMI
information to identify the broken BIOSes, though there are obvious
advantages to user space workarounds so it may not be worth it for
something like sound which is unlikely to be needed to boot.
