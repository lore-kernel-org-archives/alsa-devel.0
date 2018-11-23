From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [alsa-devel] [Xen-devel][PATCH 3/3] ALSA: xen-front: Use Xen
 common shared buffer implementation
Date: Fri, 23 Nov 2018 10:19:38 +0200
Message-ID: <a5a5754f-0a1d-d537-feaa-8f4ff4e203e3@gmail.com>
References: <20181122100230.14976-1-andr2000@gmail.com>
 <20181122100230.14976-3-andr2000@gmail.com> <s5hzhu13yil.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzhu13yil.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, jgross@suse.com, boris.ostrovsky@oracle.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 11/22/18 5:47 PM, Takashi Iwai wrote:
> On Thu, 22 Nov 2018 11:02:30 +0100,
> Oleksandr Andrushchenko wrote:
>> @@ -214,12 +221,19 @@ static void stream_clear(struct xen_snd_front_pcm_stream_info *stream)
>>   	stream->out_frames = 0;
>>   	atomic_set(&stream->hw_ptr, 0);
>>   	xen_snd_front_evtchnl_pair_clear(stream->evt_pair);
>> -	xen_snd_front_shbuf_clear(&stream->sh_buf);
>> +	memset(&stream->shbuf, 0, sizeof(stream->shbuf));
>> +	stream->buffer = NULL;
>> +	stream->buffer_sz = 0;
>> +	stream->pages = NULL;
>> +	stream->num_pages = 0;
>>   }
>>   
>>   static void stream_free(struct xen_snd_front_pcm_stream_info *stream)
>>   {
>> -	xen_snd_front_shbuf_free(&stream->sh_buf);
>> +	xen_front_pgdir_shbuf_unmap(&stream->shbuf);
>> +	xen_front_pgdir_shbuf_free(&stream->shbuf);
>> +	free_pages_exact(stream->buffer, stream->buffer_sz);
>> +	kfree(stream->pages);
>>   	stream_clear(stream);
>>   }
>>   
>> @@ -421,10 +435,34 @@ static int alsa_close(struct snd_pcm_substream *substream)
>>   	return 0;
>>   }
>>   
>> +static int shbuf_setup_backstore(struct xen_snd_front_pcm_stream_info *stream,
>> +				 size_t buffer_sz)
>> +{
>> +	int i;
>> +
>> +	stream->buffer_sz = buffer_sz;
>> +	stream->buffer = alloc_pages_exact(stream->buffer_sz, GFP_KERNEL);
>> +	if (!stream->buffer)
>> +		return -ENOMEM;
> This keeps the NULL stream->buffer, and then the caller goes to the
> error path via stream_free() which will lead to an Oops due to the
> unconditional call of free_pages_exact().

You are absolutely right, will fix

Thank you for catching this

>
>
> thanks,
>
> Takashi
