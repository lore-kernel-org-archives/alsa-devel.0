From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 2/3] ASoC: Add codec driver for ST TDA7802
Date: Wed, 31 Jul 2019 09:57:12 +0100
Message-ID: <820e2ea9-14a2-795c-9b78-e8f2a30afdb1@codethink.co.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-3-thomas.preston@codethink.co.uk>
 <20190730145844.GI4264@sirena.org.uk>
 <fe11c806-2285-558c-e35c-d8f61de00784@codethink.co.uk>
 <20190731060644.yrewu2kvrlootyyl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731060644.yrewu2kvrlootyyl@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Annaliese McDermond <nh6z@nh6z.net>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Patrick Glaser <pglaser@tesla.com>, Rob Duncan <rduncan@tesla.com>, Jerome Brunet <jbrunet@baylibre.com>, Nate Case <ncase@tesla.com>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 31/07/2019 07:06, Marco Felsch wrote:
> Hi Thomas,
> 
> again sorry for jumping in..
> 

Np!

> On 19-07-30 18:26, Thomas Preston wrote:
>> On 30/07/2019 15:58, Mark Brown wrote:
>>> On Tue, Jul 30, 2019 at 01:09:36PM +0100, Thomas Preston wrote:
>>>> +	case SND_SOC_BIAS_STANDBY:
>>>> +		err = regulator_enable(tda7802->enable_reg);
>>>> +		if (err < 0) {
>>>> +			dev_err(component->dev, "Could not enable.\n");
>>>> +			return err;
>>>> +		}
>>>> +		dev_dbg(component->dev, "Regulator enabled\n");
>>>> +		msleep(ENABLE_DELAY_MS);
>>>
>>> Is this delay needed by the device or is it for the regulator to ramp?
>>> If it's for the regulator to ramp then the regulator should be doing it.
>>>
>>
>> According to the datasheet the device itself takes 10ms to rise from 0V
>> after PLLen is enabled. There are additional rise times but they are
>> negligible with default capacitor configuration (which we have).
>>
>> Good to know about the regulator rising configuration though. Thanks.
> 
> Isn't it the regulator we mentioned to not use that because it is a
> GPIO?
> 

Yeah it is - I intend to switch PLLen to gpio API.
