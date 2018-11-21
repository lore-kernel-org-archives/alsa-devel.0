From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 2/6] ASoC: Intel: Skylake: stop init/probe if DSP is
 not present
Date: Wed, 21 Nov 2018 10:48:57 -0600
Message-ID: <1d06c878-c69b-a627-b7e6-e9d92be3b08a@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
 <20181120213644.19103-3-pierre-louis.bossart@linux.intel.com>
 <20181121142925.GP10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121142925.GP10650@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, liam.r.girdwood@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 11/21/18 8:29 AM, Andy Shevchenko wrote:
> On Tue, Nov 20, 2018 at 03:36:40PM -0600, Pierre-Louis Bossart wrote:
>> Check immediately if the DSP can be found, bail and avoid doing inits
>> to enable legacy fallback without delay.
> It does slightly more than described. Please do either remove unrelated changes, or fill the gap in the commit message. In the latter case it may require to split patch to two.
ok, maybe I should change the commit message since there are really two 
test conditions: DSP can be found and DSP streams found. The code really 
does just that, nothing else.
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/intel/skylake/skl.c | 26 +++++++++++++++++---------
>>   1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
>> index df36b8fe6d5e..1d7146773d19 100644
>> --- a/sound/soc/intel/skylake/skl.c
>> +++ b/sound/soc/intel/skylake/skl.c
>> @@ -931,6 +931,12 @@ static int skl_first_init(struct hdac_bus *bus)
>>   
>>   	snd_hdac_bus_parse_capabilities(bus);
>>   
>> +	/* check if dsp is there */
>> +	if (!bus->ppcap) {
>> +		dev_err(bus->dev, "bus ppcap not set, DSP not present?\n");
>> +		return -ENODEV;
>> +	}
>> +
>>   	if (skl_acquire_irq(bus, 0) < 0)
>>   		return -EBUSY;
>>   
>> @@ -940,23 +946,25 @@ static int skl_first_init(struct hdac_bus *bus)
>>   	gcap = snd_hdac_chip_readw(bus, GCAP);
>>   	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
>>   
>> -	/* allow 64bit DMA address if supported by H/W */
>> -	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
>> -		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
>> -	} else {
>> -		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
>> -		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
>> -	}
>> -
>>   	/* read number of streams from GCAP register */
>>   	cp_streams = (gcap >> 8) & 0x0f;
>>   	pb_streams = (gcap >> 12) & 0x0f;
>>   
>> -	if (!pb_streams && !cp_streams)
>> +	if (!pb_streams && !cp_streams) {
>> +		dev_err(bus->dev, "no streams found in GCAP definitions?\n");
>>   		return -EIO;
>> +	}
>>   
>>   	bus->num_streams = cp_streams + pb_streams;
>>   
>> +	/* allow 64bit DMA address if supported by H/W */
>> +	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
>> +		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
>> +	} else {
>> +		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
>> +		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
>> +	}
>> +
>>   	/* initialize streams */
>>   	snd_hdac_ext_stream_init_all
>>   		(bus, 0, cp_streams, SNDRV_PCM_STREAM_CAPTURE);
>> -- 
>> 2.17.1
>>
