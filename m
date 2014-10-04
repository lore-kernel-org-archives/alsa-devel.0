From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai doc: Add "fsl,
 vf610-esai" as compatible string
Date: Sat, 4 Oct 2014 10:31:47 -0700
Message-ID: <20141004173147.GA2740@Asurada>
References: <1412433821-10970-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E972B260569
 for <alsa-devel@alsa-project.org>; Sat,  4 Oct 2014 19:31:59 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id fa1so3093236pad.33
 for <alsa-devel@alsa-project.org>; Sat, 04 Oct 2014 10:31:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412433821-10970-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Li.Xiubo@freescale.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 04, 2014 at 11:43:41AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit b21cc2f5fdfe224 ("ASoC: esai: Add VF610+ compatibles support.")
> the fsl_esai driver also accepts  the "fsl,vf610-esai" compatible string.
> 
> Update the documentation accordingly.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you.

> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> index aeb8c4a..52f5b6b 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> @@ -7,7 +7,8 @@ other DSPs. It has up to six transmitters and four receivers.
>  
>  Required properties:
>  
> -  - compatible : Compatible list, must contain "fsl,imx35-esai".
> +  - compatible : Compatible list, must contain "fsl,imx35-esai" or
> +		 "fsl,vf610-esai"
>  
>    - reg : Offset and length of the register set for the device.
>  
> -- 
> 1.9.1
> 
