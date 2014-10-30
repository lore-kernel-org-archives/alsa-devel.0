From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] audio: sai: Add Power Management support
Date: Thu, 30 Oct 2014 03:30:40 +0000
Message-ID: <718ee124537a4f4091bdf5242d256705@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1414552896-20797-1-git-send-email-b18965@freescale.com>
 <20141029113634.GF18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141029113634.GF18557@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Huan Wang <alison.wang@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,


> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Mark Brown
> Sent: Wednesday, October 29, 2014 7:37 PM
> To: Wang Huan-B18965
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de; linux-kernel@vger.kernel.org;
> lgirdwood@gmail.com; perex@perex.cz; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] audio: sai: Add Power Management support
> 
> On Wed, Oct 29, 2014 at 11:21:36AM +0800, Alison Wang wrote:
> > This patch adds Power Management support for SAI.
> > Activate regmap cache with REGCACHE_RBTREE, and use
> 
> Are you sure that REGCACHE_RBTREE is the best option here?  For MMIO
> devices the cost tradeoff for the rbtree is usually higher than people
> like so flat caches are preferred.  But if it works for you that's fine,
> this shouldn't be *that* performance critical.
> 

Yes, the flat caches will have higher performance and can also fix the
Register defaults and spinlock issue here.

One more thing, if the device is not performance critical, then shouldn't we
Take care of the cache memory consumption to determine using flat or rbtree
Type ?

Thanks,

BRs
Xiubo


> I'm also a bit surprised that this works without register defaults being
> provided since we need to make sure we allocate the rbtree nodes outside
> of the spinlock we use to lock MMIO access - was this tested with
> mainline?
