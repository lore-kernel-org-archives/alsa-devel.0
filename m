From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 1/2] ASoC: fsl-spdif: big-endian support
Date: Tue, 11 Feb 2014 07:39:44 +0000
Message-ID: <1a10273e564a4bb7a5aafe3f01ccffa2@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392097276-14705-1-git-send-email-Li.Xiubo@freescale.com>
 <20140211071034.GA18803@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140211071034.GA18803@MrMyself>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



> > +   - big-endian : If this property is absent, the native endian mode will
> > +   be in use as default, or the big endian mode will be in use for all the
> > +   device registers.
> > +
> 
> @Shawn
> Does DT have an existing approach to determine if the current SoC this IP
> uses is BE or LE? I am thinking the scenario that if all drivers support
> BE/LE while the SoC is big-endian, all the nodes in the DT would have to
> include a duplicated property (big-endian).
> 

@Nicolin, @Shawn
One special scenario likes the LS1 platform, the CPU and a few devices are in
LE mode and other devices will be in BE mode.

Thanks,

--
Best Regards,
Xiubo
