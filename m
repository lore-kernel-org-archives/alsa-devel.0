From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH 2/3] ASoC: lpass-platform: Fix broken pcm data usage
Date: Sat, 29 Oct 2016 09:14:01 -0700
Message-ID: <20161029161401.GB24622@kwestfie-linux.qualcomm.com>
References: <1477668740-30389-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1477668740-30389-3-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477668740-30389-3-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 28, 2016 at 04:32:19PM +0100, Srinivas Kandagatla wrote:
> This patch fixes lpass-platform driver which was broken in v4.9-rc1.
> lpass_pcm_data data structure holds information specific to stream.
> Holding a single private pointer to it in global lpass_data
> will not work, because it would be overwritten by for each pcm instance.
> 
> This code was breaking playback when we have both playback and capture
> pcm streams, as playback settings are over written by capture settings.
> 
> Fix this by moving channel allocation logic out of pcm_new to pcm_open
> so that we can store the stream specific information private_data of
> snd_pcm_runtime.
> 
> Fixes: 6adcbdcd4b6e ("ASoC: lpass-platform: don't use snd_soc_pcm_set_drvdata()")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/lpass-platform.c | 151 ++++++++++++++++++----------------------
>  sound/soc/qcom/lpass.h          |   1 -
>  2 files changed, 67 insertions(+), 85 deletions(-)

After you address Mark's comments:

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
