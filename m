From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v7 10/24] ASoC: qdsp6: qdafe: Add SLIMBus
	port Support
Date: Tue, 8 May 2018 19:55:55 -0700
Message-ID: <448ccddb-b28d-65c9-f502-755b3403f72a@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-11-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 9734C2676AA
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 04:55:58 +0200 (CEST)
In-Reply-To: <20180501120820.11016-11-srinivas.kandagatla@linaro.org>
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
> This patch adds support to 6 SLIMBus AFE ports, which are used as
> backend dais.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6afe.c | 129 +++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h |  14 +++++
>   2 files changed, 143 insertions(+)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
