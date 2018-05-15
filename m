From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v8 08/24] ASoC: qdsp6: q6core: Add q6core
	driver
Date: Tue, 15 May 2018 00:44:05 -0700
Message-ID: <fa023436-fa6b-5ed1-85b2-8d144bd37afa@codeaurora.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-9-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id D7AE7266F69
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 09:44:09 +0200 (CEST)
In-Reply-To: <20180509125635.5653-9-srinivas.kandagatla@linaro.org>
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


On 5/9/2018 5:56 AM, Srinivas Kandagatla wrote:
> This patch adds support to core apr service, which is used to query
> status of other static and dynamic services on the dsp.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6core.c | 380 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6core.h |  15 ++
>   4 files changed, 400 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6core.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6core.h
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
