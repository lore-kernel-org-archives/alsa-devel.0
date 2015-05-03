From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [RFC PATCH 14/14] ASoC: qcom: document apq8016 machine driver
 bindings
Date: Sat, 2 May 2015 17:03:07 -0700
Message-ID: <20150503000307.GG27804@kwestfie-linux.qualcomm.com>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1430414306-11469-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430414306-11469-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 06:18:26PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for apq8016 machine driver.
> On APQ8016 4 MI2S can be configured to different sinks like internal
> codec/external codec, this connection is controlled via 2 iomux
> registers.
> 
> +sound: sound {
> +	compatible = "qcom,apq8016-sndcard";
> +	reg = <0x07702000 0x4>, <0x07702004 0x4>;
> +	reg-names = "mic-iomux", "spkr-iomux";
> +	qcom,model = "DB410c";
> +
> +	/* I2S - Internal codec */
> +	internal-dai-link@0 {
> +		cpu { /* PRIMARY */
> +			sound-dai = <&lpass MI2S_PRIMARY>;
> +		};
> +		codec {
> +			sound-dai = <&wcd_codec 0>;
> +		};
> +	};
> +
> +	/* External Primary or External Secondary -ADV7533 HDMI */
> +	external-dai-link@0 {
> +		external;
> +		cpu { /* QUAT */
> +			sound-dai = <&lpass MI2S_QUATERNARY>;
> +		};
> +		codec {
> +			sound-dai = <&adv_bridge 0>;
> +		};
> +	};
> +};

OK, although I will need to double-check this with the spec, it seems
(from the patches) that there are 4 I2S ports, 2 of which are being
used.  Usually, multi-channel audio is sent to the primary dai (which
is MI2S), which then gets sent to the other ports by HW.  If that holds
true for this SOC, then the external cpu dai should be labelled I2S,
not MI2S.  If not, then both should be labelled as I2S (and the DAI
channel constraints should be reduced to 1-2).

Looking at patch 12, the internal DAI is labelled Headset and the
external DAI is labelled HDMI.  I will check the spec to see if the QUAT
I2S port can handle multi-channel.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
