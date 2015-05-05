From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: move ipq806x specific bits out
 of lpass driver.
Date: Tue, 05 May 2015 08:17:23 +0100
Message-ID: <55486E83.9030308@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <1430414213-10997-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235738.GB27804@kwestfie-linux.qualcomm.com> <20150505051913.GA12961@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150505051913.GA12961@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 05/05/15 06:19, Kenneth Westfield wrote:
>>> > >+enum lpaif_i2s_ports {
>>> > >+	LPAIF_I2S_PORT_MIN		= 0,
>>> > >+
>>> > >+	LPAIF_I2S_PORT_CODEC_SPK	= 0,
>>> > >+	LPAIF_I2S_PORT_CODEC_MIC	= 1,
>>> > >+	LPAIF_I2S_PORT_SEC_SPK		= 2,
>>> > >+	LPAIF_I2S_PORT_SEC_MIC		= 3,
>>> > >+	LPAIF_I2S_PORT_MI2S		= 4,
>>> > >+
>>> > >+	LPAIF_I2S_PORT_MAX		= 4,
>>> > >+	LPAIF_I2S_PORT_NUM		= 5,
>>> > >+};
>> >
>> >These port mappings here...
>> >
>>> > >+enum lpaif_irq_ports {
>>> > >+	LPAIF_IRQ_PORT_MIN		= 0,
>>> > >+
>>> > >+	LPAIF_IRQ_PORT_HOST		= 0,
>>> > >+	LPAIF_IRQ_PORT_ADSP		= 1,
>>> > >+
>>> > >+	LPAIF_IRQ_PORT_MAX		= 2,
>>> > >+	LPAIF_IRQ_PORT_NUM		= 3,
>>> > >+};
>> >
>> >...here...
>> >
>>> > >+enum lpaif_dma_channels {
>>> > >+	LPAIF_RDMA_CHAN_MIN		= 0,
>>> > >+
>>> > >+	LPAIF_RDMA_CHAN_MI2S		= 0,
>>> > >+	LPAIF_RDMA_CHAN_PCM0		= 1,
>>> > >+	LPAIF_RDMA_CHAN_PCM1		= 2,
>>> > >+
>>> > >+	LPAIF_RDMA_CHAN_MAX		= 4,
>>> > >+	LPAIF_RDMA_CHAN_NUM		= 5,
>>> > >+};
>> >
>> >...and here can be SOC-specific.  Should move them to the SOC-specific
>> >files.
> Expanding on this, the I2S port mappings for the APQ8016 should replace
> the ones defined above with the constants you refer to in
> dt-bindings/sound/apq8016.h:
>     MI2S_PRIMARY
>     MI2S_SECONDARY
>     etc.
>
> Maybe defining a corresponding ipq806x.h in the same directory, and
> moving the above definitions there?

As you pointed out i2s ports definitions can be moved to 
dt-bindings/soc/ipq806x.h but the channels can be directly defined in 
lpass-ipq806x.c as there would be no DT consumers for these defines anyway.

--srini
