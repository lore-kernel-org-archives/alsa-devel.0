From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: imx-sdma: advertise all
 supported slave bus widths
Date: Mon, 16 Oct 2017 11:58:36 +0530
Message-ID: <20171016062836.GJ30097@localhost>
References: <20171013104346.16818-1-l.stach@pengutronix.de>
 <20171013112503.5h25exymttetowbk@sirena.co.uk>
 <1507894543.5860.7.camel@pengutronix.de>
 <20171013143901.t5wtxesho2wip4d7@sirena.co.uk>
 <1507906201.5860.9.camel@pengutronix.de>
 <20171013171303.ardykpvxg5tm5q3v@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AB477266DCF
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 08:24:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171013171303.ardykpvxg5tm5q3v@sirena.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patchwork-lst@pengutronix.de, kernel@pengutronix.de, peter.seiderer.ext@zeiss.com, dmaengine@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 13, 2017 at 06:13:03PM +0100, Mark Brown wrote:
> On Fri, Oct 13, 2017 at 04:50:01PM +0200, Lucas Stach wrote:
> > Am Freitag, den 13.10.2017, 15:39 +0100 schrieb Mark Brown:
> =

> > > ...I'm talking about the constraints supported on the DMA side.=A0=A0=
I would
> > > not expect the DMA side to be accepting things it said it didn't supp=
ort.
> =

> > AFAIR the caps for the supported slave bus width were introduced later
> > than other caps and not all drivers did implement them properly, so
> > validation at the core level at this time would probably have broken a
> > lot of existing users.
> =

> > That said the dmaengine core warns since kernel 4.0 if a driver doesn't
> > set those caps, so it's probably fine if we cook up a patch to do the
> > validation now.
> =

> That can should be able to be handled cleanly by enforcing any caps that
> are advertised but if the driver doesn't declare anything at all then
> just accepting anything and leaving it up to the driver to cope.

well DMAengine core cannot guess what hardware supports, but if not provided
we may want to go back to a saner default values which people might support.

But then, not doing this helps people find issues and fix them :)

So which is a better deal?

-- =

~Vinod
