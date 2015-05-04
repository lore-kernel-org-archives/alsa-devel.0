From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [alsa-devel] [PATCH v5 2/2] mfd: arizona: Update DT binding to
 support hpdet channel
Date: Mon, 04 May 2015 14:17:28 +0900
Message-ID: <554700E8.9050006@samsung.com>
References: <1430714534-28772-1-git-send-email-ideal.song@samsung.com>
 <1430714534-28772-3-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1430714534-28772-3-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>, lee.jones@linaro.org
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, sameo@linux.intel.com, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, rf@opensource.wolfsonmicro.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Dear Lee,

This patch includes the documentation about extcon-arizona.c.
How are we apply this patch to either mfd git or extcon git?

Thanks,
Chanwoo Choi

On 05/04/2015 01:42 PM, Inha Song wrote:
> This patch add device tree bindings for the pdata needed to configure
> the Accessory Detect Mode select when Headphone detection.
> 
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> Acked-by: Lee Jones <lee@kernel.org>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
> index 7665aa9..32a71b7 100644
> --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> @@ -62,6 +62,12 @@ Optional properties:
>      present, the number of values should be less than or equal to the
>      number of inputs, unspecified inputs will use the chip default.
>  
> +  - wlf,hpdet-channel : Headphone detection channel.
> +    ARIZONA_ACCDET_MODE_HPL or 1 - Headphone detect mode is set to HPDETL
> +    ARIZONA_ACCDET_MODE_HPR or 2 - Headphone detect mode is set to HPDETR
> +    If this node is not mentioned or if the value is unknown, then
> +    headphone detection mode is set to HPDETL.
> +
>    - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
>      they are being externally supplied. As covered in
>      Documentation/devicetree/bindings/regulator/regulator.txt
> 
