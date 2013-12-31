From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: fsl_sai: Fix one bug for hardware limitation.
Date: Tue, 31 Dec 2013 03:29:04 +0000
Message-ID: <d2c60ec3b8a14500afef632e6163d57e@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388026642-1464-1-git-send-email-Li.Xiubo@freescale.com>
 <20131230121520.GR31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131230121520.GR31886@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "timur@tabi.org" <timur@tabi.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

> Subject: Re: [PATCH] ASoC: fsl_sai: Fix one bug for hardware limitation.
> 
> On Thu, Dec 26, 2013 at 10:57:22AM +0800, Xiubo Li wrote:
> > This is maybe one bug or a limitation of the hardware that the {T,R}CR2's
> > Synchronous Mode bits must be set as late as possible, or the SAI device
> > maybe hanged up, and there has not any explaination about this limitation
> > in the SAI Data Sheet.
> 
> If they really should be set as late as possible then I'd expect them to
> be being set in the trigger function, that's what gets called as the
> audio actually starts streaming.  This is moving it to the startup
> function which is one of the first things that happens during audio
> stream setup so presumably makes things worse.
> 

Yes, it is.

If everything is OK, I will send another new patch later.

Thanks,

---
Best Regards,
Xiubo
