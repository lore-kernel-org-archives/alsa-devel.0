From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 07/11] IIO: consumer: allow to set
	buffer sizes
Date: Mon, 20 Mar 2017 12:30:48 +0100
Message-ID: <b2715233-63e7-4c9d-49fc-ad6ca8be0d75@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-8-git-send-email-arnaud.pouliquen@st.com>
 <951c19fa-d3b8-f4cd-cac1-64e3b8d1cf01@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id E887B266DAC
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 12:30:51 +0100 (CET)
In-Reply-To: <951c19fa-d3b8-f4cd-cac1-64e3b8d1cf01@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Olivier MOYSAN <olivier.moysan@st.com>, "kernel@stlinux.com" <kernel@stlinux.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre TORGUE <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org



On 03/19/2017 11:44 PM, Jonathan Cameron wrote:
> On 17/03/17 14:08, Arnaud Pouliquen wrote:
>> Add iio consumer API to set buffer size and watermark according
>> to sysfs API.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Hmm. Not keen on the length one.  Setting a requested watermark
> is fair enough.  There is no actually buffer in these cases though
> so setting it's length is downright odd..
Length and watermark are configurable from user land through sysfs.
Seems to me logic to also propose it in inkern API...
But I can clean length , no problem.

> 
> Guess this is part of the hacks we need to clean up by doing
> the dma buffer consumer stuff right...
Yes all is linked :-).

> 
> Jonathan
>> ---
>>  drivers/iio/buffer/industrialio-buffer-cb.c | 12 ++++++++++++
>>  include/linux/iio/consumer.h                | 13 +++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
>> index b8f550e..43c066a 100644
>> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
>> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
>> @@ -103,6 +103,18 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
>>  
>> +int iio_channel_cb_set_buffer_params(struct iio_cb_buffer *cb_buff,
>> +				      size_t length, size_t watermark)
>> +{
>> +	if (!length || length < watermark)
>> +		return -EINVAL;
>> +	cb_buff->buffer.watermark = watermark;
>> +	cb_buff->buffer.length = length;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
>> +
>>  int iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
>>  {
>>  	return iio_update_buffers(cb_buff->indio_dev, &cb_buff->buffer,
>> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
>> index cb44771..0f6e94d 100644
>> --- a/include/linux/iio/consumer.h
>> +++ b/include/linux/iio/consumer.h
>> @@ -134,6 +134,19 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>>  						       void *private),
>>  					     void *private);
>>  /**
>> + * iio_channel_cb_set_buffer_size() - set the buffer length.
>> + * @cb_buffer:		The callback buffer from whom we want the channel
>> + *			information.
>> + * @length: buffer length in bytes
>> + * @watermark: buffer watermark in bytes
>> + *
>> + * This function allows to configure the buffer length. The watermark if
>> + * forced to half of the buffer.
>> + */
>> +int iio_channel_cb_set_buffer_params(struct iio_cb_buffer *cb_buffer,
>> +				     size_t length, size_t watermark);
>> +
>> +/**
>>   * iio_channel_release_all_cb() - release and unregister the callback.
>>   * @cb_buffer:		The callback buffer that was allocated.
>>   */
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
