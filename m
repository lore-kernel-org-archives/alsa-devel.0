From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/4] ARM: dts: rockchip: Add SPDIF transceiver for RK3188
Date: Tue, 28 Jul 2015 16:48:57 +0300
Message-ID: <55B78849.6060706@cogentembedded.com>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438085011-16577-4-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438085011-16577-4-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 7/28/2015 3:03 PM, Sjoerd Simons wrote:

> Add the SPDIF transceiver controller and pin for RK3188

> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>   arch/arm/boot/dts/rk3188.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

> diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
> index 0f23aed..43e9bdf 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -121,6 +121,22 @@
>   		status = "disabled";
>   	};
>
> +	spdif: spdif@0x1011e000 {

    Please drop "0x". And I'd call the node "sound@..." to match the ePAPR 
standard.

[...]

MBR, Sergei
