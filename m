From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: q6asm-dai: dt-bindings: Add
 support to compress dais
Date: Sun, 16 Sep 2018 17:32:44 -0500
Message-ID: <5b9f3f56.1c69fb81.d6be8.278d@mx.google.com>
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
 <20180903123455.9290-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 14EB32676AA
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 07:44:55 +0200 (CEST)
Received: by mail-it0-f68.google.com with SMTP id d10-v6so9564155itj.5
 for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2018 22:44:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180903123455.9290-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon,  3 Sep 2018 13:34:53 +0100, Srinivas Kandagatla wrote:
> This patch adds board specific bindings required for dais, In particular
> for compressed dais and dai direction.
> 
> Board specific setup involves setting up some of dais as compressed dais
> and also specify direction of any dai. Some of the dais might only
> support capture/playback depending on the board level wiring.
> 
> These two new dt properties will allow such flexibilty at board level dts.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6asm.txt  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
