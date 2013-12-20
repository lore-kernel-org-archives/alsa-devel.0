From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 08/19] ASoC: kirkwood: Don't set unused
 struct snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 18:18:49 +0100
Message-ID: <52B47BF9.9030408@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-8-git-send-email-lars@metafoo.de>
 <20131220190506.2adb7a52@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-132.synserver.de
 [212.40.185.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 80D492616FB
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 19:23:30 +0100 (CET)
In-Reply-To: <20131220190506.2adb7a52@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/20/2013 07:05 PM, Jean-Francois Moine wrote:
> On Fri, 20 Dec 2013 14:20:14 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> The ASoC core assumes that the PCM component of the ASoC card transparently
>> moves data around and does not impose any restrictions on the memory layout or
>> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
>> the PCM driver that are related to this. Setting these fields in the PCM driver
>> might suggest otherwise though, so rather not set them.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Jean-Francois Moine <moinejf@free.fr>
>> ---
>>  sound/soc/kirkwood/kirkwood-dma.c | 16 ----------------
>>  1 file changed, 16 deletions(-)
>>
>> diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
>> index 4af1936..aac22fc 100644
>> --- a/sound/soc/kirkwood/kirkwood-dma.c
>> +++ b/sound/soc/kirkwood/kirkwood-dma.c
> 	[snip]
>> @@ -43,12 +33,6 @@ static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
>>  		 SNDRV_PCM_INFO_MMAP_VALID |
>>  		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>  		 SNDRV_PCM_INFO_PAUSE),
>> -	.formats		= KIRKWOOD_FORMATS,
>> -	.rates			= KIRKWOOD_RATES,
>> -	.rate_min		= 8000,
>> -	.rate_max		= 384000,
>> -	.channels_min		= 1,
>> -	.channels_max		= 8,
>>  	.buffer_bytes_max	= KIRKWOOD_SND_MAX_BUFFER_BYTES,
>>  	.period_bytes_min	= KIRKWOOD_SND_MIN_PERIOD_BYTES,
>>  	.period_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES,
> 
> Lars,
> 
> You removed too many things. The 'formats' field is mandatory.

No it is not. While snd_soc_set_runtime_hwparams() uses it it is later
overwritten again in soc_pcm_init_runtime_hw().

- Lars
