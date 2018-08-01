From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: Applied "ASoC: wcd9335: add support to wcd9335 codec" to the asoc
 tree
Date: Wed, 1 Aug 2018 13:24:32 +0100
Message-ID: <2b90faa5-6fd9-f769-183e-23cb59bf460e@linaro.org>
References: <20180801112011.33C511124241@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180801112011.33C511124241@debutante.sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 01/08/18 12:20, Mark Brown wrote:
> +#include <sound/soc.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/tlv.h>
> +#include <sound/info.h>
> +#include <dt-bindings/mfd/wcd9335.h>
> +#include <linux/mfd/wcd9335/wcd9335.h>
> +#include <linux/mfd/wcd9335/registers.h>

Without the "[PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core" 
It would break the build.

--srini
