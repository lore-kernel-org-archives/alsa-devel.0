From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Fri, 29 May 2015 16:10:54 +0200
Message-ID: <5568736E.5090801@metafoo.de>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
 <1432906281-27698-7-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id CB7EB2606BF
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 16:10:55 +0200 (CEST)
In-Reply-To: <1432906281-27698-7-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn
List-Id: alsa-devel@alsa-project.org

On 05/29/2015 03:31 PM, Jun Nie wrote:
> Add zx296702 hdmi codec to enable SPDIF and I2S output
> via HDMI. The SPDIF/I2S route is exclusive with current
> software config and need specify which is valid in
> defconfig.

That's an issue, the hardware configuration should not depend on kernel 
configuration setting. This makes it impossible to run the same kernel on 
platforms with conflicting settings. It should be possible to configure this 
dynamically at boot time based on platform_data/devicetree, etc.

But is this device real hardware anyway?

>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>   include/sound/zx_hdmi_audio.h    |   7 +++
>   sound/soc/codecs/Kconfig         |   3 +
>   sound/soc/codecs/Makefile        |   1 +
>   sound/soc/codecs/zx296702_hdmi.c | 121 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 132 insertions(+)
>   create mode 100644 include/sound/zx_hdmi_audio.h
>   create mode 100644 sound/soc/codecs/zx296702_hdmi.c
>
> diff --git a/include/sound/zx_hdmi_audio.h b/include/sound/zx_hdmi_audio.h
> new file mode 100644
> index 0000000..7eb0e81
> --- /dev/null
> +++ b/include/sound/zx_hdmi_audio.h
> @@ -0,0 +1,7 @@
> +#ifndef __ZX_HDMI_AUDIO_H__
> +#define __ZX_HDMI_AUDIO_H__
> +
> +int zx_hdmi_audio_cfg(int audio_codec, int audio_way,
> +		      u32 sample_rate, u32 sample_len);
> +void zx_hdmi_audio_en(int on);

Where is the implementation for these functions? The fact that they seem to 
operate on global state indicates that something is wrong wit this API.

> +#endif /* __ZX_HDMI_AUDIO_H__ */
