From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung: drop unknown Kconfig symbol
Date: Thu, 24 Nov 2011 19:19:26 +0000
Message-ID: <20111124191925.GC3395@opensource.wolfsonmicro.com>
References: <1322155037.25125.61.camel@x61.thuisdomein>
	<20111124172216.GR8470@opensource.wolfsonmicro.com>
	<1322161754.25125.72.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B63B9103E42
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 20:19:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322161754.25125.72.camel@x61.thuisdomein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2011 at 08:09:14PM +0100, Paul Bolle wrote:

> - Kconfig"), both dated May 14, 2007. So I'm touching code here that has
> been unbuildable (in the mainline tree) for over four years. Isn't that
> in itself sufficient to drop this code (and the incomplete kbuild stuff
> supporting it)?

No, not really.  None of the OpenMoko code (including GTA02) has ever
been usable in mainline as there's a reasonable patch stack for it out
of tree and the more of their code is in mainline the more likely it is
that that situation will improve.  The cost of extra platforms is really
very low and people actually send me patches for the OpenMoko devices
from time to time (much more frequently than for most other boards) so
at least someone cares.

> > I'd suggest discussing this with the OpenMoko guys if you want to do it.

> Who would that be?

Google tells me http://www.openmoko.org is a good start - you might want
to ask on the openmoko-kernel list.
