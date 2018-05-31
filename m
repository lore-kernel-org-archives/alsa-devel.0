From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt
 bindings
Date: Wed, 30 May 2018 22:32:42 -0500
Message-ID: <20180531033242.GA24141@rob-hp-laptop>
References: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
 <20180525111547.18556-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180525111547.18556-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 25, 2018 at 12:15:46PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm SLIMBus NGD controller.
> SLIMBus NGD controller is a light-weight driver responsible for
> communicating with SLIMBus slaves directly over the bus using messaging
> interface and communicating with master component residing on ADSP for
> bandwidth and data-channel management
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt

Reviewed-by: Rob Herring <robh@kernel.org>
