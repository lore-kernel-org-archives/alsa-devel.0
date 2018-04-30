From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 05/11] ASoC: amd: pte offset related dma
	driver changes
Date: Mon, 30 Apr 2018 13:49:56 +0530
Message-ID: <fc57902b-1610-52d2-914f-c2539a9fab69@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-5-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omAH+W0yRxS4F42LOyVhKR3mTsNA1wXP-RQFr-BF6f_JJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0083.outbound.protection.outlook.com [104.47.40.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C73B267230
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 10:17:35 +0200 (CEST)
In-Reply-To: <CAGS+omAH+W0yRxS4F42LOyVhKR3mTsNA1wXP-RQFr-BF6f_JJA@mail.gmail.com>
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



On Monday 30 April 2018 03:18 AM, Daniel Kurtz wrote:
> On Thu, Apr 26, 2018 at 5:16 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Added pte offset variable in audio_substream_data structure.
>> Added Stoney related PTE offset macros in acp header file.
>> Modified hw_params callback to assign the pte offset value
>> based on asic_type.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>    sound/soc/amd/acp-pcm-dma.c | 26 +++++++++++++++++++-------
>>    sound/soc/amd/acp.h         |  5 +++++
>>    2 files changed, 24 insertions(+), 7 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index 5f34be1..cb22653 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -320,13 +320,11 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                              struct audio_substream_data *rtd,
>>                              u32 asic_type)
>>    {
>> -       u32 pte_offset, sram_bank;
>> +       u32 sram_bank;
> 
>> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> +       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>>                   sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
>> -       } else {
>> -               pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> +       else {
>>                   switch (asic_type) {
>>                   case CHIP_STONEY:
>>                           sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
>> @@ -336,10 +334,10 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                   }
>>           }
>>           acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
>> -                      pte_offset);
>> +                      rtd->pte_offset);
>>           /* Configure System memory <-> ACP SRAM DMA descriptors */
>>           set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
>> -                                      rtd->direction, pte_offset,
>> +                                      rtd->direction, rtd->pte_offset,
>>                                          rtd->ch1, sram_bank,
>>                                          rtd->dma_dscr_idx_1, asic_type);
>>           /* Configure ACP SRAM <-> I2S DMA descriptors */
>> @@ -788,6 +786,13 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>           }
> 
>>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +               switch (adata->asic_type) {
>> +               case CHIP_STONEY:
>> +                       rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
>> +                       break;
>> +               default:
>> +                       rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> +               }
> 
> As in patch 2, I believe this would be better done in acp_dma_open().
> 
> Why does Stoney use a different PTE_OFFSET?  Please answer this question in
> the commit message.
> 
> -Dan


We will modify commit message and post the fresh patch.

-Vijendar
> 
>>                   rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>>                   rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>>                   rtd->destination = TO_ACP_I2S_1;
>> @@ -797,6 +802,13 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>                   mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
>>                   rtd->byte_cnt_low_reg_offset =
> mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>>           } else {
>> +               switch (adata->asic_type) {
>> +               case CHIP_STONEY:
>> +                       rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
>> +                       break;
>> +               default:
>> +                       rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> +               }
>>                   rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>>                   rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>>                   rtd->destination = FROM_ACP_I2S_1;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 82470bc..2f48d1d 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -10,6 +10,10 @@
>>    #define ACP_PLAYBACK_PTE_OFFSET                        10
>>    #define ACP_CAPTURE_PTE_OFFSET                 0
> 
>> +/* Playback and Capture Offset for Stoney */
>> +#define ACP_ST_PLAYBACK_PTE_OFFSET     0x04
>> +#define ACP_ST_CAPTURE_PTE_OFFSET      0x00
>> +
>>    #define ACP_GARLIC_CNTL_DEFAULT                        0x00000FB4
>>    #define ACP_ONION_CNTL_DEFAULT                 0x00000FB4
> 
>> @@ -90,6 +94,7 @@ struct audio_substream_data {
>>           u16 destination;
>>           u16 dma_dscr_idx_1;
>>           u16 dma_dscr_idx_2;
>> +       u32 pte_offset;
>>           u32 byte_cnt_high_reg_offset;
>>           u32 byte_cnt_low_reg_offset;
>>           uint64_t size;
>> --
>> 2.7.4
