From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH RFC 13/15] ASoC: qcom: apq8016: set the
 correct	max register for regmap
Date: Tue, 2 Feb 2016 16:37:35 -0800
Message-ID: <20160203003735.GN14436@kwestfie-linux.qualcomm.com>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347778-11002-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454347778-11002-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 09:29:38AM -0800, Srinivas Kandagatla wrote:
> Now that we are ready to access wrdma registers, set the max register
> and other regmap related configs to use correct values.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/lpass-cpu.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
