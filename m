From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Date: Thu, 23 May 2019 03:10:56 -0700
Message-ID: <20190523101055.GA28470@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB647934199C3AA60759BED888E3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB647934199C3AA60759BED888E3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "broonie@kernel.org" <broonie@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Shengjiu,

On Thu, May 23, 2019 at 09:53:42AM +0000, S.j. Wang wrote:
> > > +     /*
> > > +      * Add fifo reset here, because the regcache_sync will
> > > +      * write one more data to ETDR.
> > > +      * Which will cause channel shift.
> > 
> > Sounds like a bug to me...should fix it first by marking the data registers as
> > volatile.
> > 
> The ETDR is a writable register, it is not volatile. Even we change it to
> Volatile, I don't think we can't avoid this issue. for the regcache_sync
> Just to write this register, it is correct behavior.

Is that so? Quoting the comments of regcache_sync():
"* regcache_sync - Sync the register cache with the hardware.
 *
 * @map: map to configure.
 *
 * Any registers that should not be synced should be marked as
 * volatile."

If regcache_sync() does sync volatile registers too as you said,
I don't mind having this FIFO reset WAR for now, though I think
this mismatch between the comments and the actual behavior then
should get people's attention.

Thank you
