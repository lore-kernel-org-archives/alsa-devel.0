From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/5] ASoC: core: add support to card re-bind using
 component framework
Date: Mon, 16 Jul 2018 09:56:43 +0530
Message-ID: <20180716042643.GA3219@vkoul-mobl>
References: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 13-07-18, 16:36, Srinivas Kandagatla wrote:
> During discussion regarding card re-binding when components unregister
> and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
> that component framework can be added into core to provide this feature.
> 
> With this new changes the card will re-bind once the dependent component
> re-registers after unregistering. This works based on the match done
> from component name using component framework.
> 
> I have tested this patch with qdsp start-stop and module-load-unload usecase
> for more than 10000 times in loop on Qcom platforms.

>  6 files changed, 89 insertions(+), 156 deletions(-)

Looks good to me with a nice diff stat.

FWIW:
Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
