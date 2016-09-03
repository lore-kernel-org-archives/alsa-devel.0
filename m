From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Sat, 3 Sep 2016 12:32:13 +0100
Message-ID: <20160903113213.GG21682@localhost.localdomain>
References: <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <20160830145136.GE9355@localhost>
 <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost> <57C65D4A.9090209@sakamocchi.jp>
 <20160831090552.GZ21682@localhost.localdomain>
 <s5hzintgtsr.wl-tiwai@suse.de>
 <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
 <a21ab28c-12d5-41c2-9209-4127fe3ca79a@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 581F526736F
 for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2016 13:32:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a21ab28c-12d5-41c2-9209-4127fe3ca79a@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, broonie@linaro.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, omair.m.abdullah@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2016 at 08:18:04PM +0900, Takashi Sakamoto wrote:
> Clemens,
> 
> On Aug 31 2016 20:54, Clemens Ladisch wrote:
> > Takashi Iwai wrote:
> >> TLV has never been and (will never be) an API to handle a
> >> generic binary stream.
> > 
> > It would be possible to define something like SNDRV_CTL_TLVT_HWDEP_BLOB
> > or _COEFFICIENTS, or to reserve a range of TLVT values for driver-
> > defined types.  (But we cannot change soc-wm-adsp to support only proper
> > TLV data, because this would introduce a regression.)
> 
> For our information, I wrote a patch including your idea.
> 
> 
> Thanks for your bright comment ;)
> 
> Takashi Sakamoto
> 
> ---- 8< ----
> 
> >From d1a0eabf1b33fae5de7cedf7aee23778f5dcf46c Mon Sep 17 00:00:00 2001
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date: Fri, 2 Sep 2016 00:12:20 +0900
> Subject: [PATCH] ALSA: control: coefficient support
> 
> ---
>  include/uapi/sound/asound.h |  5 +++++
>  include/uapi/sound/tlv.h    |  1 +
>  sound/soc/codecs/wm_adsp.c  |  3 ++-
>  sound/soc/soc-ops.c         | 37 ++++++++++++++++++++++++++++++++++---
>  sound/soc/soc-topology.c    |  3 ++-
>  5 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 609cadb..69c0585 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -848,6 +848,11 @@ typedef int __bitwise snd_ctl_elem_iface_t;
>  #define SNDRV_CTL_ELEM_ACCESS_TLV_WRITE		(1<<5)	/* TLV write is possible */
>  #define SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
> (SNDRV_CTL_ELEM_ACCESS_TLV_READ|SNDRV_CTL_ELEM_ACCESS_TLV_WRITE)
>  #define SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND	(1<<6)	/* TLV command is
> possible */
> +/*
> + * Arbitrary data is accepted for coefficients, instead of pure
> threshold level
> + * information.
> + */
> +#define SNDRV_CTL_ELEM_ACCESS_TLV_COEFF		(1<<7)

Yeah the addition of a new flag here would very much get my vote.
The only way at the moment to tell if you are dealing with this
type of control from user-space is to look for
a control of type SNDRV_CTL_ELEM_TYPE_BYTES that doesn't have
SNDRV_CTL_ELEM_ACCESS_READ or SNDRV_CTL_ELEM_ACCESS_WRITE. Which
is far from ideal.

>  #define SNDRV_CTL_ELEM_ACCESS_INACTIVE		(1<<8)	/* control does actually
> nothing, but may be updated */
>  #define SNDRV_CTL_ELEM_ACCESS_LOCK		(1<<9)	/* write lock */
>  #define SNDRV_CTL_ELEM_ACCESS_OWNER		(1<<10)	/* write lock owner */
> diff --git a/include/uapi/sound/tlv.h b/include/uapi/sound/tlv.h
> index ffc4f20..fd1c867 100644
> --- a/include/uapi/sound/tlv.h
> +++ b/include/uapi/sound/tlv.h
> @@ -19,6 +19,7 @@
>  #define SNDRV_CTL_TLVT_DB_RANGE 3	/* dB range container */
>  #define SNDRV_CTL_TLVT_DB_MINMAX 4	/* dB scale with min/max */
>  #define SNDRV_CTL_TLVT_DB_MINMAX_MUTE 5	/* dB scale with min/max with
> mute */
> +#define SNDRV_CTL_TLVT_COEFF	6	/* Arbitrary data */
> 
>  /*
>   * channel-mapping TLV items
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 21fbe7d..525d70b 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -930,7 +930,8 @@ static unsigned int wmfw_convert_flags(unsigned int
> in, unsigned int len)
>  		wr = SNDRV_CTL_ELEM_ACCESS_TLV_WRITE;
>  		vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
> 
> -		out = SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
> +		out = SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK |
> +		      SNDRV_CTL_ELEM_ACCESS_TLV_COEFF;
>  	} else {
>  		rd = SNDRV_CTL_ELEM_ACCESS_READ;
>  		wr = SNDRV_CTL_ELEM_ACCESS_WRITE;
> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
> index a513a34..14cdd59 100644
> --- a/sound/soc/soc-ops.c
> +++ b/sound/soc/soc-ops.c
> @@ -31,6 +31,7 @@
>  #include <sound/soc.h>
>  #include <sound/soc-dpcm.h>
>  #include <sound/initval.h>
> +#include <sound/tlv.h>
> 
>  /**
>   * snd_soc_info_enum_double - enumerated double mixer info callback
> @@ -773,19 +774,49 @@ int snd_soc_bytes_tlv_callback(struct snd_kcontrol
> *kcontrol, int op_flag,
>  				unsigned int size, unsigned int __user *tlv)
>  {
>  	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
> -	unsigned int count = size < params->max ? size : params->max;
> +	unsigned int count;
> +	unsigned int type;
>  	int ret = -ENXIO;
> 
> +	/*
> +	 * The TLV packet can transfer numerical ID for one control element.
> +	 * But ALSA control core don't tell it to each implementation of
> +	 * TLV callback. Here, instead, use the first volatile data to
> +	 * check access information.
> +	 */
> +	if (!(kcontrol->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_COEFF))
> +		return -ENXIO;
> +
> +	/* The data should be constructed according to TLV protocol. */
> +	if (copy_from_user(&type, tlv, sizeof(unsigned int)))
> +		return -EFAULT;
> +
> +	/* The type should be an arbitrary data. */
> +	if (type != SNDRV_CTL_TLVT_COEFF)
> +		return -ENXIO;
> +

I agree it is probably a bit late to add this now.

Thanks,
Charles
