From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/6] ASoC: Intel: Add support for
 Haswell/Broadwell DSP
Date: Mon, 24 Feb 2014 19:47:21 +0000
Message-ID: <1393271241.2323.57.camel@loki>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140221050121.GA25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 01D0B261ADF
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 20:47:25 +0100 (CET)
In-Reply-To: <20140221050121.GA25940@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-02-21 at 14:01 +0900, Mark Brown wrote:
> On Thu, Feb 20, 2014 at 09:48:42PM +0000, Liam Girdwood wrote:
> > Add support for low level differentiation functions for Haswell and Broadwell
> > SST DSPs. This includes suppoprt for DSP boot and reset, DSP firmware module
> > parsing and DSP memory block map initialisation.
> 
> Applied, thanks.  Some terribly minor things below:
> 

Sorry, been away a few days. Will get around to fixes over the next few
days.

> > +u32 sst_shim32_read(void __iomem *addr, u32 offset)
> > +{
> > +	return readl(addr + offset);
> > +}
> > +EXPORT_SYMBOL_GPL(sst_shim32_read);
> 
> This lot all look like a regmap to me, though some extensions may be
> needed for the 64 bit variants!
> 

The SHIM is the register space that is used to configure the DSP and
also for sending IPC messages. It's really just PCI register space that
has some registers shared with the DSP. IIrc, there may be 2 shared
registers out of about 8 in total, but the different cores may access
them differently. Iirc, Vinod has a case where they needed to write then
read a value for one of his cores.

> > +struct sst_ops haswell_ops = {
> > +	.reset = hsw_reset,
> > +        .boot = hsw_boot,
> > +	.write = sst_shim32_write,
> 
> Something appears funky with the indentation for .boot - tab/space
> confusion?

oops, will fix. 

Thanks !

Liam
