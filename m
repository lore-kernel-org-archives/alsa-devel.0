From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 00/12] ASoC: qdsp6: Fix dt based module loading and
 minor fixes
Date: Tue, 26 Jun 2018 11:43:07 +0200
Message-ID: <20180626094307.GI25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 26, 2018 at 10:20:04AM +0100, Srinivas Kandagatla wrote:
> Recent discussion on https://lkml.org/lkml/2018/6/18/1282 suggested
> that qdsp6 code is using less common of_platform apis which would
> not give dt based module loading support.
> 
> Suggestion from Rob was to add compatible strings to the dais nodes
> This patchset adds this. Also this patchset has 3 trivial fixes which
> is removing redundant owner, remove unused struct member and fix a
> error check in q6routing.
> 
> Changes since v1:
> - Addressed few trivial comments from Niklas

Hello Srini!

I didn't see a response to my review comment in:
https://marc.info/?l=devicetree&m=152998662313684

"Since adding the compatible is a prerequisite for using
of_platform_populate()/of_platform_depopulate(),
I think that the patches that make use of
of_platform_populate()/of_platform_depopulate() should
come after the patches that adds the of_table entries."

If the code is bisectable with the current ordering
of the patches, then feel free to ignore this review
comment.

Kind regards,
Niklas

> 
> Thanks,
> srini
> 
> Srinivas Kandagatla (12):
>   ASoC: q6adm: dt-bindings: add compatible string to routing
>   ASoC: q6asm: dt-bindings: add compatible string to dais
>   ASoC: q6afe: dt-bindings: add compatible string to dais
>   ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()
>   ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()
>   ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()
>   ASoC: qdsp6: q6afe-dai: support dt based module loading
>   ASoC: qdsp6: q6asm-dai: support dt based module loading
>   ASoC: qdsp6: q6routing: support dt based module loading
>   ASoC: qcom: apq8096: remove redundant owner assignment
>   ASoC: qdsp6: q6routing: add proper error check
>   ASoC: qdsp6: q6asm: remove unused struct q6asm member
> 
>  Documentation/devicetree/bindings/sound/qcom,q6adm.txt |  6 ++++++
>  Documentation/devicetree/bindings/sound/qcom,q6afe.txt |  6 ++++++
>  Documentation/devicetree/bindings/sound/qcom,q6asm.txt |  6 ++++++
>  sound/soc/qcom/apq8096.c                               |  1 -
>  sound/soc/qcom/qdsp6/q6adm.c                           | 16 ++--------------
>  sound/soc/qcom/qdsp6/q6afe-dai.c                       |  7 +++++++
>  sound/soc/qcom/qdsp6/q6afe.c                           | 16 ++--------------
>  sound/soc/qcom/qdsp6/q6asm-dai.c                       |  7 +++++++
>  sound/soc/qcom/qdsp6/q6asm.c                           | 17 ++---------------
>  sound/soc/qcom/qdsp6/q6routing.c                       |  9 ++++++++-
>  10 files changed, 46 insertions(+), 45 deletions(-)
> 
> -- 
> 2.16.2
> 
