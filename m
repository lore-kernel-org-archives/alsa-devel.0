From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH RFC 09/15] ASoC: qcom: rename
 rdma_ch_bit_map	to dma_ch_bit_map
Date: Tue, 2 Feb 2016 16:37:06 -0800
Message-ID: <20160203003705.GJ14436@kwestfie-linux.qualcomm.com>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347747-10758-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454347747-10758-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 09:29:07AM -0800, Srinivas Kandagatla wrote:
> rdma_ch_bit_map can be reused for wrdma channel allocations as wrdma
> channel numbering start after rdma channel numbers.
> With capture support referring rdma_ch_bit_map for wrdma channel
> allocation
> is confusing, so renaming rdma_ch_bit_map to dma_ch_bit_map makes sense.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/lpass-apq8016.c | 6 +++---
>  sound/soc/qcom/lpass.h         | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

As stated in my comments on patch 3 (ASoC: qcom: rename
rdmactl_audif_start to dmactrl_audif_start), I believe this change could
be combined with that patch.  Or at the very least, have this patch be
sequenced directly after patch 3.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
