From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed
 by spdif device
Date: Sat, 10 Oct 2015 17:03:07 -0300
Message-ID: <CAOMZO5AY7wZ6mJEAW0rBZv_grgbnBKxSa5UZTdBRx79M96mTXw@mail.gmail.com>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
 <20150917110154.GC12027@sirena.org.uk>
 <20150917175407.GA2544@Asurada-CZ80>
 <20150919135040.GM12027@sirena.org.uk>
 <20151010102657.GC25804@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 365B5260536
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 22:03:10 +0200 (CEST)
Received: by igbni9 with SMTP id ni9so21126586igb.1
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 13:03:08 -0700 (PDT)
In-Reply-To: <20151010102657.GC25804@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pawel Moll <pawel.moll@arm.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Timur Tabi <timur@tabi.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 10, 2015 at 7:26 AM, Shengjiu Wang
<shengjiu.wang@freescale.com> wrote:

> I think spba clock should be used by the audio IP not DMA, because in same
> situation the FSL_SSI doesn't need this clock.

According to this commit from FSL BSP, the SSI2 port on MX53 is
connected to SPBA and needs the SPBA clock:

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/arch/arm/mach-mx5/clock.c?h=imx_2.6.35_maintain&id=2438f48431b7aff00a522502d5a6ea217ea133d9
