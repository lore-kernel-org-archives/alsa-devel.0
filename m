From: Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 05/11] ASoC: davinci-mcasp: Remove interrupt property
 from DT bindings doc
Date: Wed, 18 Sep 2013 11:20:08 +0530
Message-ID: <52393F10.4090405@ti.com>
References: <cover.1379409268.git.jsarha@ti.com> <1b47734e397bfac8846dcfc194fd1ab63f320d1a.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1b47734e397bfac8846dcfc194fd1ab63f320d1a.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jsarha-l0cyMroinI0@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 September 2013 02:56 PM, jsarha-l0cyMroinI0@public.gmane.org wrote:
> From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
> 
> Davinci McASP driver does use interrupts for anything ATM.

s/does use/does not use

> 
> Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
> ---
>  .../bindings/sound/davinci-mcasp-audio.txt         |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> index 68e0f47..b5e7b78 100644
> --- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
> @@ -11,7 +11,6 @@ Required properties:
>  - reg-names : The mandatory reg-range must be named "mpu" and the optional DMA
>  	      reg-range must be named "dma". For backward compatibility it is
>  	      good to keep "mpu" first in the list.
> -- interrupts : Interrupt number for McASP
>  - op-mode : I2S/DIT ops mode.
>  - tdm-slots : Slots for TDM operation.
>  - num-serializer : Serializers used by McASP.
> @@ -40,7 +39,6 @@ mcasp0: mcasp0@1d00000 {
>  	#size-cells = <0>;
>  	reg = <0x100000 0x3000>;
>  	reg-names "mpu";
> -	interrupts = <82 83>;
>  	op-mode = <0>;		/* MCASP_IIS_MODE */
>  	tdm-slots = <2>;
>  	num-serializer = <16>;
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
