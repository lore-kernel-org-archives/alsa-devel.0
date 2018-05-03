From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v7 04/24] ASoC: qdsp6: dt-bindings: Add
	q6afe dt bindings
Date: Thu, 3 May 2018 16:50:47 -0700
Message-ID: <f84b5c02-69d4-9ad0-2624-49ca98595d27@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id E517D267281
 for <alsa-devel@alsa-project.org>; Fri,  4 May 2018 01:50:50 +0200 (CEST)
In-Reply-To: <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
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
> This patch add DT bindings for AFE (Audio Frontend) DSP module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   .../devicetree/bindings/sound/qcom,q6afe.txt       | 104 +++++++++++++++++++++
>   include/dt-bindings/sound/qcom,q6afe.h             |  31 ++++++
>   2 files changed, 135 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>   create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
