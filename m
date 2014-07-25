From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform
 drivers
Date: Fri, 25 Jul 2014 17:04:11 +0530
Message-ID: <53D240B3.8060203@gmail.com>
References: <cover.1406276436.git.nicoleotsuka@gmail.com> <2288e61e600e28448905e32dd4f74a954110248f.1406276436.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2288e61e600e28448905e32dd4f74a954110248f.1406276436.git.nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 07/25/2014 02:16 PM, Nicolin Chen wrote:
> The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
> signal associated with an input clock into a signal associated with a different
> output clock. The driver currently works as a Front End of DPCM with other Back
> Ends DAI links such as ESAI<->CS42888 and SSI<->WM8962 and SAI. It converts the
> original sample rate to a common rate supported by Back Ends for playback while
> converts the common rate of Back Ends to a desired rate for capture. It has 3
> pairs to support three different substreams within totally 10 channels.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   .../devicetree/bindings/sound/fsl,asrc.txt         |  60 ++
>   sound/soc/fsl/Kconfig                              |   9 +
>   sound/soc/fsl/Makefile                             |   2 +
>   sound/soc/fsl/fsl_asrc.c                           | 992 +++++++++++++++++++++
>   sound/soc/fsl/fsl_asrc.h                           | 461 ++++++++++
>   sound/soc/fsl/fsl_asrc_dma.c                       | 386 ++++++++
>   6 files changed, 1910 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
>   create mode 100644 sound/soc/fsl/fsl_asrc.c
>   create mode 100644 sound/soc/fsl/fsl_asrc.h
>   create mode 100644 sound/soc/fsl/fsl_asrc_dma.c
>
>
check patch warnings on this patch...

-- 
Regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
