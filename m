From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v2] ASoC: fsl-sai: convert to use regmap API for
 Freeacale SAI
Date: Tue, 11 Feb 2014 01:34:55 +0000
Message-ID: <9a21e8cc57f54793a05d33f2ca6d7ec0@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1391841508-14025-1-git-send-email-Li.Xiubo@freescale.com>
 <20140210132746.GD1757@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140210132746.GD1757@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
List-Id: alsa-devel@alsa-project.org



> Subject: Re: [PATCH v2] ASoC: fsl-sai: convert to use regmap API for Freeacale
> SAI
> 
> On Sat, Feb 08, 2014 at 02:38:28PM +0800, Xiubo Li wrote:
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> 
> Applied, thanks but I think this needs a select of REGMAP_MMIO in the
> Kconfig to ensure that regmap-mmio is actually there (it might well be
> OK due to implicit dependencies at the minute but should be fixed
> properly).

Yes, I will send another patch to fix it.

Thanks,

--
Best Regards,
Xiubo
