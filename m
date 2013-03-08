From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Fri, 08 Mar 2013 14:11:32 +0100
Message-ID: <5139E384.2090005@gmail.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1799126171E
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 14:11:33 +0100 (CET)
Received: by mail-ee0-f41.google.com with SMTP id c13so1039613eek.28
 for <alsa-devel@alsa-project.org>; Fri, 08 Mar 2013 05:11:32 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

Hi Vaibhav,
Hi Michal,

On 05.03.2013 12:06, Bedia, Vaibhav wrote:
> On Wed, Feb 27, 2013 at 22:08:45, Michal Bachraty wrote:
>> Davinci McASP has support for I2S multichannel playback.
>> For I2S playback/receive, each serializer is capable to play 2 channels
>> (L/R) audio data.Serializer function (Playback-receive-none) is configured
>> in DT, depending on hardware specification. It is possible to play less
>> channels than configured in DT. For that purpose,only specific number of
>> active serializers are enabled. McASP FIFO need to have DMA transfer Bcnt
>> set to number of enabled serializers, otherwise no data are transfered to
>> McASP and Alsa generates "DMA/IRQ playback write error (DMA or IRQ trouble?)"
>> error.
>>
> 
> Thanks for looking into this. Before going into details, a few generic comments.
> All serializers configured in Tx (or Rx) work off common clock generators and
> hence the serializers will be operating in sync. I assume the setup that you
> have matches this requirement. Based on the DMA programming assumed in the
> implementation the user needs to ensure that buffer has the data in the right
> format. Can you please describe the setup that you have and how you tested this? 
> 
>> Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
>> ---
>>  sound/soc/davinci/davinci-mcasp.c |   56 ++++++++++++++++++++++++++++++++-----
>>  sound/soc/davinci/davinci-pcm.c   |   16 ++++++-----
>>  sound/soc/davinci/davinci-pcm.h   |    1 +
>>  3 files changed, 59 insertions(+), 14 deletions(-)
>>
>> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
>> index afef3fb..b84bb73 100644
>> --- a/sound/soc/davinci/davinci-mcasp.c
>> +++ b/sound/soc/davinci/davinci-mcasp.c
>> @@ -235,6 +235,10 @@
>>  #define DISMOD		(val)(val<<2)
>>  #define TXSTATE		BIT(4)
>>  #define RXSTATE		BIT(5)
>> +#define SRMOD_MASK	3
>> +#define SRMOD_INACTIVE	0
>> +#define SRMOD_TX	1
>> +#define SRMOD_RX	2
> 
> I don't see SRMOD_TX/RX being used anywhere.
> 
>>  
>>  /*
>>   * DAVINCI_MCASP_LBCTL_REG - Loop Back Control Register Bits
>> @@ -657,12 +661,15 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
>>  	return 0;
>>  }
>>  
>> -static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
>> +static int davinci_hw_common_param(struct davinci_audio_dev *dev, int stream,
>> +				    int channels)
>>  {
>>  	int i;
>>  	u8 tx_ser = 0;
>>  	u8 rx_ser = 0;
>> -
>> +	u8 ser;
>> +	u8 slots = dev->tdm_slots;
>> +	u8 max_active_serializers = (channels + slots - 1) / slots;
>>  	/* Default configuration */
>>  	mcasp_set_bits(dev->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
>>  
>> @@ -680,16 +687,42 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
>>  	}
>>  
>>  	for (i = 0; i < dev->num_serializer; i++) {
>> +		if (dev->serial_dir[i] == TX_MODE)
>> +			tx_ser++;
>> +		if (dev->serial_dir[i] == RX_MODE)
>> +			rx_ser++;
>> +	}
>> +
>> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +		ser = tx_ser;
>> +	else
>> +		ser = rx_ser;
>> +
>> +	if (ser < max_active_serializers) {
>> +		dev_warn(dev->dev, "stream has more channels (%d) than are "
>> +			"enabled in mcasp (%d)\n", channels, ser * slots);
>> +		return -EINVAL;
>> +	}
>> +
>> +	tx_ser = 0;
>> +	rx_ser = 0;
> 
> The number of active serializers is already being calculated below.

FWIW, I'm now sending a cleanup patch for the two details I quoted
above. With those out of the way, the rest (namely the dst_bidx issue)
can be solved separately.

Please have a look and tell me if you're ok with that.


Thanks for your review!

Daniel
