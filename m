From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 04/40] soundwire: intel: add debugfs register dump
Date: Fri, 26 Jul 2019 16:09:40 +0200
Message-ID: <20190726140940.GE8767@kroah.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
 <20190726140635.GB8767@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726140635.GB8767@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 26, 2019 at 04:06:35PM +0200, Greg KH wrote:
> On Thu, Jul 25, 2019 at 06:39:56PM -0500, Pierre-Louis Bossart wrote:
> > Add debugfs file to dump the Intel SoundWire registers
> > 
> > Credits: this patch is based on an earlier internal contribution by
> > Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. The main change
> > is the use of scnprintf to avoid known issues with snprintf.
> > 
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  drivers/soundwire/intel.c | 115 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> > 
> > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > index 317873bc0555..aeadc341c0a3 100644
> > --- a/drivers/soundwire/intel.c
> > +++ b/drivers/soundwire/intel.c
> > @@ -6,6 +6,7 @@
> >   */
> >  
> >  #include <linux/acpi.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> > @@ -16,6 +17,7 @@
> >  #include <linux/soundwire/sdw.h>
> >  #include <linux/soundwire/sdw_intel.h>
> >  #include "cadence_master.h"
> > +#include "bus.h"
> >  #include "intel.h"
> >  
> >  /* Intel SHIM Registers Definition */
> > @@ -98,6 +100,7 @@ struct sdw_intel {
> >  	struct sdw_cdns cdns;
> >  	int instance;
> >  	struct sdw_intel_link_res *res;
> > +	struct dentry *fs;
> >  };
> >  
> >  #define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
> > @@ -161,6 +164,115 @@ static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
> >  	return -EAGAIN;
> >  }
> >  
> > +/*
> > + * debugfs
> > + */
> > +
> > +#define RD_BUF (2 * PAGE_SIZE)
> > +
> > +static ssize_t intel_sprintf(void __iomem *mem, bool l,
> > +			     char *buf, size_t pos, unsigned int reg)
> > +{
> > +	int value;
> > +
> > +	if (l)
> > +		value = intel_readl(mem, reg);
> > +	else
> > +		value = intel_readw(mem, reg);
> > +
> > +	return scnprintf(buf + pos, RD_BUF - pos, "%4x\t%4x\n", reg, value);
> > +}
> > +
> > +static ssize_t intel_reg_read(struct file *file, char __user *user_buf,
> > +			      size_t count, loff_t *ppos)
> > +{
> > +	struct sdw_intel *sdw = file->private_data;
> > +	void __iomem *s = sdw->res->shim;
> > +	void __iomem *a = sdw->res->alh;
> > +	char *buf;
> > +	ssize_t ret;
> > +	int i, j;
> > +	unsigned int links, reg;
> > +
> > +	buf = kzalloc(RD_BUF, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	links = intel_readl(s, SDW_SHIM_LCAP) & GENMASK(2, 0);
> > +
> > +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
> > +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nShim\n");
> > +
> > +	for (i = 0; i < 4; i++) {
> > +		reg = SDW_SHIM_LCAP + i * 4;
> > +		ret += intel_sprintf(s, true, buf, ret, reg);
> > +	}
> > +
> > +	for (i = 0; i < links; i++) {
> > +		ret += scnprintf(buf + ret, RD_BUF - ret, "\nLink%d\n", i);
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLSCAP(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS0CM(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS1CM(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS2CM(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTLS3CM(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PCMSCAP(i));
> > +
> > +		for (j = 0; j < 8; j++) {
> > +			ret += intel_sprintf(s, false, buf, ret,
> > +					SDW_SHIM_PCMSYCHM(i, j));
> > +			ret += intel_sprintf(s, false, buf, ret,
> > +					SDW_SHIM_PCMSYCHC(i, j));
> > +		}
> > +
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_PDMSCAP(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_IOCTL(i));
> > +		ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_CTMCTL(i));
> > +	}
> > +
> > +	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKEEN);
> > +	ret += intel_sprintf(s, false, buf, ret, SDW_SHIM_WAKESTS);
> > +
> > +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nALH\n");
> > +	for (i = 0; i < 8; i++)
> > +		ret += intel_sprintf(a, true, buf, ret, SDW_ALH_STRMZCFG(i));
> > +
> > +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> > +	kfree(buf);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations intel_reg_fops = {
> > +	.open = simple_open,
> > +	.read = intel_reg_read,
> > +	.llseek = default_llseek,
> > +};
> 
> DEFINE_SIMPLE_ATTRIBUTE()?

Oops, I mean DEFINE_SHOW_ATTRIBUTE()?
