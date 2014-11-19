From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 9/9] ARM: dts: Model IPQ LPASS audio hardware
Date: Wed, 19 Nov 2014 14:54:43 -0800
Message-ID: <20141119225443.GB13013@sonymobile.com>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <1416423169-21865-10-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-10-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 19, 2014 at 07:52:49PM +0100, Kenneth Westfield wrote:
> From: Kenneth Westfield <kwestfie@codeaurora.org>
> 
> Model the LPASS audio hardware for the IPQ806X.
> 
> Change-Id: Ide1aa0d09c23d4496aa9c40e3c9878a968261f11

As Kumar mentioned, please exclude this.

> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>

Typically, the order of these SoB should match some sort of chain of delivery:
 - The first should be the author of the patch
 - The last should match the email source (you) <-- doesn't seem to be the case

> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 63b2146f563b541e4994697af5ee1bbb41a4abd1..0e5b3b625f0442964aa7fbbc993c6c818fe99041 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -2,6 +2,7 @@
>  
>  #include "skeleton.dtsi"
>  #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> +#include <dt-bindings/clock/qcom,lcc-ipq806x.h>

Neither this file nor an associated clock controller driver exists in
mainline.  Is there some other series this depends on?

-Courtney
