From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 3/4] Support for AC97 on Phytec pmc030
	base board.
Date: Mon, 25 May 2009 10:46:24 +0100
Message-ID: <20090525094624.GB18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013851.3073.79847.stgit@terra>
	<fa686aa40905242334o4867d701n9de332721eb2f3b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 320671037F4
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 11:46:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa686aa40905242334o4867d701n9de332721eb2f3b4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 12:34:57AM -0600, Grant Likely wrote:

> This is ugly.  I'd really rather have a generic mechanism for creating
> a fabric driver based on the OF data.  But failing that, it seems to
> me that this platform device registration should be done in the
> platform code (arch/powerpc/platforms/52xx).  Doing it in a module
> init looks wrong.

It's ugly but it's idiomatic for ASoC until someone has time to
implement multiple card support.

> I was trying to do a sort of generic matching mechanism with the of
> simple stuff; but admittedly it was hacky and half-assed.  However, I

It's adequate for the cases it tries to cover, it just needs to be
merged into the core.  The problem here is AC97 since it can't be probed
until the platform comes up.

> do still think it is viable to have OF hooks that kick in when codec
> and machine drivers are registered.  If linkage data is encoded in the
> device tree, then generic code should be able to hook them up; pulling
> additional data out of the device tree as needed to configure the
> coded.

As I explained in response to Jon's original posting AC97 is a
particular problem here since it can only be probed using the CPU DAI
and may require machine-specific work to set it up prior to use.
There's problems fixing this due to AC97 not having fully developed bus
infrastructure in the kernel at the minute.
