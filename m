From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
Date: Fri, 1 Nov 2013 20:07:03 +0800
Message-ID: <20131101120700.GE10324@S2101-09.ap.freescale.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
 <20131101102805.GG28401@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131101102805.GG28401@MrMyself>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, r65073@freescale.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 01, 2013 at 06:28:05PM +0800, Nicolin Chen wrote:
> >  sound/soc/fsl/fsl-sgtl5000-vf610.c | 208 +++++++++++++++++++++++++++++++++++++
> 
> I just doubt if this file naming is appropriate. Even if we might not have
> rigor rule for the file names, according to existing ones, they are all in
> a same pattern: [SoC name]-[codec name].c
> 
> "imx-sgtl5000.c" for example
> 
> I think it would make user less confused about what this file exactly is if
> this machine driver also follow the pattern: vf610-sgtl5000.c
> 
> 
> @Shawn
> 
> What do you think about the file name?

Yeah, it would be better to name the file following the existing the
pattern.

Shawn

