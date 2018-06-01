From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/2] slimbus: Add QCOM SLIMBus NGD driver
Date: Fri, 1 Jun 2018 10:44:26 +0530
Message-ID: <20180601051426.GL16230@vkoul-mobl>
References: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 25-05-18, 12:15, Srinivas Kandagatla wrote:
> This patchset adds support to basic version of Qualcomm NGD SLIMBus
> controller driver found SoCs from B family.
> 
> This controller is light-weight SLIMBus controller driver responsible for
> communicating with slave HW directly over the bus using messaging
> interface, and communicating with master component residing on ADSP
> for bandwidth and data-channel management.
> 
> Tested this patchset on DB820c with WCD9335 codec.
> I have pushed my working branch to [1] incase someone want to try.
> 
> This patch has dependency on https://lkml.org/lkml/2018/5/17/251

Looks good to me know, FWIW:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
