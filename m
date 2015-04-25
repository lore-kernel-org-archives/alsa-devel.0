From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 2/2] mfd: arizona: Update DT binding to
	support hpdet channel
Date: Sat, 25 Apr 2015 13:51:30 +0100
Message-ID: <20150425125130.GJ3480@opensource.wolfsonmicro.com>
References: <1429701801-25287-1-git-send-email-ideal.song@samsung.com> <1429701801-25287-3-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429701801-25287-3-git-send-email-ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2015 at 08:23:21PM +0900, Inha Song wrote:
> This patch add device tree bindings for the pdata needed to configure
> the Accessory Detect Mode select when Headphone detection.
> 
> Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
> index 7bd1273..401b0b8 100644
> --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> @@ -49,6 +49,12 @@ Optional properties:
>      input singals. If values less than the number of input signals, elements
>      that has not been specifed are set to 0 by default.
>  
> +  - wlf,hpdet-channel : Headphone detection channel.
> +	1 or ARIZONA_ACCDET_MODE_HPL - Headphone detect mode is set to HPDETL
> +	2 or ARIZONA_ACCDET_MODE_HPR - Headphone detect mode is set to HPDETR
> +	If this node is not mentioned or if the value is unknown, then
> +	headphone detection mode is set to HPDETL.
> +

Could we make the indentation here match the rest of the file.

Thanks,
Charles

>    - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
>      they are being externally supplied. As covered in
>      Documentation/devicetree/bindings/regulator/regulator.txt
> -- 
> 2.0.0.390.gcb682f8
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
