From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 4/5] ASoC: qcom: apq8016-sbc: Add support to multi
 codec.
Date: Fri, 16 Sep 2016 14:12:41 -0500
Message-ID: <20160916191241.GA17692@rob-hp-laptop>
References: <1473339896-9409-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473339896-9409-5-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473339896-9409-5-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 08, 2016 at 02:04:55PM +0100, Srinivas Kandagatla wrote:
> This patch adds support to multi codec, as the msm8916 codec is now
> split into two codecs, Analog and Digital.
> 
> Also update the bindings and example to show that the card supports
> multicodec.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt |  4 ++--
>  sound/soc/qcom/apq8016_sbc.c                                 | 11 +++--------
>  2 files changed, 5 insertions(+), 10 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
