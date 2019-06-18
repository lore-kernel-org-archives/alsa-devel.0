From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: common: Fix NULL pointer in of parser
Date: Tue, 18 Jun 2019 09:12:58 +0100
Message-ID: <ad8ef1b1-a69c-df2f-cec4-d69278b570dc@linaro.org>
References: <20190618052813.32523-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190618052813.32523-1-bjorn.andersson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks Bjorn for this patch.

On 18/06/2019 06:28, Bjorn Andersson wrote:
> A snd_soc_dai_link_component is allocated and associated with the first
> link, so when the code tries to assign the of_node of the second link's
> "cpu" member it dereferences a NULL pointer.
> 
> Fix this by moving the allocation and assignement of
> snd_soc_dai_link_components into the loop, giving us one pair per link.
> 
> Fixes: 1e36ea360ab9 ("ASoC: qcom: common: use modern dai_link style")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I think the original patch did not realize that there are multiple links!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
