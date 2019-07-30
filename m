From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802
 amplifier
Date: Tue, 30 Jul 2019 15:12:21 +0100
Message-ID: <16a99e45-fd5a-2878-acf9-63518f9ca527@codethink.co.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
 <20190730122748.GF54126@ediswmail.ad.cirrus.com>
 <20190730131209.rdv2kdlrpfeouh66@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730131209.rdv2kdlrpfeouh66@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Felsch <m.felsch@pengutronix.de>, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Rob Duncan <rduncan@tesla.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Annaliese McDermond <nh6z@nh6z.net>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Nate Case <ncase@tesla.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Patrick Glaser <pglaser@tesla.com>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 30/07/2019 14:12, Marco Felsch wrote:
> Hi Charles,
> 
> sorry for jumping in..
> 
> On 19-07-30 13:27, Charles Keepax wrote:
>> On Tue, Jul 30, 2019 at 01:09:35PM +0100, Thomas Preston wrote:
>>> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
>>> Cc: Patrick Glaser <pglaser@tesla.com>
>>> Cc: Rob Duncan <rduncan@tesla.com>
>>> Cc: Nate Case <ncase@tesla.com>
>>> ---
>>>  .../devicetree/bindings/sound/tda7802.txt     | 26 +++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
>>> new file mode 100644
>>> index 000000000000..f80aaf4f1ba0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
>>> @@ -0,0 +1,26 @@
>>> +ST TDA7802 audio processor
>>> +
>>> +This device supports I2C only.
>>> +
>>> +Required properties:
>>> +
>>> +- compatible : "st,tda7802"
>>> +- reg : the I2C address of the device
>>> +- enable-supply : a regulator spec for the PLLen pin
> 
> Shouldn't that be a pin called 'pllen-gpios'? IMHO I would not use a
> regulator for that.
> 
> Regards,
>   Marco
> 

Hi Marco,
We have multiple amplifiers hooked up in a chain, and all the PLLens
are connected to one GPIO. So we need to use a regulator so that
i2c-TDA7802:00 doesn't turn off the PLLen which i2c-TDA7802:01 still
requires.

This is why we use a regulator. Is there GPIO support for this?

Thanks,
Thomas
