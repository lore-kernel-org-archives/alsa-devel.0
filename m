From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802
 amplifier
Date: Tue, 30 Jul 2019 15:10:00 +0100
Message-ID: <16dff5b4-6a94-42de-85d4-0f4ec01fac8c@codethink.co.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
 <20190730122748.GF54126@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730122748.GF54126@ediswmail.ad.cirrus.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Marco Felsch <m.felsch@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org, Nate Case <ncase@tesla.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Annaliese McDermond <nh6z@nh6z.net>, Rob Duncan <rduncan@tesla.com>, Patrick Glaser <pglaser@tesla.com>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 30/07/2019 13:27, Charles Keepax wrote:
> On Tue, Jul 30, 2019 at 01:09:35PM +0100, Thomas Preston wrote:
>> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
>> Cc: Patrick Glaser <pglaser@tesla.com>
>> Cc: Rob Duncan <rduncan@tesla.com>
>> Cc: Nate Case <ncase@tesla.com>
>> ---
>>  .../devicetree/bindings/sound/tda7802.txt     | 26 +++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
>> new file mode 100644
>> index 000000000000..f80aaf4f1ba0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
>> @@ -0,0 +1,26 @@
>> +ST TDA7802 audio processor
>> +
>> +This device supports I2C only.
>> +
>> +Required properties:
>> +
>> +- compatible : "st,tda7802"
>> +- reg : the I2C address of the device
>> +- enable-supply : a regulator spec for the PLLen pin
>> +
>> +Optional properties:
>> +
>> +- st,gain-ch13 : gain for channels 1 and 3 (range: 1-4)
>> +- st,gain-ch24 : gain for channels 2 and 3 (range: 1-4)
> 
> I wouldn't have expected the gains to be available as a device
> tree setting.
> 

Ah, I forgot to update the docs from v1. Thanks
