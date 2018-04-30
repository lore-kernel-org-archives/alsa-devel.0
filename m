From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 04/11] ASoC: amd: removed separate byte
 count variables for playback and capture
Date: Mon, 30 Apr 2018 12:55:43 +0530
Message-ID: <e8f39d50-360e-cd66-aba7-8fd1aade6f49@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-4-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omA4DNm7HZZUpRBJfhhY-GYGaQRU1KWBb-CTuO7qGwTXCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0052.outbound.protection.outlook.com [104.47.33.52])
 by alsa0.perex.cz (Postfix) with ESMTP id C4007266EB0
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 09:23:09 +0200 (CEST)
In-Reply-To: <CAGS+omA4DNm7HZZUpRBJfhhY-GYGaQRU1KWBb-CTuO7qGwTXCw@mail.gmail.com>
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
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: kstewart@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>, jclinton@chromium.org, Mark Brown <broonie@kernel.org>, pombredanne@nexb.com, alexander.deucher@amd.com, Guenter Roeck <linux@roeck-us.net>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org



On Monday 30 April 2018 03:11 AM, Daniel Kurtz wrote:
> Hi Vijendar,
> 
> On Thu, Apr 26, 2018 at 5:15 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Removed separate byte count variables for playback and capture.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> 
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
>> ---
>>    sound/soc/amd/acp-pcm-dma.c | 19 +++++--------------
>>    sound/soc/amd/acp.h         |  3 +--
>>    2 files changed, 6 insertions(+), 16 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index 019f696..5f34be1 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -866,13 +866,8 @@ static snd_pcm_uframes_t acp_dma_pointer(struct
> snd_pcm_substream *substream)
>>           buffersize = frames_to_bytes(runtime, runtime->buffer_size);
>>           bytescount = acp_get_byte_count(rtd);
> 
>> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               if (bytescount > rtd->i2ssp_renderbytescount)
>> -                       bytescount = bytescount -
> rtd->i2ssp_renderbytescount;
>> -       } else {
>> -               if (bytescount > rtd->i2ssp_capturebytescount)
>> -                       bytescount = bytescount -
> rtd->i2ssp_capturebytescount;
>> -       }
>> +       if (bytescount > rtd->bytescount)
>> +               bytescount = bytescount - rtd->bytescount;
> 
> nit, this could be:
> bytescount -= rtd->bytescount;

we will fix it and will share fresh patch.
> 
>>           pos = do_div(bytescount, buffersize);
>>           return bytes_to_frames(runtime, pos);
>>    }
>> @@ -921,9 +916,9 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>           case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>           case SNDRV_PCM_TRIGGER_RESUME:
>>                   bytescount = acp_get_byte_count(rtd);
>> +               if (rtd->bytescount == 0)
>> +                       rtd->bytescount = bytescount;
>>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -                       if (rtd->i2ssp_renderbytescount == 0)
>> -                               rtd->i2ssp_renderbytescount = bytescount;
>>                           acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
>>                           while (acp_reg_read(rtd->acp_mmio,
> mmACP_DMA_CH_STS) &
>>                                   BIT(rtd->ch1)) {
>> @@ -934,9 +929,6 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                                   }
>>                                   cpu_relax();
>>                           }
>> -               } else {
>> -                       if (rtd->i2ssp_capturebytescount == 0)
>> -                               rtd->i2ssp_capturebytescount = bytescount;
>>                   }
>>                   acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>>                   ret = 0;
>> @@ -947,12 +939,11 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>                           acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>>                           ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>> -                       rtd->i2ssp_renderbytescount = 0;
>>                   } else {
>>                           acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>>                           ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>> -                       rtd->i2ssp_capturebytescount = 0;
>>                   }
>> +               rtd->bytescount = 0;
>>                   break;
>>           default:
>>                   ret = -EINVAL;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 3b076c6..82470bc 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -93,8 +93,7 @@ struct audio_substream_data {
>>           u32 byte_cnt_high_reg_offset;
>>           u32 byte_cnt_low_reg_offset;
>>           uint64_t size;
>> -       u64 i2ssp_renderbytescount;
>> -       u64 i2ssp_capturebytescount;
>> +       u64 bytescount;
>>           void __iomem *acp_mmio;
>>    };
> 
>> --
>> 2.7.4
