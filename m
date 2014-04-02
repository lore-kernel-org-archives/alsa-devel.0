From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 0/2] Add ipg clock control to sai driver
Date: Wed, 2 Apr 2014 16:01:43 +0800
Message-ID: <CAGoOwPQXw82ZgK=ovmBxPifVT-3mC0a0o0GDtZd=AHRfCf3Q_w@mail.gmail.com>
References: <cover.1396352401.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id CDB2C2654CB
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 10:01:43 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id x48so7497941wes.35
 for <alsa-devel@alsa-project.org>; Wed, 02 Apr 2014 01:01:43 -0700 (PDT)
In-Reply-To: <cover.1396352401.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org, Li.Xiubo@freescale.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Timur Tabi <timur@tabi.org>, broonie@kernel.org, rob@landley.net, galak@codeaurora.org, Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Please disregard this version.

SAI actually has three master clocks and one bus clock.
So the patch should have added three sai_clks to the driver.
I'll later send v2 to append the other two.

Thank you.


On Tue, Apr 1, 2014 at 7:52 PM, Nicolin Chen <Guangyu.Chen@freescale.com>wrote:

> This series of patches add ipg clock control to fsl_sai driver and updates
> the vf610.dtsi accordingly.
>
> @Shawn
> I'm not sure if VF610 currently does full works with SAI audio function.
> The PATCH-2 is based on broonie/for-next.
>
> Nicolin Chen (2):
>   ASoC: fsl_sai: Add clock control for SAI
>   ARM: dts: Add ipg clock for sai2 on VF610 platform
>
>  .../devicetree/bindings/sound/fsl-sai.txt          |  7 ++--
>  arch/arm/boot/dts/vf610.dtsi                       |  4 +--
>  sound/soc/fsl/fsl_sai.c                            | 37
> ++++++++++++++++++++--
>  sound/soc/fsl/fsl_sai.h                            |  2 ++
>  4 files changed, 43 insertions(+), 7 deletions(-)
>
> --
> 1.8.4
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
