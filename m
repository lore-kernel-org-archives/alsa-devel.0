From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: q6asm-dai: dt-bindings: Add support to
 compress dais
Date: Tue, 4 Sep 2018 19:02:50 +0530
Message-ID: <20180904133250.GJ2322@vkoul-mobl>
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
 <20180903123455.9290-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180903123455.9290-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, mark.rutland@arm.com
List-Id: alsa-devel@alsa-project.org

On 03-09-18, 13:34, Srinivas Kandagatla wrote:
> This patch adds board specific bindings required for dais, In particular
> for compressed dais and dai direction.
> 
> Board specific setup involves setting up some of dais as compressed dais
> and also specify direction of any dai. Some of the dais might only
> support capture/playback depending on the board level wiring.
> 
> These two new dt properties will allow such flexibilty at board level dts.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
