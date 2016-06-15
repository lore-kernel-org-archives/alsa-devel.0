From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH v3 2/2] ASoC: msm8916: Add msm8916-wcd codec driver
Date: Wed, 15 Jun 2016 13:07:52 -0700
Message-ID: <20160615200752.GA26173@kwestfie-linux.qualcomm.com>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org>
 <20160614155938.GS2282@sirena.org.uk>
 <57611CEB.4030401@linaro.org>
 <20160615093136.GW2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160615093136.GW2282@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 15, 2016 at 10:31:36AM +0100, Mark Brown wrote:
> On Wed, Jun 15, 2016 at 10:16:27AM +0100, Srinivas Kandagatla wrote:
> > On 14/06/16 16:59, Mark Brown wrote:
> > > On Fri, Jun 10, 2016 at 07:18:45PM +0100, Srinivas Kandagatla wrote:

> > In theory there are 3 devices,
> > one is the pmic-spmi driver, which provides regmap access to analog part of
> > codec registers.
> > second is syscon driver which provides regmap access to digital parts of
> > codec to codec driver.
> > third is the codec driver which uses both the above.
> 
> > Codec registers range is just split into two, range 0x0- 0x200 sits in pmic
> > address space and range 0x201 - 0x4ff in the SOC address space,
> 
> > Are there any other better ways to model this kinda driver?
> 
> Why not just have separate devices for each of the register maps?

Srinivas,

Mark has a good point.  Also, by having distinct devices and drivers;
you should make use of ASoC's supporting wrappers for regmap accesses.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
