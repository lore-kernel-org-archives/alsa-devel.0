From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: core: cache index fix
Date: Wed, 3 Aug 2011 01:05:39 +0900
Message-ID: <20110802160538.GG25884@opensource.wolfsonmicro.com>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721F427D@039-SN1MPN1-002.039d.mgd.msft.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 02, 2011 at 09:41:22AM +0000, Dong Aisheng-B29396 wrote:

> > No, I think we should hide these decisions completely within the cache
> > code.

> Yes, but the issue is that hw_read will check if reg is in cache array
> And checking like " if (reg >= codec->driver->reg_cache_size ||" is wrong
> when the step is not 1 that will cause registers with their index are greater
> than cache index will not be able to fetch data from cache.

This is in no way inconsistent with what I'm saying above.

> > A
> > register map with step size greater than one should never have more than
> > one register in a block anyway with the current code so the step size
> > should never be perceptible.

> The question is that rbtree uses reg index to index as follows:

The rbtree should only see registers meaning registers.

>         if (rbnode) {
>                 snd_soc_rbtree_get_base_top_reg(rbnode, &base_reg, &top_reg);
>                 if (reg >= base_reg && reg <= top_reg) {
>                         reg_tmp = reg - base_reg;
>                         *value = snd_soc_rbtree_get_register(rbnode, reg_tmp);
>                         return 0;
>                 }
>         }

> So the block may be reg0, reg2, reg4.....
> And the block is flat, the value is get/set by rbnode->block[reg_tmp]:
> I understand right, there may be hole in the block, right?

No.  The rbtree is dealing with registers only.  The rbtree has no idea
about steps, and nor should it.

> > It occurs to me that what we want to do here may be to make a new
> > register cache type for step sizes then hide all the complexity for these
> > devices in there.  That keeps everything together and ensures that newer
> > devices don't pay a complexity cost.

> If we add new cache type, does it have any big difference with FLAT?
> Maybe if we can fix the cache step issue, the FLAT cache can be reuse.

Step size and if you want to keep the defaults also compressed then the
defaults size.
