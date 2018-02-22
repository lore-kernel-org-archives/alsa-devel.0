From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 24/25] ASoC: qcom: apq8096: Add db820c
 machine driver
Date: Thu, 22 Feb 2018 11:13:21 +0000
Message-ID: <d3727be9-b8d1-68f1-d862-c6f5e3a83fea@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
 <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 38F352676E7
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:13:24 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id k87so3153949wmi.0
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 03:13:24 -0800 (PST)
In-Reply-To: <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
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
To: Rohit Kumar <rohitkr@codeaurora.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 22/02/18 11:00, Rohit Kumar wrote:
>> +config SND_SOC_MSM8996
>> +    tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
>> +    depends on QCOM_APR
>> +    select SND_SOC_QDSP6V2
> should be select SND_SOC_QDSP6, V2 is not defined

I will fix this in next version.

--srini
