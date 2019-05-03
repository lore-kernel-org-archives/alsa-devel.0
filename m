From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [EXT] Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Date: Fri, 3 May 2019 12:56:49 -0700
Message-ID: <20190503195648.GA30289@Asurada-Nvidia.nvidia.com>
References: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
 <20190502023945.GA19532@sirena.org.uk>
 <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190503042731.GX14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503042731.GX14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark, 
On Fri, May 03, 2019 at 01:27:31PM +0900, Mark Brown wrote:
> On Thu, May 02, 2019 at 09:13:58AM +0000, S.j. Wang wrote:
> 
> > I am checking, but I don't know why this patch failed in your side. I 
> > Tried to apply this patch on for-5.1, for 5.2,  for-linus  and for-next, all are
> > Successful.  The git is git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.
> 
> > I can't reproduce your problem. Is there any my operation wrong?
> 
> The error message I got was:
> 
> Applying: ASoC: fsl_esai: Add pm runtime function
> error: patch failed: sound/soc/fsl/fsl_esai.c:9
> error: sound/soc/fsl/fsl_esai.c: patch does not apply
> Patch failed at 0001 ASoC: fsl_esai: Add pm runtime function
> 
> which is the header addition.  I can't spot any obvious issues visually
> looking at the patch, only thing I can think is some kind of whitespace
> damage somewhere.

I downloaded this v4 from patchwork and resubmitted a v5 for a
test. Would you please try to apply that one?

If my v5 works vs. having merge conflict at v4, maybe something
wrong with Git version of Shengjiu's? I compared my v5 and his
v4 using vimdiff, there is no much difference of whitespace.

Thanks
Nicolin
