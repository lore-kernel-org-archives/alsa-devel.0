From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [EXT] Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 2 May 2019 11:32:31 -0700
Message-ID: <20190502183230.GA25229@Asurada-Nvidia.nvidia.com>
References: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
 <20190502023945.GA19532@sirena.org.uk>
 <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 02, 2019 at 09:13:58AM +0000, S.j. Wang wrote:
> > On Sun, Apr 28, 2019 at 02:24:54AM +0000, S.j. Wang wrote:
> > > Add pm runtime support and move clock handling there.
> > > Close the clocks at suspend to reduce the power consumption.
> > >
> > > fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> > > fsl_esai_resume is replaced by pm_runtime_force_resume.
> > 
> > This doesn't apply against for-5.2 again.  Sorry about this, I think this one is
> > due to some messups with my scripts which caused some patches to be
> > dropped for a while (and it's likely to be what happened the last time as
> > well).  Can you check and resend again please?  Like I say sorry about this, I
> > think it's my mistake.
> 
> I am checking, but I don't know why this patch failed in your side. I 
> Tried to apply this patch on for-5.1, for 5.2,  for-linus  and for-next, all are

I just tried to apply it against top of trees of for-next and for-5.2
and both were fine on my side too.

> Successful.  The git is git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.

Btw, this git link no longer works for me, not sure why:
# git remote add broonie git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
# git fetch broonie
fatal: remote error: access denied or repository not exported: /m/korg/pub/scm/linux/kernel/git/broonie/sound.git

It started to work after I changed "git://" to "https://" though...
