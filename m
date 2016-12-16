From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [alsa-lib][PATCH] ASoC: hdmi-codec: use unsigned type to
 structure members with bit-field instead of signed type
Date: Fri, 16 Dec 2016 11:27:22 +0100
Message-ID: <71482367-41de-e29b-28db-54defb24ab2b@st.com>
References: <20161216092654.7773-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161216092654.7773-1-o-takashi@sakamocchi.jp>
Sender: stable-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jyri Sarha <jsarha@ti.com>, Jie Qiu <jie.qiu@mediatek.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Reviewed and tested for sti machine.

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Regards
Arnaud

On 12/16/2016 10:26 AM, Takashi Sakamoto wrote:
> This is a fix for Linux 4.10-rc1.
> 
> In C language specification, a bit-field is interpreted as a signed or
> unsigned integer type consisting of the specified number of bits.
> 
> In GCC manual, the range of a signed bit field of N bits is from
> -(2^N) / 2 to ((2^N) / 2) - 1
> https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html#Bit-Fields
> 
> Therefore, when defined as 1 bit-field with signed type, variables can
> represents -1 and 0.
> 
> The snd-soc-hdmi-codec module includes a structure which has signed type
> members with bit-fields. Codes of this module assign 0 and 1 to the
> members. This seems to result in implementation-dependent behaviours.
> 
> As of v4.10-rc1 merge window, outside of sound subsystem, this structure
> is referred by below GPU modules.
>  - tda998x
>  - sti-drm
>  - mediatek-drm-hdmi
>  - msm
> 
> As long as I review their codes relevant to the structure, the structure
> members are used just for condition statements and printk formats.
> My proposal of change is a bit intrusive to the printk formats but this
> may be acceptable.
> 
> Totally, it's reasonable to use unsigned type for the structure members.
> This bug is detected by Sparse, static code analyzer with below warnings.
> 
> ./include/sound/hdmi-codec.h:39:26: error: dubious one-bit signed bitfield
> ./include/sound/hdmi-codec.h:40:28: error: dubious one-bit signed bitfield
> ./include/sound/hdmi-codec.h:41:29: error: dubious one-bit signed bitfield
> ./include/sound/hdmi-codec.h:42:31: error: dubious one-bit signed bitfield
> 
> CC: Jyri Sarha <jsarha@ti.com>
> CC: Jie Qiu <jie.qiu@mediatek.com>
> CC: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> CC: dri-devel@lists.freedesktop.org
> CC: stable@vger.kernel.org
> Fixes: 09184118a8ab ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  include/sound/hdmi-codec.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 530c57b..915c435 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -36,10 +36,10 @@ struct hdmi_codec_daifmt {
>  		HDMI_AC97,
>  		HDMI_SPDIF,
>  	} fmt;
> -	int bit_clk_inv:1;
> -	int frame_clk_inv:1;
> -	int bit_clk_master:1;
> -	int frame_clk_master:1;
> +	unsigned int bit_clk_inv:1;
> +	unsigned int frame_clk_inv:1;
> +	unsigned int bit_clk_master:1;
> +	unsigned int frame_clk_master:1;
>  };
>  
>  /*
> 
