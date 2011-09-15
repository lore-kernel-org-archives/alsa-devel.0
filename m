From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [linux-next] ASoC:
	sound/soc/samsung/neo1973_wm8753.c build failure
Date: Thu, 15 Sep 2011 13:53:04 +0200
Message-ID: <4E71E720.7040008@metafoo.de>
References: <1315991893.17271.2.camel@phoenix>
	<20110914191917.GA30518@flint.arm.linux.org.uk>
	<20110914232808.GC2953@opensource.wolfsonmicro.com>
	<20110914233838.GB22946@flint.arm.linux.org.uk>
	<20110915094640.GA7988@opensource.wolfsonmicro.com>
	<20110915110056.GA32615@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E5492451B
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 13:53:44 +0200 (CEST)
In-Reply-To: <20110915110056.GA32615@flint.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>, Harald Welte <laforge@openezx.org>
List-Id: alsa-devel@alsa-project.org

On 09/15/2011 01:00 PM, Russell King wrote:
> [...]
> We now have a sane policy: entries which aren't fully up to date are
> automatically dropped.  Entries for which there is no platform support
> file merged within 12 months of the entries last edit are dropped also
> automatically dropped.

Partly unrelated, but what about these platforms which can be fully described
with DT and don't need a platform file?

> [...]
> Lastly, GTA01 board support was added to the ALSA stuff in 2008 without
> the main platform support in arch/arm - so it can't be usefully used.
> It's been three years since that was done and still there is no sign of
> the main platform support appearing.  It's been five years since the
> entry was created in the machine database.
> 
> Face it, GTA01 is dead as far as mainline is concerned.
> 
> If it's not dead then it needs sorting out.  Either way there's two
> valid states:  1. fully merged, or 2. none of it is merged.
> There's no real half-way house state - certainly not one which should
> persist for three years.  (It would be reasonable for maybe a couple
> of kernel releases but more than that is becoming very much a joke.)

The code for GTA01 is out there and could be merged into mainline, but I think
it would be dead code since there doesn't seem to be really any interest in the
device anymore.

So just get rid of the gta01 portions of the neo1973_wm8753 driver. If GTA01
support ever gets merged we can still revert the removal.

- Lars
