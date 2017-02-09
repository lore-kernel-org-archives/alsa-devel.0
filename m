From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v1 1/4] ASoC: Intel: common: Replace custom
 implementation of readq / writeq
Date: Thu, 9 Feb 2017 09:26:38 +0530
Message-ID: <20170209035638.GJ19244@localhost>
References: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
 <20170206170353.GE19244@localhost>
 <1486555175.2133.384.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EF693267174
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 04:56:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1486555175.2133.384.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 08, 2017 at 01:59:35PM +0200, Andy Shevchenko wrote:
> On Mon, 2017-02-06 at 22:33 +0530, Vinod Koul wrote:
> > On Tue, Jan 31, 2017 at 04:14:22PM +0200, Andy Shevchenko wrote:
> > > The readq() and writeq() helpers are available in the
> > > linux/io-64-nonatomic-hi-lo.h and linux/io-64-nonatomic-lo-hi.h
> > > headers.
> > > =

> > > Replace custom implementation by the generic helpers.
> > > =

> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > =A0sound/soc/intel/common/sst-dsp.c | 9 ++++-----
> > > =A01 file changed, 4 insertions(+), 5 deletions(-)
> > > =

> > > diff --git a/sound/soc/intel/common/sst-dsp.c
> > > b/sound/soc/intel/common/sst-dsp.c
> > > index 11c0805393ff..748f1f5c02df 100644
> > > --- a/sound/soc/intel/common/sst-dsp.c
> > > +++ b/sound/soc/intel/common/sst-dsp.c
> > > @@ -22,6 +22,8 @@
> > > =A0#include <linux/io.h>
> > > =A0#include <linux/delay.h>
> > > =A0
> > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > +
> > > =A0#include "sst-dsp.h"
> > > =A0#include "sst-dsp-priv.h"
> > > =A0
> > > @@ -43,16 +45,13 @@ EXPORT_SYMBOL_GPL(sst_shim32_read);
> > > =A0
> > > =A0void sst_shim32_write64(void __iomem *addr, u32 offset, u64 value)
> > > =A0{
> > > -	memcpy_toio(addr + offset, &value, sizeof(value));
> > > +	lo_hi_writeq(value, addr + offset);
> > =

> > why not use writeq here and for 32bit this becomes lo_hi_writeq(), or
> > did I
> > miss something here..
> =

> I'm not sure our hardware will correctly handle writeq()/readq().
> OCP bus which is quite likely used internally is 32-bit bus.

Yes it is a 32 bit bus, but then we have a bridge which splilts it up. So it
should work, would be worth to test this and update.

-- =

~Vinod
