From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 01/24] soc: qcom dt-bindings: Add APR
	bus bindings
Date: Fri, 27 Apr 2018 09:07:38 -0500
Message-ID: <20180427140738.lpoi7ow7bgzjrumf@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 378622677FD
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 16:07:40 +0200 (CEST)
Received: by mail-ot0-f195.google.com with SMTP id 77-v6so2158146otd.4
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 07:07:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 10:45:43AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> bus driver. This bus is used for communicating with DSP which provides
> audio and various other services to cpu.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 84 ++++++++++++++++++++++
>  include/dt-bindings/soc/qcom,apr.h                 | 28 ++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>  create mode 100644 include/dt-bindings/soc/qcom,apr.h

Reviewed-by: Rob Herring <robh@kernel.org>
