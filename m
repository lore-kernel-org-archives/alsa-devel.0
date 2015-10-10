From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed
 by spdif device
Date: Sat, 10 Oct 2015 13:35:57 -0700
Message-ID: <20151010203556.GA2522@Asurada-CZ80>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
 <20150917110154.GC12027@sirena.org.uk>
 <20150917175407.GA2544@Asurada-CZ80>
 <20150919135040.GM12027@sirena.org.uk>
 <20151010102657.GC25804@shlinux2>
 <CAOMZO5AY7wZ6mJEAW0rBZv_grgbnBKxSa5UZTdBRx79M96mTXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 93CC7260536
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 22:36:04 +0200 (CEST)
Received: by padhy16 with SMTP id hy16so117418372pad.1
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 13:36:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AY7wZ6mJEAW0rBZv_grgbnBKxSa5UZTdBRx79M96mTXw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pawel Moll <pawel.moll@arm.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Timur Tabi <timur@tabi.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 10, 2015 at 05:03:07PM -0300, Fabio Estevam wrote:
> On Sat, Oct 10, 2015 at 7:26 AM, Shengjiu Wang
> <shengjiu.wang@freescale.com> wrote:
> 
> > I think spba clock should be used by the audio IP not DMA, because in same
> > situation the FSL_SSI doesn't need this clock.
> 
> According to this commit from FSL BSP, the SSI2 port on MX53 is
> connected to SPBA and needs the SPBA clock:
> 
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/arch/arm/mach-mx5/clock.c?h=imx_2.6.35_maintain&id=2438f48431b7aff00a522502d5a6ea217ea133d9

Hmm, the detail of an SPBA issue is sometimes complicated due to
different fabric designs between SoCs. We cannot simply say that
a DMA access for an IP under the Shared Peripheral Bus requires
SPBA clock or not unless the hardware team clearly demands that.

However, as an arbiter, the SPBA must be outside any of those IPs
and tied to the SDMA in order to balancing memory access between
the SDMA and a co-existing CPU. The question is whether we treat
it as a part of an IP wrapper or a part of the SDMA.

Therefore, unless a CPU access would fail even *without any SDMA
access being launched*, it sounds fair to me to put it into the
DMA code.
