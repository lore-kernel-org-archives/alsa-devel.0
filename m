From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 14/14] ASoC: qcom: document apq8016 machine driver
 bindings
Date: Tue, 05 May 2015 08:17:01 +0100
Message-ID: <55486E6D.9010402@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <1430414306-11469-1-git-send-email-srinivas.kandagatla@linaro.org> <20150503000307.GG27804@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150503000307.GG27804@kwestfie-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 03/05/15 01:03, Kenneth Westfield wrote:
> On Thu, Apr 30, 2015 at 06:18:26PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings for apq8016 machine driver.
>> On APQ8016 4 MI2S can be configured to different sinks like internal
>> codec/external codec, this connection is controlled via 2 iomux
>> registers.
>>
>> +sound: sound {
>> +	compatible = "qcom,apq8016-sndcard";
>> +	reg = <0x07702000 0x4>, <0x07702004 0x4>;
>> +	reg-names = "mic-iomux", "spkr-iomux";
>> +	qcom,model = "DB410c";
>> +
>> +	/* I2S - Internal codec */
>> +	internal-dai-link@0 {
>> +		cpu { /* PRIMARY */
>> +			sound-dai = <&lpass MI2S_PRIMARY>;
>> +		};
>> +		codec {
>> +			sound-dai = <&wcd_codec 0>;
>> +		};
>> +	};
>> +
>> +	/* External Primary or External Secondary -ADV7533 HDMI */
>> +	external-dai-link@0 {
>> +		external;
>> +		cpu { /* QUAT */
>> +			sound-dai = <&lpass MI2S_QUATERNARY>;
>> +		};
>> +		codec {
>> +			sound-dai = <&adv_bridge 0>;
>> +		};
>> +	};
>> +};
>
> OK, although I will need to double-check this with the spec, it seems
> (from the patches) that there are 4 I2S ports, 2 of which are being
> used.  Usually, multi-channel audio is sent to the primary dai (which
> is MI2S), which then gets sent to the other ports by HW.  If that holds
> true for this SOC, then the external cpu dai should be labelled I2S,
> not MI2S.  If not, then both should be labelled as I2S (and the DAI
> channel constraints should be reduced to 1-2).
>
I have got very limited access to documentation, which obviously does 
not have any info related to channel capabilities. I was thinking that 
all the playback ports support multi-channel. I might be wrong though.

> Looking at patch 12, the internal DAI is labelled Headset and the
> external DAI is labelled HDMI.
This naming is very specific to the SBC board.

   I will check the spec to see if the QUAT
> I2S port can handle multi-channel.
External HDMI bridge on the other side only supports 2-channels, but if 
you can re-check on the channel capabilities would be good.

--srini

>
