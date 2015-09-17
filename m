From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v1 1/1] sst: replace custom implementation
 of readq / writeq
Date: Thu, 17 Sep 2015 10:24:04 +0100
Message-ID: <1442481844.2520.19.camel@loki>
References: <1440677358-6681-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1442480279.8361.73.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 449D9265284
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 11:24:16 +0200 (CEST)
In-Reply-To: <1442480279.8361.73.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-09-17 at 11:57 +0300, Andy Shevchenko wrote:
> On Thu, 2015-08-27 at 15:09 +0300, Andy Shevchenko wrote:
> > The readq() and writeq() helpers are available in the
> > asm-generic/io-64-nonatomic-hi-lo.h and asm-generic/io-64-nonatomic
> > -lo-hi.h
> > headers. Replace custom implementation by the generic helpers.
> > 
> 
> Liam, any comments on this?

Looks good from me, but it's one of Vinod's drivers (now added to CC).

Liam

> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  sound/soc/intel/atom/sst/sst_pvt.c | 16 ++++++----------
> >  sound/soc/intel/common/sst-dsp.c   |  9 ++++-----
> >  2 files changed, 10 insertions(+), 15 deletions(-)
> > 
> > diff --git a/sound/soc/intel/atom/sst/sst_pvt.c 
> > b/sound/soc/intel/atom/sst/sst_pvt.c
> > index adb32fe..6cc222d 100644
> > --- a/sound/soc/intel/atom/sst/sst_pvt.c
> > +++ b/sound/soc/intel/atom/sst/sst_pvt.c
> > @@ -31,7 +31,10 @@
> >  #include <sound/pcm.h>
> >  #include <sound/soc.h>
> >  #include <sound/compress_driver.h>
> > +
> > +#include <asm-generic/io-64-nonatomic-lo-hi.h>
> >  #include <asm/platform_sst_audio.h>
> > +
> >  #include "../sst-mfld-platform.h"
> >  #include "sst.h"
> >  #include "../../common/sst-dsp.h"
> > @@ -49,25 +52,18 @@ u32 sst_shim_read(void __iomem *addr, int offset)
> >  
> >  u64 sst_reg_read64(void __iomem *addr, int offset)
> >  {
> > -	u64 val = 0;
> > -
> > -	memcpy_fromio(&val, addr + offset, sizeof(val));
> > -
> > -	return val;
> > +	return readq(addr + offset);
> >  }
> >  
> >  int sst_shim_write64(void __iomem *addr, int offset, u64 value)
> >  {
> > -	memcpy_toio(addr + offset, &value, sizeof(value));
> > +	writeq(value, addr + offset);
> >  	return 0;
> >  }
> >  
> >  u64 sst_shim_read64(void __iomem *addr, int offset)
> >  {
> > -	u64 val = 0;
> > -
> > -	memcpy_fromio(&val, addr + offset, sizeof(val));
> > -	return val;
> > +	return readq(addr + offset);
> >  }
> >  
> >  void sst_set_fw_state_locked(
> > diff --git a/sound/soc/intel/common/sst-dsp.c 
> > b/sound/soc/intel/common/sst-dsp.c
> > index a627236..5274482 100644
> > --- a/sound/soc/intel/common/sst-dsp.c
> > +++ b/sound/soc/intel/common/sst-dsp.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/io.h>
> >  #include <linux/delay.h>
> >  
> > +#include <asm-generic/io-64-nonatomic-lo-hi.h>
> > +
> >  #include "sst-dsp.h"
> >  #include "sst-dsp-priv.h"
> >  
> > @@ -43,16 +45,13 @@ EXPORT_SYMBOL_GPL(sst_shim32_read);
> >  
> >  void sst_shim32_write64(void __iomem *addr, u32 offset, u64 value)
> >  {
> > -	memcpy_toio(addr + offset, &value, sizeof(value));
> > +	writeq(value, addr + offset);
> >  }
> >  EXPORT_SYMBOL_GPL(sst_shim32_write64);
> >  
> >  u64 sst_shim32_read64(void __iomem *addr, u32 offset)
> >  {
> > -	u64 val;
> > -
> > -	memcpy_fromio(&val, addr + offset, sizeof(val));
> > -	return val;
> > +	return readq(addr + offset);
> >  }
> >  EXPORT_SYMBOL_GPL(sst_shim32_read64);
> >  
> 
