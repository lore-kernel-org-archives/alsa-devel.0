From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] ASoC: Add pcm9211 driver
Date: Wed, 24 May 2017 09:44:30 +0200
Message-ID: <553d176f-e32f-821d-a1fc-0313c3291d62@jusst.de>
References: <20170523090931.9697-1-julian@jusst.de>
 <20170523211624.GA3245@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web01.jusst.de (jusst.de [188.40.114.84])
 by alsa0.perex.cz (Postfix) with ESMTP id EDE5F265142
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 09:44:28 +0200 (CEST)
In-Reply-To: <20170523211624.GA3245@us.netrek.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Cameron <quozl@laptop.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 23.05.2017 23:16, James Cameron wrote:
> On Tue, May 23, 2017 at 11:09:31AM +0200, Julian Scheel wrote:
>> This adds a driver for the TI PCM9211 digital audio interfaces
>> transceiver. The driver currently only handles the receiver aspect of
>> the chip and supports only control of the primary I2S (MAIN) output
>> port. Support for AUX output is trivial to add, but wasn't done due to
>> missing hardware for testing. The same goes for the transmitter
>> functionality.
>> The driver uses some extra device-tree fields to allow configuration of
>> pin functions directly out of this driver.
>>
>> Signed-off-by: Julian Scheel <julian@jusst.de>
>> ---
>>   .../devicetree/bindings/sound/pcm9211.txt          |  118 ++
>>   MAINTAINERS                                        |    6 +
>>   include/dt-bindings/sound/pcm9211.h                |   55 +
>>   sound/soc/codecs/Kconfig                           |   10 +
>>   sound/soc/codecs/Makefile                          |    4 +
>>   sound/soc/codecs/pcm9211-i2c.c                     |   65 +
>>   sound/soc/codecs/pcm9211.c                         | 1357 ++++++++++++++++++++
>>   sound/soc/codecs/pcm9211.h                         |  206 +++
>>   8 files changed, 1821 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/pcm9211.txt
>>   create mode 100644 include/dt-bindings/sound/pcm9211.h
>>   create mode 100644 sound/soc/codecs/pcm9211-i2c.c
>>   create mode 100644 sound/soc/codecs/pcm9211.c
>>   create mode 100644 sound/soc/codecs/pcm9211.h
>>
>> [...]
>> diff --git a/sound/soc/codecs/pcm9211.c b/sound/soc/codecs/pcm9211.c
>> new file mode 100644
>> index 000000000000..0ab4ad551df8
>> --- /dev/null
>> +++ b/sound/soc/codecs/pcm9211.c
>> @@ -0,0 +1,1357 @@
>> [...]
>> +int pcm9211_probe(struct device *dev, struct regmap *regmap)
>> +{
>> [...]
>> +	priv->int0 = devm_gpiod_get_optional(dev, "int0", GPIOD_IN);
>> +	if (IS_ERR(priv->reset)) {
>> +		ret = PTR_ERR(priv->reset);
>> +		dev_err(dev, "Failed to get reset gpio: %d\n", ret);
>> +		return ret;
>> +	}
> 
> In above block; reset should be int0, three lines affected.

Thanks, fixed for v2.
