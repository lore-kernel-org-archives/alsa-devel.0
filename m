From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl: imx-wm8962: Grant hw_params/free()
 permission to control FLL
Date: Tue, 10 Dec 2013 18:51:36 +0800
Message-ID: <20131210105135.GC12042@MrMyself>
References: <cover.1386344000.git.b42378@freescale.com>
 <105d07ac1a77bf99872d75608c97b3342079bfb7.1386344000.git.b42378@freescale.com>
 <20131209175640.GL29268@sirena.org.uk>
 <20131210051740.GA10655@MrMyself>
 <20131210102523.GB12042@MrMyself>
 <20131210104745.GC29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131210104745.GC29268@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <b42378@freescale.com>, lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 10, 2013 at 10:47:45AM +0000, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 06:25:24PM +0800, Nicolin Chen wrote:
> 
> > Hmm...Sorry for asking a stupid question that how to test bypass path with
> > WM8962? I've tried some amixer commands to enable the bypass-path switches.
> > But we still need to power the Codec up like using arecord or aplay to call
> > wm8962_resume() and DAPM-related, right?
> 
> For this sort of question you should follow the DAPM graph...  the
> headphone and speaker mixers have IN4 and MIXIN as inputs for analogue
> bypass and the STL and STR paths provide digital sidetones through the
> ADC and DAC.

So I could test it merely by using 'amixer cset' to enable those switches
without doing anything to power WM8962 up as long as my operation follows
the DAPM graph so that the DPAM would automatically turn on the regulator
for me?

Thank you,
Nicolin Chen
