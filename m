From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v7 07/24] ASoC: qdsp6: q6common: Add qdsp6
 helper functions
Date: Thu, 3 May 2018 18:35:10 -0700
Message-ID: <28f86f87-b28e-bec8-1a74-a218afeac0cc@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-8-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 4579A266F44
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 03:35:13 +0200 (CEST)
In-Reply-To: <20180501120820.11016-8-srinivas.kandagatla@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds some common helper functions like translating dsp error
> to linux error codes and channel mappings etc.
>
> These functions are used in all the following qdsp6 drivers.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig              | 13 ++++++++
>   sound/soc/qcom/Makefile             |  3 ++
>   sound/soc/qcom/qdsp6/Makefile       |  1 +
>   sound/soc/qcom/qdsp6/q6dsp-common.c | 66 +++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6dsp-common.h | 24 ++++++++++++++
>   sound/soc/qcom/qdsp6/q6dsp-errno.h  | 51 ++++++++++++++++++++++++++++
>   6 files changed, 158 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/Makefile
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
