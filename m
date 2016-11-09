From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH] ASoC: lpass-platform: initialize dma channel number
Date: Tue, 8 Nov 2016 22:06:43 -0800
Message-ID: <20161109060642.GA1486@kwestfie-linux.qualcomm.com>
References: <20161108133916.1742379-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161108133916.1742379-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kenneth Westfield <kwestfie@codeaurora.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 08, 2016 at 02:38:52PM +0100, Arnd Bergmann wrote:
> A bugfix accidentally removed the implicit initialization of the
> dma channel number, causing undefined behavior when
> v->alloc_dma_channel is NULL:
> 
> sound/soc/qcom/lpass-platform.c: In function ‘lpass_platform_pcmops_open’:
> sound/soc/qcom/lpass-platform.c:83:29: error: ‘dma_ch’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This adds back an explicit initialization to zero, restoring the
> previous behavior for that case.
> 
> Fixes: 022d00ee0b55 ("ASoC: lpass-platform: Fix broken pcm data usage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/qcom/lpass-platform.c | 3 +++
>  1 file changed, 3 insertions(+)

Good catch.

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
