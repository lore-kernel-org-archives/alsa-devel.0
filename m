From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 2/2] devicetree: sound: Fix fsl-asoc-card identation
Date: Fri, 29 Jan 2016 10:02:40 -0800
Message-ID: <20160129180239.GB7283@Asurada-Nvidia>
References: <1454065261-9522-1-git-send-email-eu@felipetonello.com>
 <1454065261-9522-2-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454065261-9522-2-git-send-email-eu@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2016 at 11:01:01AM +0000, Felipe F. Tonello wrote:
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> index ceaef5126989..16b254b04f8c 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> @@ -43,7 +43,7 @@ Required properties:
>  
>    - audio-cpu		: The phandle of an CPU DAI controller
>  
> -  - audio-codec		: The phandle of an audio codec
> +  - audio-codec	: The phandle of an audio codec

The indentation was fine actually.....how did you see it misaligned?

>    - audio-routing	: A list of the connections between audio components.
>  			  Each entry is a pair of strings, the first being the
> -- 
> 2.7.0
> 
