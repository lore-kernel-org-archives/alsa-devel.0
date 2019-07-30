From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: Introduce compatible strings
 for 7ULP and 8MQ
Date: Tue, 30 Jul 2019 01:01:36 -0700
Message-ID: <20190730080135.GB5892@Asurada>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-8-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-8-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, viorel.suman@nxp.com, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 28, 2019 at 10:24:29PM +0300, Daniel Baluta wrote:
> For i.MX7ULP and i.MX8MQ register map is changed. Add two new compatbile
> strings to differentiate this.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 2b38036a4883..b008e9cfedc1 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -8,7 +8,8 @@ codec/DSP interfaces.
>  Required properties:
>  
>    - compatible		: Compatible list, contains "fsl,vf610-sai",
> -			  "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
> +			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
> +			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai".

A nit, could have that 'or' :)

>  
>    - reg			: Offset and length of the register set for the device.
>  
> -- 
> 2.17.1
> 
