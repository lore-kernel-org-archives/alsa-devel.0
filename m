From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: skip legacy dai naming if dai driver
 has	all the information
Date: Fri, 15 May 2015 13:07:53 -0700
Message-ID: <20150515200752.GA30834@kwestfie-linux.qualcomm.com>
References: <1431682707-26452-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431682707-26452-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 15, 2015 at 02:38:27AM -0700, Srinivas Kandagatla wrote:
> Original issue is that the id field in the dai is not same as the id
> in dai_driver when dai driver count == 1. This is due to the legacy
> dai naming check, which could possibly cause issues if the audio drivers
> written in assumption that dai->id would be always equal to
> dai_driver->id.
> This assumption is true only if the dai driver count is greater than 1,
> and false if dai driver count is 1. On Qcom Lpass driver we hit such
> issue while adding support to apq8016.
> 
> The code path which falls back to legacy naming for cases where num_dai
> == 1 does not check if there is any valid information in the dai_driver.
> This patch fixes that by checking if the dai_driver has valid id and
> name before falling back to legacy dai naming
> Although the drivers can work around this issue by only using
> dai->driver->id, but this patch attempts to fix the actual issue.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
