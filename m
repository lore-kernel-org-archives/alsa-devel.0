From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Date: Wed, 5 Jun 2019 17:16:45 -0700
Message-ID: <20190606001644.GA20103@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB6479D7512EDE1217228033CAE3160@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479D7512EDE1217228033CAE3160@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Shengjiu,

On Wed, Jun 05, 2019 at 10:29:37AM +0000, S.j. Wang wrote:
> > > ETDR is not volatile,  if we mark it is volatile, is it correct?
> > 
> > Well, you have a point -- it might not be ideally true, but it sounds like a
> > correct fix to me according to this comments.
> > 
> > We can wait for Mark's comments or just send a patch to the mail list for
> > review.
> 
> I test this patch, we don't need to reset the FIFO, and regcache_sync didn't
> Write the ETDR even the EDTR is not volatile.  This fault maybe caused by

The fsl_esai driver uses FLAT type cache so regcache_sync() would
go through regcache_default_sync() that would bypass cache sync at
the regcache_reg_needs_sync() check when the cached register value
matches its default value: in case of ETDR who has a default value
0x0, it'd just "continue" without doing that _regmap_write() when
the cached value equals to 0x0.

> Legacy, in the beginning we add this patch in internal branch, there maybe
> Something cause this issue, but now can't reproduced. 

The "legacy" case might happen to have two mismatched ETDR values
between the cached value and default 0x0. And I am worried it may
appear once again someday.

So I feel we still need to change ETDR to volatile type. And for
your question "ETDR is not volatile,  if we mark it is volatile,
is it correct?", I double checked the definition of volatile_reg,
and it says:
 * @volatile_reg: Optional callback returning true if the register
 *		  value can't be cached. If this field is NULL but

So it seems correct to me then, as the "volatile" should be also
transcribed as "non-cacheable".

Thanks
Nicolin
