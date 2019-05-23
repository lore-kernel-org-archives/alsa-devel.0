From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Date: Thu, 23 May 2019 15:50:52 -0700
Message-ID: <20190523225052.GA29562@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB6479FF8E1B55E9BE67E7B0ECE3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479FF8E1B55E9BE67E7B0ECE3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 23, 2019 at 11:04:03AM +0000, S.j. Wang wrote:
> > On Thu, May 23, 2019 at 09:53:42AM +0000, S.j. Wang wrote:
> > > > > +     /*
> > > > > +      * Add fifo reset here, because the regcache_sync will
> > > > > +      * write one more data to ETDR.
> > > > > +      * Which will cause channel shift.
> > > >
> > > > Sounds like a bug to me...should fix it first by marking the data
> > > > registers as volatile.
> > > >
> > > The ETDR is a writable register, it is not volatile. Even we change it
> > > to Volatile, I don't think we can't avoid this issue. for the
> > > regcache_sync Just to write this register, it is correct behavior.
> > 
> > Is that so? Quoting the comments of regcache_sync():
> > "* regcache_sync - Sync the register cache with the hardware.
> >  *
> >  * @map: map to configure.
> >  *
> >  * Any registers that should not be synced should be marked as
> >  * volatile."
> > 
> > If regcache_sync() does sync volatile registers too as you said, I don't mind
> > having this FIFO reset WAR for now, though I think this mismatch between
> > the comments and the actual behavior then should get people's attention.
> > 
> > Thank you
> 
> ETDR is not volatile,  if we mark it is volatile, is it correct?

Well, you have a point -- it might not be ideally true, but it sounds
like a correct fix to me according to this comments.

We can wait for Mark's comments or just send a patch to the mail list 
for review.

Thanks you
