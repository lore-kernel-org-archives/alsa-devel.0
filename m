From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Fri, 28 Aug 2009 14:49:49 +0100
Message-ID: <1251467389.5039.97.camel@finisterre.sirena.org.uk>
References: <20090823101656.GA11491@sirena.org.uk>
	<s5hvdkeiho6.wl%tiwai@suse.de>
	<20090823173828.GA5516@opensource.wolfsonmicro.com>
	<200908280229.40432.marek.vasut@gmail.com>
	(sfid-20090828_013014_083084_BA18122F)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7CE2824366
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 15:51:42 +0200 (CEST)
In-Reply-To: <200908280229.40432.marek.vasut@gmail.com>
	(sfid-20090828_013014_083084_BA18122F)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-08-28 at 02:29 +0200, Marek Vasut wrote:
> Dne Po 24. srpna 2009 09:37:16 Takashi Iwai napsal(a):

> > Merging your changes into topic/asoc, then merging into master or
> > for-next.  So, it seems conflicting with the latest upstream.
> 
> Those patches were made against sound-2.6 from Mark ... I assume some 
> additional stuff was pushed into the kernel after Mark updated his tree.

Yes, there have been changes in mainline since the last time it was
merged up onto the ASoC branch.

> > > Marek, I suggest that you submit the patch to use IRQs against the power
> > > tree. 

> Where would this one be ?

MAINTAINERS says:

POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
P:      Anton Vorontsov
M:      cbou@mail.ru
P:      David Woodhouse
M:      dwmw2@infradead.org
T:      git git://git.infradead.org/battery-2.6.git
S:      Maintained
F:      include/linux/power_supply.h
F:      drivers/power/power_supply*

> > > I also suggest that you submit a version of the battery platform
> > > data changes against the power tree which avoids making the platforms
> > > instabuggy then when that's applied submit changes to Eric to use the
> > > new platform data, making it clear that the machine changes will need to
> > > wait for both power and ALSA trees to be merged during the merge window.
> > > This is the approach that's been suggested previously - it makes life
> > > much easier if changes go through the relevant trees.

> If those changes go through one tree, it'll make them consistent and avoid 
> breakage (because if some of those changes go through the power tree, some 
> through Erics tree ... all of those trees would be broken for some time).

As previously explained these issues would be pretty much dealt with if
you were to ensure that changing the battery driver did not require
immediate updates to the boards. This is the standard technique used to
do this sort of change which affects many trees and generally works
pretty well. As things stand the arch/arm bit shouldn't be split from
the drivers/power change to the platform data.

> I rebased those patches against your tree -- sound-2.6/master -- and attached 
> is the patch that had problems with merging (fixed version). The other patches 
> apply fine.

Please also check that the resulting branch will merge down cleanly into
-next - that's what they'll end up getting merged into.

Also, I've asked you several times to stop sending multiple patches in
one e-mail. As I've said before the fact that you are submitting patches
like this means that they require a special manual workflow to apply.
Have you tried using git format-patch and git send-email to send
patches? I have suggested this to you several times without any
response. These programs will take care of the overwhelming majority of
the technical issues with your submissions - there are example
configurations available for use with gmail.
