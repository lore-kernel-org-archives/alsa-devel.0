From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] wcd9335: Remove unnecessary null checks in
 wcd9335_set_channel_map
Date: Thu, 31 Jan 2019 10:53:45 +0000
Message-ID: <eac1b134-8d9e-21d4-d749-b40b98348eff@linaro.org>
References: <20190129214847.6341-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129214847.6341-1-natechancellor@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the patch!

On 29/01/2019 21:48, Nathan Chancellor wrote:
> Clang warns:
> 
> sound/soc/codecs/wcd9335.c:2004:11: warning: address of array
> 'wcd->rx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
>          if (wcd->rx_chs) {
>          ~~  ~~~~~^~~~~~
> sound/soc/codecs/wcd9335.c:2012:11: warning: address of array
> 'wcd->tx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
>          if (wcd->tx_chs) {
>          ~~  ~~~~~^~~~~~
> 2 warnings generated.
> 
> Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
