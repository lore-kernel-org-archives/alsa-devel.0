From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 02/18] ASoC: omap-mcpdm: Assign the dai DMA
 data at earlier time
Date: Wed, 16 Apr 2014 14:23:17 +0200
Message-ID: <534E7635.7050302@metafoo.de>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
 <1397640211-15447-3-git-send-email-peter.ujfalusi@ti.com>
 <20140416101535.GQ12304@sirena.org.uk> <534E5A9B.4050900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-049.synserver.de
 [212.40.185.49])
 by alsa0.perex.cz (Postfix) with ESMTP id F217026525F
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:23:18 +0200 (CEST)
In-Reply-To: <534E5A9B.4050900@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, notasas@gmail.com, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/16/2014 12:25 PM, Peter Ujfalusi wrote:
> On 04/16/2014 01:15 PM, Mark Brown wrote:
>> On Wed, Apr 16, 2014 at 12:23:15PM +0300, Peter Ujfalusi wrote:
>>
>>> -	snd_soc_dai_set_dma_data(dai, substream,
>>> -				 &mcpdm->dma_data[substream->stream]);
>>> -
>>>   	return 0;
>>>   }
>>>
>>> @@ -406,6 +403,10 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
>>>   	mcpdm->config[SNDRV_PCM_STREAM_PLAYBACK].threshold = 2;
>>>   	mcpdm->config[SNDRV_PCM_STREAM_CAPTURE].threshold =
>>>   							MCPDM_UP_THRES_MAX - 3;
>>> +
>>> +	dai->playback_dma_data = &mcpdm->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
>>> +	dai->capture_dma_data = &mcpdm->dma_data[SNDRV_PCM_STREAM_CAPTURE];
>>> +
>>
>> Any reason to stop using _set_dma_data()?
>
> At dai driver probe we do not have substream and snd_soc_dai_set_dma_data()
> relies on that (substream->stream) to figure out which dma_data to set.
>

You can use snd_soc_dai_init_dma_data(). Not that it saves much code, but it 
hides the implementation, which makes it easier to change things if we ever 
have to.

- Lars
