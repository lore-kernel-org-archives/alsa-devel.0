From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH 1/3] ASoC: lpass-platform: use dma_ch instead of
 rdma_ch/wrdma_ch
Date: Sat, 29 Oct 2016 09:12:31 -0700
Message-ID: <20161029161231.GA24622@kwestfie-linux.qualcomm.com>
References: <1477668740-30389-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1477668740-30389-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477668740-30389-2-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 28, 2016 at 04:32:18PM +0100, Srinivas Kandagatla wrote:
> This patch cleans up usage of wrdma_ch and rdma_ch variables into a
> common variable dma_ch, As there is no real use of tracking the dma
> channel in two different variables based on stream direction.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/lpass-platform.c | 53 +++++++++++++----------------------------
>  1 file changed, 17 insertions(+), 36 deletions(-)

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
