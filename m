From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 3/5] ASoC: apq8016-sbc: dt bindings: remove incorrect
 property
Date: Fri, 16 Sep 2016 10:45:41 -0500
Message-ID: <20160916154541.GA17403@rob-hp-laptop>
References: <1473339896-9409-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473339896-9409-4-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473339896-9409-4-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 08, 2016 at 02:04:54PM +0100, Srinivas Kandagatla wrote:
> This patch removes capture-dai property which should not have existed
> in this document in the first place. It looks like leftover from old
> version of patches by mistake.
> 
> Remove it to avoid any confusion in future.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
