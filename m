From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [RFC PATCH 12/14] ASoC: qcom: add apq8016 sound card support
Date: Sat, 2 May 2015 17:01:54 -0700
Message-ID: <20150503000154.GF27804@kwestfie-linux.qualcomm.com>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1430414287-11384-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430414287-11384-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 06:18:07PM +0100, Srinivas Kandagatla wrote:
> This patch adds apq8016 machine driver support. This patch was tested on
> two apq8016-sbc and msm8916-mtp board for both hdmi and analog audio
> features.

apq8016 refers to the SOC, whereas machine drivers are board-specific.
Better to reference the board (or SOC-Codec combo) instead.

> ---
>  sound/soc/qcom/Kconfig   |   9 ++
>  sound/soc/qcom/Makefile  |   1 +
>  sound/soc/qcom/apq8016.c | 214 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 sound/soc/qcom/apq8016.c


-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
