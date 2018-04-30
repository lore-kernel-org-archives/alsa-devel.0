From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 02/11] ASoC: amd: dma config parameters
	changes
Date: Mon, 30 Apr 2018 13:39:40 +0530
Message-ID: <4ee36e1e-2557-2624-b291-37962f062372@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-2-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omBgTPJMB0V5s_K8cYtg+koB_-HBdy33kcRCAe4deEK-Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0067.outbound.protection.outlook.com [104.47.38.67])
 by alsa0.perex.cz (Postfix) with ESMTP id ACD96266EB0
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 10:07:17 +0200 (CEST)
In-Reply-To: <CAGS+omBgTPJMB0V5s_K8cYtg+koB_-HBdy33kcRCAe4deEK-Gw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>, jclinton@chromium.org, Mark Brown <broonie@kernel.org>, alexander.deucher@amd.com, Guenter Roeck <linux@roeck-us.net>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org



On Monday 30 April 2018 03:19 AM, Daniel Kurtz wrote:
> Hi Vijendar,
> 
> On Thu, Apr 26, 2018 at 5:14 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Added dma configuration parameters to rtd structure.
>> Moved dma configuration parameters intialization to
>> hw_params callback.
>> Removed hard coding in prepare and trigger callbacks.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>     sound/soc/amd/acp-pcm-dma.c | 97
> +++++++++++++++++----------------------------
>>     sound/soc/amd/acp.h         |  5 +++
>>     2 files changed, 41 insertions(+), 61 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index 9c026c4..f18ed9a 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -321,19 +321,12 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                               u32 asic_type)
>>     {
>>            u32 pte_offset, sram_bank;
>> -       u16 ch1, ch2, destination, dma_dscr_idx;
> 
>>            if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
>>                    pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
>> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
>>                    sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
>> -               destination = TO_ACP_I2S_1;
>> -
>>            } else {
>>                    pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
>> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
> 
> Wait... since this is the capture stream, shouldn't the channels have been:
> 
>      ch1 = ACP_TO_SYSRAM_CH_NUM; /* 14 */
>      ch2 = I2S_TO_ACP_DMA_CH_NUM; /* 15 */
> 
> Is this an existing bug?  Why does everything still work if these are wrong?
You are correct. We Will fix it and share fresh patch.
> 
>>                    switch (asic_type) {
>>                    case CHIP_STONEY:
>>                            sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
>> @@ -341,30 +334,19 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                    default:
>>                            sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
>>                    }
>> -               destination = FROM_ACP_I2S_1;
>>            }
>> -
>>            acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
>>                           pte_offset);
>> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
>> -       else
>> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
>> -
>>            /* Configure System memory <-> ACP SRAM DMA descriptors */
>>            set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
>> -                                      rtd->direction, pte_offset, ch1,
>> -                                      sram_bank, dma_dscr_idx,
> asic_type);
>> -
>> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
>> -       else
>> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
>> +                                      rtd->direction, pte_offset,
>> +                                      rtd->ch1, sram_bank,
>> +                                      rtd->dma_dscr_idx_1, asic_type);
>>            /* Configure ACP SRAM <-> I2S DMA descriptors */
>>            set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
>>                                           rtd->direction, sram_bank,
>> -                                      destination, ch2, dma_dscr_idx,
>> -                                      asic_type);
>> +                                      rtd->destination, rtd->ch2,
>> +                                      rtd->dma_dscr_idx_2, asic_type);
>>     }
> 
>>     /* Start a given DMA channel transfer */
>> @@ -804,6 +786,21 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>                    acp_reg_write(val, adata->acp_mmio,
>>                                  mmACP_I2S_16BIT_RESOLUTION_EN);
>>            }
>> +
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> +               rtd->destination = TO_ACP_I2S_1;
>> +               rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
>> +               rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
>> +       } else {
>> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> +               rtd->destination = FROM_ACP_I2S_1;
>> +               rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
>> +               rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
>> +       }
>> +
> 
> I think you should do this initialization in acp_dma_open(), where the
> audio_substream_data is kzalloc'ed and otherwise initialized to match the
> provided snd_pcm_substream.

The idea to move initialization from acp_dma_open() to 
acp_dma_hw_params() callback is to exchange platform data between 
machine driver and dma driver.
So that during initialization we can use data from machine driver and do
platform specific initialization where and when required.
In Current scenario, by the time new stream open call invoked, dma 
driver is not aware of which i2s_instance sub stream refers to .
We have added logic in machine driver to pass I2S instance information 
as sound card private data in subsequent patch.
We implemented logic to set the I2S Instance value in Codec startup 
api's in machine driver.
If we do initialization in dma driver open call , its not possible to 
extend the idea of switching between two i2s instances.

> 
>>            size = params_buffer_bytes(params);
>>            status = snd_pcm_lib_malloc_pages(substream, size);
>>            if (status < 0)
>> @@ -898,21 +895,15 @@ static int acp_dma_prepare(struct snd_pcm_substream
> *substream)
> 
>>            if (!rtd)
>>                    return -EINVAL;
>> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               config_acp_dma_channel(rtd->acp_mmio,
> SYSRAM_TO_ACP_CH_NUM,
>> -                                      PLAYBACK_START_DMA_DESCR_CH12,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -               config_acp_dma_channel(rtd->acp_mmio,
> ACP_TO_I2S_DMA_CH_NUM,
>> -                                      PLAYBACK_START_DMA_DESCR_CH13,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -       } else {
>> -               config_acp_dma_channel(rtd->acp_mmio,
> ACP_TO_SYSRAM_CH_NUM,
>> -                                      CAPTURE_START_DMA_DESCR_CH14,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -               config_acp_dma_channel(rtd->acp_mmio,
> I2S_TO_ACP_DMA_CH_NUM,
>> -                                      CAPTURE_START_DMA_DESCR_CH15,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -       }
>> +
>> +       config_acp_dma_channel(rtd->acp_mmio,
>> +                              rtd->ch1,
>> +                              rtd->dma_dscr_idx_1,
>> +                              NUM_DSCRS_PER_CHANNEL, 0);
>> +       config_acp_dma_channel(rtd->acp_mmio,
>> +                              rtd->ch2,
> 
> The original code was using ACP_TO_SYSRAM_CH_NUM for the capture case, but
> now you are using SYSRAM_TO_ACP_CH_NUM as just initialized in
> acp_dma_hw_params().  I think the old config_acp_dma() was wrong, and it
> should still be ACP_TO_SYSRAM_CH_NUM.  When you make this fix, either do it
> in a separate preliminary patch (preferred), or at least call it out in the
> commit message.
> 

You are correct. We will fix it and will post fresh patch.

> Also, instead of "ch1" and "ch2", perhaps we can use the more descriptive
> "ch_i2s" and "ch_sysram" [and same for dma_descr].
If we change ch1, ch2 channels naming convention , it will be quite 
confusing in rest of code.
playback use case ch1 refers to sysram to acp and ch2 refers to acp to 
i2s fifo where as for capture ch1 refers to acp to sysram and ch2 refers
to i2s to acp.
Rather than we will add comment what ch1, ch2 refers to improve readability.
same applies for dma descriptor idx also.
> 
>> +                              rtd->dma_dscr_idx_2,
>> +                              NUM_DSCRS_PER_CHANNEL, 0);
>>            return 0;
>>     }
> 
>> @@ -939,10 +930,9 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>                            if (rtd->i2ssp_renderbytescount == 0)
>>                                    rtd->i2ssp_renderbytescount = bytescount;
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     SYSRAM_TO_ACP_CH_NUM, false);
>> +                       acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
>>                            while (acp_reg_read(rtd->acp_mmio,
> mmACP_DMA_CH_STS) &
>> -
> BIT(SYSRAM_TO_ACP_CH_NUM)) {
>> +                               BIT(rtd->ch1)) {
>>                                    if (!loops--) {
>>                                            dev_err(component->dev,
>>                                                    "acp dma start
> timeout\n");
>> @@ -950,38 +940,23 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                                    }
>>                                    cpu_relax();
>>                            }
>> -
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     ACP_TO_I2S_DMA_CH_NUM, true);
>> -
>>                    } else {
>>                            if (rtd->i2ssp_capturebytescount == 0)
>>                                    rtd->i2ssp_capturebytescount =
> bytescount;
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     I2S_TO_ACP_DMA_CH_NUM, true);
>>                    }
>> +               acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>>                    ret = 0;
>>                    break;
>>            case SNDRV_PCM_TRIGGER_STOP:
>>            case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>            case SNDRV_PCM_TRIGGER_SUSPEND:
>> -               /*
>> -                * Need to stop only circular DMA channels :
>> -                * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM.
> Non-circular
>> -                * channels will stopped automatically after its transfer
>> -                * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
>> -                */
>>                    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          SYSRAM_TO_ACP_CH_NUM);
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          ACP_TO_I2S_DMA_CH_NUM);
>> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>> +                       ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>>                            rtd->i2ssp_renderbytescount = 0;
>>                    } else {
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          I2S_TO_ACP_DMA_CH_NUM);
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          ACP_TO_SYSRAM_CH_NUM);
>> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>> +                       ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
> 
> Using "ch_i2s" and "ch_sysram" would help here, since then it wouldn't need
> to do the slightly confusing "stop 2 then stop 1".

same comments apply as mentioned in above review comment.
> 
> -Dan
> 
> 
>>                            rtd->i2ssp_capturebytescount = 0;
>>                    }
>>                    break;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 0e6089b..5e25428 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -85,6 +85,11 @@ struct audio_substream_data {
>>            unsigned int order;
>>            u16 num_of_pages;
>>            u16 direction;
>> +       u16 ch1;
>> +       u16 ch2;
>> +       u16 destination;
>> +       u16 dma_dscr_idx_1;
>> +       u16 dma_dscr_idx_2;
>>            uint64_t size;
>>            u64 i2ssp_renderbytescount;
>>            u64 i2ssp_capturebytescount;
>> --
>> 2.7.4
