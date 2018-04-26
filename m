From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Date: Thu, 26 Apr 2018 16:16:48 -0500
Message-ID: <20180426211648.GB25699@hector.attlocal.net>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added removed
> more dynamically depending on the state of the services on the dsp.
> APR is used for communication between application processor and QDSP to
> use services on QDSP like Audio and others.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---

Acked-by: Andy Gross <andy.gross@linaro.org>
