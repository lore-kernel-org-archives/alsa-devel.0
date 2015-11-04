From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed
 by spdif device
Date: Wed, 4 Nov 2015 16:34:44 +0800
Message-ID: <20151104083442.GA21193@shlinux2>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
 <20150917110154.GC12027@sirena.org.uk>
 <20150917175407.GA2544@Asurada-CZ80>
 <20150919135040.GM12027@sirena.org.uk>
 <20151010102657.GC25804@shlinux2>
 <CAOMZO5AY7wZ6mJEAW0rBZv_grgbnBKxSa5UZTdBRx79M96mTXw@mail.gmail.com>
 <20151010203556.GA2522@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0117.outbound.protection.outlook.com [157.56.110.117])
 by alsa0.perex.cz (Postfix) with ESMTP id DC73D265329
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 09:36:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151010203556.GA2522@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 10, 2015 at 01:35:57PM -0700, Nicolin Chen wrote:
> On Sat, Oct 10, 2015 at 05:03:07PM -0300, Fabio Estevam wrote:
> > On Sat, Oct 10, 2015 at 7:26 AM, Shengjiu Wang
> > <shengjiu.wang@freescale.com> wrote:
> > 
> > > I think spba clock should be used by the audio IP not DMA, because in same
> > > situation the FSL_SSI doesn't need this clock.
> > 
> > According to this commit from FSL BSP, the SSI2 port on MX53 is
> > connected to SPBA and needs the SPBA clock:
> > 
> > http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/arch/arm/mach-mx5/clock.c?h=imx_2.6.35_maintain&id=2438f48431b7aff00a522502d5a6ea217ea133d9
> 
> Hmm, the detail of an SPBA issue is sometimes complicated due to
> different fabric designs between SoCs. We cannot simply say that
> a DMA access for an IP under the Shared Peripheral Bus requires
> SPBA clock or not unless the hardware team clearly demands that.
> 
> However, as an arbiter, the SPBA must be outside any of those IPs
> and tied to the SDMA in order to balancing memory access between
> the SDMA and a co-existing CPU. The question is whether we treat
> it as a part of an IP wrapper or a part of the SDMA.
> 
> Therefore, unless a CPU access would fail even *without any SDMA
> access being launched*, it sounds fair to me to put it into the
> DMA code.

I discussed this issue with IC team. The SPBA bus has 3 master port,
one is for SDMA, one is for MCU (ARM core), the third one is for DSP (
currently there is no connection for DSP). Any two master port are used
simultaneously, there will be arbitration issue when SPBA clock is not
enabled.

So I think it is better put SPBA clock in Audio IP, because if there is
DSP master port + MCU master used, there will be issue too. (DSP master 
port is not used in i.MX chip). Anyway I think put it in SDMA driver is
not good choice, if SDMA is removed, there will be still issue. Put it
in Audio IP maybe more safe.
