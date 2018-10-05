From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2 5/5] ASoC: qdsp6: q6asm-dai: Add support to compress
 offload
Date: Fri, 5 Oct 2018 06:09:19 +0530
Message-ID: <20181005003919.GH2372@vkoul-mobl>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
 <20180926102349.23481-6-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926102349.23481-6-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org, mark.rutland@arm.com
List-Id: alsa-devel@alsa-project.org

On 26-09-18, 11:23, Srinivas Kandagatla wrote:
> This patch adds MP3 playback support in q6asm dais, adding other codec
> support should be pretty trivial.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/Kconfig           |   1 +
>  sound/soc/qcom/qdsp6/q6asm-dai.c | 377 ++++++++++++++++++++++++++++++-
>  2 files changed, 377 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 2a4c912d1e48..ebf991bb546c 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -66,6 +66,7 @@ config SND_SOC_QDSP6_ASM
>  	tristate
>  
>  config SND_SOC_QDSP6_ASM_DAI
> +	select SND_SOC_COMPRESS
>  	tristate
>  
>  config SND_SOC_QDSP6
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 9db9a2944ef2..57b8abcbebcd 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -11,6 +11,8 @@
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
>  #include <sound/pcm.h>
> +#include <linux/spinlock.h>
> +#include <sound/compress_driver.h>
>  #include <asm/dma.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of_device.h>
> @@ -31,6 +33,16 @@
>  #define CAPTURE_MIN_PERIOD_SIZE     320
>  #define SID_MASK_DEFAULT	0xF
>  
> +/* Default values used if user space does not set */
> +#define COMPR_PLAYBACK_MIN_FRAGMENT_SIZE (8 * 1024)
> +#define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
> +#define COMPR_PLAYBACK_MIN_NUM_FRAGMENTS (4)
> +#define COMPR_PLAYBACK_MAX_NUM_FRAGMENTS (16 * 4)
> +#define Q6ASM_DAI_TX_RX	0
> +#define Q6ASM_DAI_TX	1
> +#define Q6ASM_DAI_RX	2
> +
> +

Unnecessary double space

>  enum stream_state {
>  	Q6ASM_STREAM_IDLE = 0,
>  	Q6ASM_STREAM_STOPPED,
> @@ -39,11 +51,22 @@ enum stream_state {
>  
>  struct q6asm_dai_rtd {
>  	struct snd_pcm_substream *substream;
> +	struct snd_compr_stream *cstream;
> +	struct snd_compr_params codec_param;
> +	struct snd_dma_buffer dma_buffer;
> +
>  	phys_addr_t phys;
> +	spinlock_t lock;

why would we need a lock for compress case?

-- 
~Vinod
